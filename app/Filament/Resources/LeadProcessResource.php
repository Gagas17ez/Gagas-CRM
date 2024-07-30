<?php

namespace App\Filament\Resources;

use App\Filament\Resources\LeadProcessResource\Pages;
use App\Filament\Resources\LeadProcessResource\RelationManagers;
use App\Models\LeadProcess;
use App\Models\Customer;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\Hidden;
use Illuminate\Database\Eloquent\Builder;
use Filament\Forms\Components\Textarea;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\Select;
use Filament\Tables\Columns\SelectColumn;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Grid;
use Filament\Tables\Columns\BadgeColumn;

class LeadProcessResource extends Resource
{
    protected static ?string $model = LeadProcess::class;

    protected static ?string $navigationIcon = 'heroicon-o-briefcase';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make()->schema([
                    Grid::make(2)->schema([
                        Select::make('idCustomer')
                            ->label('Customer')
                            ->options(Customer::query()->pluck('nama', 'idCustomer'))  // Assuming 'name' and 'id' are columns in your customers table
                            ->searchable()
                            ->required(),

                        Hidden::make('idManager')
                            ->default(auth()->user()->role == 3 ? auth()->id() : null), // Set default based on role

                        Hidden::make('status')->default('dibuat'),

                        Select::make('status')
                            ->label('Status')
                            ->options([
                                'dibuat' => 'Dibuat',
                                'pending' => 'Pending',
                                'diterima' => 'Diterima',
                                'ditolak' => 'Ditolak',
                            ])
                            ->required()->visible(auth()->user()->role != 2),

                        Textarea::make('deskripsi')
                            ->label('Deskripsi')
                            ->maxLength(65535),
                    ])

                ])

            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('customer.nama')
                    ->label('Customer')
                    ->sortable()
                    ->searchable(),

                TextColumn::make('status')->badge()->label('Status')
                    ->color(fn(string $state): string => match ($state) {
                        'dibuat' => 'info',
                        'pending' => 'primary',
                        'diterima' => 'success',
                        'ditolak' => 'warning',
                    }),

                TextColumn::make('deskripsi')
                    ->label('Deskripsi')
                    ->limit(20),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options([
                        'dibuat' => 'Dibuat',
                        'pending' => 'Pending',
                        'diterima' => 'Diterima',
                        'ditolak' => 'Ditolak',
                    ])
                    ->label('Filter by Status'),
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
            'index' => Pages\ListLeadProcesses::route('/'),
            'create' => Pages\CreateLeadProcess::route('/create'),
            'edit' => Pages\EditLeadProcess::route('/{record}/edit'),
        ];
    }
}
