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
        Schema::create('lead_process', function (Blueprint $table) {
            $table->bigIncrements('idLeadProcess');
            $table->foreignId('idCustomer')->nullable();
			$table->foreign('idCustomer')->references('idCustomer')->on('customers')->onDelete('SET NULL');
            $table->enum('status', ['dibuat', 'pending', 'diterima', 'ditolak'])->default('dibuat');
            $table->foreignId('idManager')->nullable();
			$table->foreign('idManager')->references('id')->on('users');
            $table->longText('deskripsi')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lead_process');
    }
};
