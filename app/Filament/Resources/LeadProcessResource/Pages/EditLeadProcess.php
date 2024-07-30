<?php

namespace App\Filament\Resources\LeadProcessResource\Pages;

use App\Filament\Resources\LeadProcessResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditLeadProcess extends EditRecord
{
    protected static string $resource = LeadProcessResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }

    protected function getRedirectUrl(): string
    {
        return $this->previousUrl ?? $this->getResource()::getUrl('index');
    }
}
