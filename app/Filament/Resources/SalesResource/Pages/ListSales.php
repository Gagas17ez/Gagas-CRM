<?php

namespace App\Filament\Resources\SalesResource\Pages;

use App\Filament\Resources\SalesResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListSales extends ListRecords
{
    protected static string $resource = SalesResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }

    protected function getRedirectUrl(): string
    {
        return $this->previousUrl ?? $this->getResource()::getUrl('index');
    }
}
