<?php

namespace App\Filament\Resources;

use App\Filament\Resources\LeadsResource\Pages;
use App\Filament\Resources\LeadsResource\RelationManagers;
use App\Models\Customer;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Grid;
use Filament\Tables\Filters\SelectFilter;

class LeadsResource extends Resource
{
    protected static ?string $model = Customer::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-plus';

    protected static ?string $navigationLabel = 'Leads';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make()->schema([
                    Grid::make(2)->schema([
                        TextInput::make('nama')->label('Nama')->required()->unique('customers', 'nama'),
                        Select::make('tipe')
                            ->label('Tipe')
                            ->options([
                                'lead' => 'lead',
                                'customer' => 'customer',
                            ])->required()->default('lead'),
                        Select::make('skala')
                            ->label('Skala Customer')
                            ->options([
                                'individu' => 'individu',
                                'perusahaan' => 'perusahaan'
                            ])->required(),
                        TextInput::make('email')->email()->label('Email')->unique('customers', 'email'),
                        TextInput::make('telefon')->label('Telepon')->required()->unique('customers', 'telefon'),
                        TextInput::make('alamat')->label('Alamat')->required(),

                    ])
                ]),
                Section::make()->schema([
                    Grid::make(2)->schema([

                        TextInput::make('instagram')->label('Instagram'),
                        TextInput::make('facebook')->label('Facebook'),
                        TextInput::make('twitter')->label('Twitter'),
                    ])
                ])

            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('nama')->label('Nama')->sortable()->searchable(),
                TextColumn::make('tipe')->badge()->label('Tipe')
                    ->color(fn(string $state): string => match ($state) {
                        'lead' => 'info',
                        'customer' => 'success',
                    }),
                TextColumn::make('skala')->label('Skala'),
                TextColumn::make('email')
                    ->icon('heroicon-m-envelope')
                    ->copyable()
                    ->copyMessage('Email tercopy')
                    ->copyMessageDuration(1000),
                TextColumn::make('telefon')->label('Telepon')->copyable()->copyMessage('Telepon tercopy'),
                TextColumn::make('alamat')->label('Alamat')->toggleable(isToggledHiddenByDefault: true)->copyable()->copyMessage('Alamat tercopy'),
                TextColumn::make('instagram')->label('Instagram')->toggleable(isToggledHiddenByDefault: true)->copyable()->copyMessage('Instagram tercopy'),
                TextColumn::make('facebook')->label('Facebook')->toggleable(isToggledHiddenByDefault: true)->copyable()->copyMessage('Facebook tercopy'),
                TextColumn::make('twitter')->label('Twitter')->toggleable(isToggledHiddenByDefault: true)->copyable()
                    ->copyMessage('Twitter tercopy'),

            ])
            ->filters([
                SelectFilter::make('tipe')
                    ->options([
                        'lead' => 'Lead',
                        'customer' => 'Customer',
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        if (!isset($data['value'])) {
                            return $query->where('tipe', 'lead');
                        }

                        return $query->where('tipe', $data['value']);
                    })
                    ->label('Filter by Type'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListLeads::route('/'),
            'create' => Pages\CreateLeads::route('/create'),
            'edit' => Pages\EditLeads::route('/{record}/edit'),
        ];
    }
}
