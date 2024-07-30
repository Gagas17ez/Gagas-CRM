<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('sales', function (Blueprint $table) {
            $table->bigIncrements('idSales');
            $table->foreignId('idCustomer')->nullable();
			$table->foreign('idCustomer')->references('idCustomer')->on('customers')->onDelete('SET NULL');
            $table->foreignId('idProduct')->nullable();
			$table->foreign('idProduct')->references('idProduct')->on('product')->onDelete('SET NULL');
            $table->string('jumlahTransaksi')->default('0');
            $table->longText('deskripsi')->nullable();
            $table->enum('status', ['belumdibayar', 'dibayar', 'expired', 'cancelled'])->default('belumdibayar');
            $table->string('invoice_file')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sales');
    }
};
