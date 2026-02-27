<?php
header('Content-Type: application/json');
require_once 'db.php';

$sql = "SELECT
    SUM(CASE WHEN tipo = 'ENTREGA_EPP' THEN cantidad ELSE 0 END) AS epp_entregados,
    SUM(CASE WHEN tipo = 'ENTREGA_QUIMICO' THEN cantidad ELSE 0 END) AS quimicos_entregados,
    SUM(CASE WHEN tipo = 'RECIBO_ETIQUETA' THEN cantidad ELSE 0 END) AS etiquetas_recibidas,
    SUM(CASE WHEN tipo = 'LIMPIEZA_AREA' THEN 1 ELSE 0 END) AS tareas_limpieza_completadas,
    (SELECT COUNT(*) FROM inventario WHERE stock <= stock_minimo) AS alertas_stock
FROM movimientos";

$stmt = $pdo->query($sql);
$data = $stmt->fetch();

echo json_encode($data ?: []);
