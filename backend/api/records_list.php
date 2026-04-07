<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/auth.php';

requireAuth();

$date = $_GET['date'] ?? date('Y-m-d');
$shift = $_GET['shift'] ?? null;

$query = 'SELECT h.id, h.production_date, h.shift_name, h.product_name, h.application_method, h.week_label,
                 e.id AS entry_id, e.hour_mark, e.lot_number, e.ph_value, e.water_temp_c, e.turbidity_ntu,
                 e.water_changed, e.water_liters, e.disinfectant_ml, e.concentration_ppm, e.observations,
                 e.operator_initials, e.supervisor_name
          FROM process_headers h
          LEFT JOIN process_entries e ON e.header_id = h.id
          WHERE h.production_date = :production_date';
$params = ['production_date' => $date];

if ($shift !== null && $shift !== '') {
    $query .= ' AND h.shift_name = :shift_name';
    $params['shift_name'] = $shift;
}

$query .= ' ORDER BY h.id DESC, e.hour_mark ASC';

$stmt = db()->prepare($query);
$stmt->execute($params);
$rows = $stmt->fetchAll();

$records = [];
foreach ($rows as $row) {
    $id = (int)$row['id'];
    if (!isset($records[$id])) {
        $records[$id] = [
            'header' => [
                'id' => $id,
                'production_date' => $row['production_date'],
                'shift_name' => $row['shift_name'],
                'product_name' => $row['product_name'],
                'application_method' => $row['application_method'],
                'week_label' => $row['week_label'],
            ],
            'entries' => [],
        ];
    }

    if ($row['entry_id'] !== null) {
        $records[$id]['entries'][] = [
            'id' => (int)$row['entry_id'],
            'hour_mark' => $row['hour_mark'],
            'lot_number' => $row['lot_number'],
            'ph_value' => (float)$row['ph_value'],
            'water_temp_c' => (float)$row['water_temp_c'],
            'turbidity_ntu' => (float)$row['turbidity_ntu'],
            'water_changed' => (bool)$row['water_changed'],
            'water_liters' => (float)$row['water_liters'],
            'disinfectant_ml' => (float)$row['disinfectant_ml'],
            'concentration_ppm' => (int)$row['concentration_ppm'],
            'observations' => $row['observations'],
            'operator_initials' => $row['operator_initials'],
            'supervisor_name' => $row['supervisor_name'],
        ];
    }
}

jsonResponse(['ok' => true, 'records' => array_values($records)]);
