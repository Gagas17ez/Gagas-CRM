# Link Deploy 

https://ptsmart.mitrakami.my.id

# PT Smart Coding Test

Divisi sales masih melakukan rekap data calon customer (lead), customer, produk (layanan
internet), dan penjualan secara manual. Oleh karena itu, buatlah aplikasi website Customer
Relationship Management sederhana yang bisa membantu PT. Smart khususnya divisi sales
untuk memudahkan pekerjaan mereka.

## Persyaratan

-   PHP >= 8
-   Composer
-   PostgreSQL
-   Laravel >= 11.x

## Instalasi

Ikuti langkah-langkah berikut

### Clone Repositori

Klon repositori ini menggunakan git:

```bash
git clone https://github.com/Gagas17ez/PT-Smart-CRM
cd nama-repo
```

### Setup ENV

```
cp .env.example .env
```

Edit ENV sesuai enviroment tersedia

### Generate KEY

```
php artisan key:generate
```

### Install Dep

```
Composer Install
```

### Lakukan Migrasi

```
php artisan migrate
```

### Buat User Pertama

dikarenakan tidak ada req register membuat user pertama harus menggunakan command line

```
php artisan make:filament-user
```

### Jalankan Server

```
php artisan serve
```
