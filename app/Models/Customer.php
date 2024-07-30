<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Customer
 * 
 * @property int $idCustomer
 * @property string|null $nama
 * @property string $tipe
 * @property string $skala
 * @property string|null $email
 * @property string|null $telefon
 * @property string|null $alamat
 * @property string|null $instagram
 * @property string|null $facebook
 * @property string|null $twitter
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * 
 * @property Collection|Sales[] $sales
 * @property Collection|LeadProcess[] $lead_processes
 *
 * @package App\Models
 */
class Customer extends Model
{
	protected $table = 'customers';
	protected $primaryKey = 'idCustomer';

	protected $fillable = [
		'nama',
		'tipe',
		'skala',
		'email',
		'telefon',
		'alamat',
		'instagram',
		'facebook',
		'twitter'
	];

	public function sales()
	{
		return $this->hasMany(Sales::class, 'idCustomer');
	}

	public function lead_processes()
	{
		return $this->hasMany(LeadProcess::class, 'idCustomer');
	}
}
