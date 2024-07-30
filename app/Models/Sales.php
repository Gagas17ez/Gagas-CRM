<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Sale
 *
 * @property int $idSales
 * @property int|null $idCustomer
 * @property int|null $idProduct
 * @property int $jumlahTransaksi
 * @property string $status
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 *
 * @property Customer|null $customer
 * @property Product|null $product
 *
 * @package App\Models
 */
class Sales extends Model
{
    protected $table = 'sales';
    protected $primaryKey = 'idSales';

    protected $casts = [
        'idCustomer' => 'int',
        'idProduct' => 'int'
    ];

    protected $fillable = [
        'idCustomer',
        'idProduct',
        'jumlahTransaksi',
        'deskripsi',
        'invoice_file',
        'status'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'idCustomer');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'idProduct');
    }
}
