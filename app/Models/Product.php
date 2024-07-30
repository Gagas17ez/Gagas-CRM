<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Product
 * 
 * @property int $idProduct
 * @property string $nama
 * @property string|null $deskripsi
 * @property string $harga
 * @property string|null $gambarProduct
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * 
 * @property Collection|Sales[] $sales
 *
 * @package App\Models
 */
class Product extends Model
{
	protected $table = 'product';
	protected $primaryKey = 'idProduct';

	protected $fillable = [
		'nama',
		'deskripsi',
		'harga',
		'gambarProduct'
	];

	public function sales()
	{
		return $this->hasMany(Sales::class, 'idProduct');
	}
}
