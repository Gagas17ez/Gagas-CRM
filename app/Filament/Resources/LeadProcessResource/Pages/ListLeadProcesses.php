<?php

namespace App\Filament\Resources\LeadProcessResource\Pages;

use App\Filament\Resources\LeadProcessResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListLeadProcesses extends ListRecords
{
    protected static string $resource = LeadProcessResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }

    
}
