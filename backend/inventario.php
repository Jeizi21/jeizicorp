<?php
header('Content-Type: application/json');
require_once 'db.php';

$sql = "SELECT id, categoria, nombre, stock, stock_minimo
        FROM inventario
        ORDER BY categoria, nombre";

$stmt = $pdo->query($sql);
echo json_encode($stmt->fetchAll());
