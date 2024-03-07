<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class MainController extends Controller
{
    public function index(): \Illuminate\Http\JsonResponse
    {
        return response()->json('hello');
    }
}
