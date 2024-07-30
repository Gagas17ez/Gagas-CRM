<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Sales;
use App\Models\Product;
use App\Models\Customer;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Textarea;
use Filament\Tables\Columns\TextColumn;
use Illuminate\Support\Facades\Storage;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\FileUpload;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\SalesResource\Pages;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\SalesResource\RelationManagers;

class SalesResource extends Resource
{
    protected static ?string $model = Sales::class;

    protected static ?string $navigationIcon = 'heroicon-o-banknotes';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make()->schema([
                    Grid::make(2)->schema([
                        Select::make('idCustomer')
                            ->label('Customer')
                            ->options(Customer::all()->pluck('nama', 'idCustomer'))
                            ->searchable()
                            ->required(),

                        Select::make('idProduct')
                            ->label('Product')
                            ->options(Product::all()->pluck('nama', 'idProduct'))
                            ->searchable()
                            ->required(),

                        TextInput::make('jumlahTransaksi')
                            ->label('Jumlah Transaksi')
                            ->numeric()
                            ->required(),

                        Hidden::make('status')->default('belumdibayar'),

                        Select::make('status')
                            ->label('Status Sales')
                            ->options([
                                'belumdibayar' => 'Belum Dibayar',
                                'dibayar' => 'Dibayar',
                                'expired' => 'Expired',
                                'cancelled' => 'Cancelled'
                            ])->required(),

                        TextInput::make('deskripsi')->label('Deskripsi Sales'),
                    ])
                ]),

                Section::make()->schema([
                    FileUpload::make('invoice_file')
                        ->label('Invoice File')
                        ->disk('public')
                        ->directory('invoices')
                        ->acceptedFileTypes(['application/pdf', 'image/jpeg', 'image/png', 'application/word'])
                        ->maxSize(5120)
                        ->helperText('Upload invoice format PDF, Word, atau jpg.'),
                ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('customer.nama')
                    ->label('Nama Customer')
                    ->searchable()->limit(10),

                TextColumn::make('product.nama')
                    ->label('Nama Product')
                    ->searchable()->limit(10),

                TextColumn::make('jumlahTransaksi')
                    ->label('Jumlah Transaksi')
                    ->sortable(),

                TextColumn::make('status')
                    ->label('Status')
                    ->formatStateUsing(function ($state, $record, $column) {
                        return match ($state) {
                            'belumdibayar' => 'Belum Dibayar',
                            'dibayar' => 'Dibayar',
                            'expired' => 'Expired',
                            'cancelled' => 'Cancelled',
                            default => $state,
                        };
                    })
                    ->badge(),

                TextColumn::make('invoice_file')
                    ->label('Download Invoice')
                    ->url(fn($record) => Storage::disk('public')->url($record->invoice_file))
                    ->openUrlInNewTab()
                    ->formatStateUsing(fn($state) => 'Download')
                    ->icon('heroicon-o-arrow-down-tray'),

                TextColumn::make('deskripsi')
                    ->label('Description')
                    ->limit(50)->toggleable(isToggledHiddenByDefault: true),

                TextColumn::make('created_at')->date()->sortable()->toggleable(isToggledHiddenByDefault: true)->label('Tgl Transaksi'),
                TextColumn::make('updated_at')->date()->sortable()->toggleable(isToggledHiddenByDefault: true)->label('Tgl Transaksi Diedit'),
            ])
            ->filters([
                //
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
            'index' => Pages\ListSales::route('/'),
            'create' => Pages\CreateSales::route('/create'),
            'edit' => Pages\EditSales::route('/{record}/edit'),
        ];
    }
}
