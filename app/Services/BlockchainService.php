<?php

namespace App\Services;

use Web3\Web3;
use Web3\Contract;
use Web3p\EthereumTx\Transaction;

class BlockchainService
{
    protected $web3;
    protected $contract;
    protected $privateKey;
    protected $contractAddress;

    // 🔒 prevents nonce collisions inside same PHP process
    private static array $nonceCache = [];

    public function __construct()
    {
        $this->web3 = new Web3(new \Web3\Providers\HttpProvider(
            new \Web3\RequestManagers\HttpRequestManager(
                env('RPC_URL'),
                15
            )
        ));

        $this->privateKey = env('PRIVATE_KEY');
        $this->contractAddress = env('CONTRACT_ADDRESS');

        $abi = json_decode(file_get_contents(storage_path('app/abi.json')), true);

        $this->contract = new Contract($this->web3->provider, $abi);
    }

    public function logAudit($documentId, $action, $cid, $hash, $actor, $replaceNonce = null)
    {
        $data = $this->contract->at($this->contractAddress)
            ->getData('logAudit', $documentId, $action, $cid, $hash, $actor);

        $from = $this->getAddress();
        $txHash = null;

        $this->web3->eth->getTransactionCount($from, 'latest', function ($err, $nonce) use (&$data, &$txHash, $from, $replaceNonce) {

            if ($err) {
                throw new \Exception($err->getMessage());
            }

            // 🔥 nonce handling (safe + collision-free)
            $nonceInt = $replaceNonce !== null
                ? (int) $replaceNonce
                : (int) $nonce->toString();

            if (isset(self::$nonceCache[$from]) && $replaceNonce === null) {
                $nonceInt = self::$nonceCache[$from] + 1;
            }

            self::$nonceCache[$from] = $nonceInt;

            $nonceHex = '0x' . dechex($nonceInt);

            // 🔥 gas strategy (prevents replacement underpriced)
            $baseGas = 40 * 1e9; // 60 gwei
            $gasPrice = (int) ($baseGas * 1.30); // +30% buffer

            $transaction = [
                'nonce'    => $nonceHex,
                'from'     => $from,
                'to'       => $this->contractAddress,
                'value'    => '0x0',
                'data'     => $data,
                'chainId'  => 80002,
                'gas'      => '0x493E0', // 300,000 gas
                'gasPrice' => '0x' . dechex($gasPrice),
            ];

            $tx = new Transaction($transaction);
            $signed = '0x' . $tx->sign($this->privateKey);

            $this->web3->eth->sendRawTransaction($signed, function ($err, $hash) use (&$txHash) {

                if ($err) {
                    throw new \Exception($err->getMessage());
                }

                $txHash = $hash;
            });
        });

        // ⏳ wait for async response
        $waited = 0;
        while ($txHash === null && $waited < 8_000_000) {
            usleep(100000);
            $waited += 100000;
        }

        if (!$txHash) {
            throw new \Exception("Transaction not confirmed or timed out.");
        }

        return $txHash;
    }

    private function getAddress()
    {
        return env('WALLET_ADDRESS');
    }
}