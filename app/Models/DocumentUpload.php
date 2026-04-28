<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Storage;

class DocumentUpload extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'user_id',
        'category',
        'type',
        'original_filename',
        'mime_type',
        'file_size',
        's3_path',
        'is_required',
    ];

    protected $casts = [
        'is_required' => 'boolean',
        'file_size'   => 'integer',
    ];
 
    // ── Slot definitions (mirrors the React Hey frontend exactly) ──────────────────
    public const SLOTS = [
        'personal_id' => [
            'valid_id_front'      => ['label' => 'Valid Government ID (Front)', 'required' => true],
            'valid_id_back'       => ['label' => 'Valid Government ID (Back)',  'required' => false],
            'proof_of_residency'  => ['label' => 'Proof of Residency',          'required' => true],
            'supporting_document' => ['label' => 'Supporting Document',          'required' => false],
        ],
        'business' => [
            'dti_sec_registration'      => ['label' => 'DTI / SEC Registration',          'required' => true],
            'mayors_permit'             => ['label' => "Mayor's Business Permit",          'required' => true],
            'bir_certificate'           => ['label' => 'BIR Certificate of Registration', 'required' => true],
            'articles_of_incorporation' => ['label' => 'Articles of Incorporation',        'required' => false],
            'general_information_sheet' => ['label' => 'General Information Sheet (GIS)', 'required' => false],
        ],
        'building' => [
            'title_or_tct'    => ['label' => 'Transfer Certificate of Title (TCT)', 'required' => true],
            'tax_declaration'  => ['label' => 'Tax Declaration',                    'required' => true],
            'building_permit'  => ['label' => 'Building Permit',                    'required' => false],
            'occupancy_permit' => ['label' => 'Certificate of Occupancy',           'required' => false],
            'lot_plan'         => ['label' => 'Lot Plan / Survey Plan',             'required' => false],
        ],
    ];

    // S3 folder per category
    public const S3_FOLDERS = [
        'personal_id' => 'documents/personal_id',
        'business'    => 'documents/business',
        'building'    => 'documents/building',
    ];

    // ── Relationships ──────────────────────────────────────────────────────────
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    // ── Accessors ──────────────────────────────────────────────────────────────

    /** 15-minute signed S3 URL */
    public function getUrlAttribute(): string
    {
        return Storage::disk('s3')->temporaryUrl($this->s3_path, now()->addMinutes(15));
    }

    // ── Static helpers ─────────────────────────────────────────────────────────

    public static function categoryForType(string $type): ?string
    {
        foreach (self::SLOTS as $category => $slots) {
            if (array_key_exists($type, $slots)) {
                return $category;
            }
        }
        return null;
    }

    public static function isTypeRequired(string $type): bool
    {
        foreach (self::SLOTS as $slots) {
            if (isset($slots[$type])) {
                return $slots[$type]['required'];
            }
        }
        return false;
    }

    public static function labelForType(string $type): string
    {
        foreach (self::SLOTS as $slots) {
            if (isset($slots[$type])) {
                return $slots[$type]['label'];
            }
        }
        return $type;
    }

    public static function allRequiredUploaded(int $userId): bool
    {
        $required = [];
        foreach (self::SLOTS as $slots) {
            foreach ($slots as $type => $meta) {
                if ($meta['required']) {
                    $required[] = $type;
                }
            }
        }

        $uploaded = self::where('user_id', $userId)
            ->whereIn('type', $required)
            ->pluck('type')
            ->toArray();

        return count(array_diff($required, $uploaded)) === 0;
    }
}
