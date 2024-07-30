<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;

/**
 * Class User
 * 
 * @property int $id
 * @property string $name
 * @property string $email
 * @property int|null $role
 * @property Carbon|null $email_verified_at
 * @property string $password
 * @property string|null $remember_token
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * 
 * @property Collection|LeadProcess[] $lead_processes
 *
 * @package App\Models
 */


 class User extends Authenticatable
{

	protected $table = 'users';

	protected $casts = [
		'role' => 'int',
		'email_verified_at' => 'datetime'
	];

	protected $hidden = [
		'password',
		'remember_token'
	];

	protected $fillable = [
		'name',
		'email',
		'role',
		'email_verified_at',
		'password',
		'remember_token'
	];

	public function lead_processes()
	{
		return $this->hasMany(LeadProcess::class, 'idManager');
	}
}
