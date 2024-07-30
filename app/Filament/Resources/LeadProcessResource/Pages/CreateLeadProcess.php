<?php

namespace App\Filament\Resources\LeadProcessResource\Pages;

use App\Filament\Resources\LeadProcessResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateLeadProcess extends CreateRecord
{
    protected static string $resource = LeadProcessResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->previousUrl ?? $this->getResource()::getUrl('index');
    }
}
