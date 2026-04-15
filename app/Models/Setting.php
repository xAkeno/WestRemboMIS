<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    protected $fillable = ['key', 'value'];

    // Optional helper (clean usage)
    public static function get($key, $default = null)
    {
        return cache()->remember("setting_$key", 60, function () use ($key, $default) {
            return self::where('key', $key)->value('value') ?? $default;
        });
    }

    public static function set($key, $value)
    {
        cache()->forget("setting_$key");

        return self::updateOrCreate(
            ['key' => $key],
            ['value' => $value]
        );
    }
}