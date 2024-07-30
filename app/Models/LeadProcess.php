<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class LeadProcess
 * 
 * @property int $idLeadProcess
 * @property int|null $idCustomer
 * @property string $status
 * @property int|null $idManager
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * 
 * @property Customer|null $customer
 * @property User|null $user
 *
 * @package App\Models
 */
class LeadProcess extends Model
{
	protected $table = 'lead_process';
	protected $primaryKey = 'idLeadProcess';

	protected $casts = [
		'idCustomer' => 'int',
		'idManager' => 'int'
	];

	protected $fillable = [
		'idCustomer',
		'status',
		'idManager',
		'deskripsi'
	];

	public function customer()
	{
		return $this->belongsTo(Customer::class, 'idCustomer');
	}

	public function user()
	{
		return $this->belongsTo(User::class, 'idManager');
	}
}
