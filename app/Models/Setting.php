<?php

// app/Models/Setting.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    protected $fillable = ['key', 'value'];

    /**
     * Get a setting value, with optional in-process cache (1 hour).
     */
    public static function get($key, $default = null)
    {
        return cache()->remember("setting_$key", 60, function () use ($key, $default) {
            return self::where('key', $key)->value('value') ?? $default;
        });
    }

    /**
     * Upsert a setting value and bust the cache.
     */
    public static function set($key, $value)
    {
        cache()->forget("setting_$key");

        return self::updateOrCreate(
            ['key'   => $key],
            ['value' => $value]
        );
    }

    // ── Vacation helpers ──────────────────────────────────────────────────────

    /**
     * Return all vacation entries as a PHP array.
     */
    public static function vacations(): array
    {
        $raw = self::get('vacations', '[]');

        return json_decode($raw, true) ?? [];
    }

    /**
     * Return only vacations that are active and cover today's date.
     */
    public static function activeVacations(): array
    {
        $today = now()->toDateString();

        return array_values(array_filter(self::vacations(), function ($v) use ($today) {
            return !empty($v['active'])
                && (!empty($v['start']) && $v['start'] <= $today)
                && (!empty($v['end'])   && $v['end']   >= $today);
        }));
    }

    /**
     * Convenience: is any vacation active right now?
     */
    public static function isOnVacation(): bool
    {
        return count(self::activeVacations()) > 0;
    }
}