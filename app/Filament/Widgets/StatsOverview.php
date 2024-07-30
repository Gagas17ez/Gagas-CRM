<?php

namespace App\Filament\Widgets;
use App\Models\Customer;
use App\Models\Sales;
use App\Models\LeadProcess;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        $JumlahCustomer = Customer::where('tipe', 'customer')->count();
        $JumlahLeads = Customer::where('tipe', 'lead')->count();
        $JumlahSales = Sales::count();
        $JumlahLeadProcess = LeadProcess::count();
        return [
            Stat::make('Jumlah Customer', number_format($JumlahCustomer)),
            Stat::make('Jumlah Leads', number_format($JumlahLeads)),
            Stat::make('Jumlah Sales', number_format($JumlahSales)),
            Stat::make('Jumlah Sales', number_format($JumlahLeadProcess)),
        ];
    }
}
