<?php

declare(strict_types=1);

require_once __DIR__ . '/database.php';

function getBearerToken(): ?string
{
    $header = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    if (!str_starts_with($header, 'Bearer ')) {
        return null;
    }

    return trim(substr($header, 7));
}

function requireAuth(): array
{
    $token = getBearerToken();

    if ($token === null || $token === '') {
        jsonResponse(['ok' => false, 'message' => 'No autorizado'], 401);
    }

    $stmt = db()->prepare(
        'SELECT id, full_name, role, token_expires_at
         FROM users
         WHERE api_token = :token AND active = 1
         LIMIT 1'
    );
    $stmt->execute(['token' => $token]);
    $user = $stmt->fetch();

    if (!$user) {
        jsonResponse(['ok' => false, 'message' => 'Token inválido'], 401);
    }

    if ($user['token_expires_at'] !== null && strtotime($user['token_expires_at']) < time()) {
        jsonResponse(['ok' => false, 'message' => 'Token expirado'], 401);
    }

    return $user;
}
