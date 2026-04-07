<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/auth.php';

requireAuth();

jsonResponse([
    'ok' => true,
    'limits' => [
        [
            'name' => 'Límite operacional',
            'range' => '100 - 300 ppm',
            'action' => 'Ninguna, actividad normal de proceso.',
        ],
        [
            'name' => 'Límite crítico bajo',
            'range' => 'Inferior < 100 ppm',
            'action' => 'Aumentar cloro y validar cada 15 min hasta volver al rango de control.',
        ],
        [
            'name' => 'Límite crítico alto',
            'range' => 'Superior > 300 ppm',
            'action' => 'Reducir concentración, renovar agua y registrar acción correctiva.',
        ],
    ],
]);
