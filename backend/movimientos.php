<?php
header('Content-Type: application/json');
require_once 'db.php';

$sql = "SELECT id, tipo, item, cantidad, area, DATE_FORMAT(fecha, '%Y-%m-%d %H:%i') AS fecha
        FROM movimientos
        ORDER BY fecha DESC
        LIMIT 50";

$stmt = $pdo->query($sql);
echo json_encode($stmt->fetchAll());
