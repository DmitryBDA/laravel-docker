<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;
use Spatie\Permission\Models\Role;

class CreateUserAdminDefault extends Migration
{
    public function up()
    {
        Role::create(['name' => 'user']);
        $adminRole = Role::create(['name' => 'admin']);

        $user = \App\Models\User::create([
            'name' => 'admin',
            'email' => 'admin@admin.com',
            'email_verified_at' => '',
            'password' => Hash::make('qweqweqwe'),
            'remember_token' => '',
            'surname' => 'admin',
            'phone' => '79999999999',
        ]);
        $user->assignRole($adminRole);
    }

    public function down()
    {

    }
}
