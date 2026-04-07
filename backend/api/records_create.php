<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/auth.php';

$user = requireAuth();
$input = readJson();

$header = $input['header'] ?? [];
$entries = $input['entries'] ?? [];

if (!is_array($header) || !is_array($entries) || count($entries) === 0) {
    jsonResponse(['ok' => false, 'message' => 'Datos incompletos'], 422);
}

$productionDate = (string)($header['production_date'] ?? '');
$shiftName = trim((string)($header['shift_name'] ?? ''));
$productName = trim((string)($header['product_name'] ?? 'Hipoclorito de Sodio'));
$applicationMethod = trim((string)($header['application_method'] ?? 'Inmersión'));
$weekLabel = trim((string)($header['week_label'] ?? ''));

if ($productionDate === '' || $shiftName === '') {
    jsonResponse(['ok' => false, 'message' => 'Fecha y turno son obligatorios'], 422);
}

$pdo = db();
$pdo->beginTransaction();

try {
    $stmtHeader = $pdo->prepare(
        'INSERT INTO process_headers (production_date, shift_name, product_name, application_method, week_label, created_by)
         VALUES (:production_date, :shift_name, :product_name, :application_method, :week_label, :created_by)'
    );
    $stmtHeader->execute([
        'production_date' => $productionDate,
        'shift_name' => $shiftName,
        'product_name' => $productName,
        'application_method' => $applicationMethod,
        'week_label' => $weekLabel,
        'created_by' => $user['id'],
    ]);

    $headerId = (int)$pdo->lastInsertId();

    $stmtEntry = $pdo->prepare(
        'INSERT INTO process_entries
        (header_id, hour_mark, lot_number, ph_value, water_temp_c, turbidity_ntu, water_changed, water_liters, disinfectant_ml, concentration_ppm, observations, operator_initials, supervisor_name)
         VALUES
        (:header_id, :hour_mark, :lot_number, :ph_value, :water_temp_c, :turbidity_ntu, :water_changed, :water_liters, :disinfectant_ml, :concentration_ppm, :observations, :operator_initials, :supervisor_name)'
    );

    foreach ($entries as $entry) {
        $stmtEntry->execute([
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
    jsonResponse(['ok' => false, 'message' => 'Error al guardar el registro', 'error' => $e->getMessage()], 500);
}

jsonResponse(['ok' => true, 'header_id' => $headerId, 'message' => 'Registro creado correctamente']);
