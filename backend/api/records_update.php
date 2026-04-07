<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/auth.php';

requireAuth();
$input = readJson();

$headerId = (int)($input['header_id'] ?? 0);
$entries = $input['entries'] ?? [];

if ($headerId <= 0 || !is_array($entries)) {
    jsonResponse(['ok' => false, 'message' => 'Datos inválidos'], 422);
}

$pdo = db();
$pdo->beginTransaction();

try {
    $pdo->prepare('DELETE FROM process_entries WHERE header_id = :header_id')->execute(['header_id' => $headerId]);

    $stmt = $pdo->prepare(
        'INSERT INTO process_entries
        (header_id, hour_mark, lot_number, ph_value, water_temp_c, turbidity_ntu, water_changed, water_liters, disinfectant_ml, concentration_ppm, observations, operator_initials, supervisor_name)
         VALUES
        (:header_id, :hour_mark, :lot_number, :ph_value, :water_temp_c, :turbidity_ntu, :water_changed, :water_liters, :disinfectant_ml, :concentration_ppm, :observations, :operator_initials, :supervisor_name)'
    );

    foreach ($entries as $entry) {
        $stmt->execute([
            'header_id' => $headerId,
            'hour_mark' => $entry['hour_mark'] ?? null,
            'lot_number' => $entry['lot_number'] ?? '',
            'ph_value' => $entry['ph_value'] ?? 0,
            'water_temp_c' => $entry['water_temp_c'] ?? 0,
            'turbidity_ntu' => $entry['turbidity_ntu'] ?? 0,
            'water_changed' => !empty($entry['water_changed']) ? 1 : 0,
            'water_liters' => $entry['water_liters'] ?? 0,
            'disinfectant_ml' => $entry['disinfectant_ml'] ?? 0,
            'concentration_ppm' => $entry['concentration_ppm'] ?? 0,
            'observations' => $entry['observations'] ?? '',
            'operator_initials' => $entry['operator_initials'] ?? '',
            'supervisor_name' => $entry['supervisor_name'] ?? '',
        ]);
    }

    $pdo->commit();
} catch (Throwable $e) {
    $pdo->rollBack();
    jsonResponse(['ok' => false, 'message' => 'No se pudo actualizar', 'error' => $e->getMessage()], 500);
}

jsonResponse(['ok' => true, 'message' => 'Registro actualizado']);
