<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\UpdateController;
use App\Http\Controllers\DeleteController;
use Illuminate\Auth\Events\Login;

Route::post('/register', RegisterController::class);

Route::post('/login', LoginController::class);

Route::put('/change/password',[UpdateController::class,'changePassword'])->middleware('auth:sanctum');

Route::delete('/delete',DeleteController::class)->middleware('auth:sanctum');

Route::delete('/delete/token',[DeleteController::class,'deleteToken'])->middleware('auth:sanctum');

