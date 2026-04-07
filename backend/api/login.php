<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';

$input = readJson();
$username = trim((string)($input['username'] ?? ''));
$password = (string)($input['password'] ?? '');

if ($username === '' || $password === '') {
    jsonResponse(['ok' => false, 'message' => 'Usuario y contraseña son requeridos'], 422);
}

$stmt = db()->prepare('SELECT id, username, password_hash, full_name, role FROM users WHERE username = :username AND active = 1 LIMIT 1');
$stmt->execute(['username' => $username]);
$user = $stmt->fetch();

if (!$user || !password_verify($password, $user['password_hash'])) {
    jsonResponse(['ok' => false, 'message' => 'Credenciales inválidas'], 401);
}

$token = bin2hex(random_bytes(32));
$expiresAt = date('Y-m-d H:i:s', strtotime('+' . TOKEN_TTL_HOURS . ' hours'));

$update = db()->prepare('UPDATE users SET api_token = :token, token_expires_at = :expires_at, last_login_at = NOW() WHERE id = :id');
$update->execute([
    'token' => $token,
    'expires_at' => $expiresAt,
    'id' => $user['id'],
]);

jsonResponse([
    'ok' => true,
    'token' => $token,
    'expires_at' => $expiresAt,
    'user' => [
        'id' => (int)$user['id'],
        'full_name' => $user['full_name'],
        'role' => $user['role'],
    ],
]);
