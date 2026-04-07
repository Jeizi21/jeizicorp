<?php

declare(strict_types=1);

const DB_HOST = '127.0.0.1';
const DB_NAME = 'industrial_control';
const DB_USER = 'root';
const DB_PASS = '';
const DB_PORT = '3306';

const APP_TIMEZONE = 'America/Lima';
const TOKEN_TTL_HOURS = 12;

date_default_timezone_set(APP_TIMEZONE);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
