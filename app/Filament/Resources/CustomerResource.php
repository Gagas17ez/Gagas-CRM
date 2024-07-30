<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CustomerResource\Pages;
use App\Filament\Resources\CustomerResource\RelationManagers;
use App\Models\Customer;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Grid;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;

class CustomerResource extends Resource
{
    protected static ?string $model = Customer::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make()->schema([
                    Grid::make(2)->schema([
                        TextInput::make('nama')->label('Nama')->required(),
                    Select::make('tipe')
                        ->label('Tipe')
                        ->options([
                            'lead' => 'lead',
                            'customer' => 'customer',
                        ])->required(),
                    Select::make('skala')
                        ->label('Skala Customer')
                        ->options([
                            'individu' => 'individu',
                            'perusahaan' => 'perusahaan'
                        ])->required(),
                    TextInput::make('email')->email()->label('Email'),
                    TextInput::make('telefon')->label('Phone')->required(),
                    TextInput::make('alamat')->label('Address')->required(),
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
                ->color(fn (string $state): string => match ($state) {
                    'lead' => 'info',
                    'customer' => 'success',
                }),
                TextColumn::make('skala')->label('Skala'),
                TextColumn::make('email')  
                        ->icon('heroicon-m-envelope')
                        ->copyable()
                        ->copyMessage('Email tercopy')
                        ->copyMessageDuration(1000),
                TextColumn::make('telefon')->label('Telepon'),
                TextColumn::make('alamat')->label('Alamat')->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('instagram')->label('Instagram')->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('facebook')->label('Facebook')->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('twitter')->label('Twitter')->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                SelectFilter::make('tipe')
                    ->options([
                        'lead' => 'Lead',
                        'customer' => 'Customer',
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        if (!isset($data['value'])) {
                            return $query; 
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
            
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCustomers::route('/'),
            'create' => Pages\CreateCustomer::route('/create'),
            'edit' => Pages\EditCustomer::route('/{record}/edit'),
        ];
    }
}
