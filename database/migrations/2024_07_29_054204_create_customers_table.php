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
        Schema::create('customers', function (Blueprint $table) {
            $table->bigIncrements('idCustomer');
            $table->string('nama')->nullable();
            $table->enum('tipe', ['lead', 'customer'])->default('lead');
            $table->enum('skala', ['individu', 'perusahaan'])->default('individu');
            $table->string('email')->unique()->nullable();
            $table->string('telefon')->unique()->nullable();
            $table->string('alamat')->nullable();
            $table->string('instagram')->nullable();
            $table->string('facebook')->nullable();
            $table->string('twitter')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customers');
    }
};
