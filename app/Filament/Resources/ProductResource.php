<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProductResource\Pages;
use App\Filament\Resources\ProductResource\RelationManagers;
use App\Models\Product;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\FileUpload;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Grid;

class ProductResource extends Resource
{
    protected static ?string $model = Product::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    public static function form(Form $form): Form
    {
        return $form
        ->schema([
            Section::make()->schema([
                Grid::make(2)->schema([
                    TextInput::make('nama')
                        ->label('Nama')
                        ->required(),
                    Textarea::make('deskripsi')
                        ->label('Deskripsi'),
                    TextInput::make('harga')
                        ->label('Harga')
                        ->numeric()
                        ->helperText('Masukkan harga tanpa titik atau simbol'),
                ])
            ]),
            
            Section::make()->schema([
                FileUpload::make('gambarProduct')
                ->label('Upload Gambar')
                ->image()
                ->imageEditor()
                ->disk('public')
                ->directory('product_images')
                ->helperText('Unggah gambar produk'),
            ])
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('gambarProduct')->size(70)->label('Gambar Produk'),
                TextColumn::make('nama')
                    ->label('Nama Produk')->searchable(),
                TextColumn::make('harga')
                    ->label('Harga')
                    ->money('IDR', true),
                TextColumn::make('deskripsi')
                    ->label('Deskripsi'),
                
                
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
            'index' => Pages\ListProducts::route('/'),
            'create' => Pages\CreateProduct::route('/create'),
            'edit' => Pages\EditProduct::route('/{record}/edit'),
        ];
    }
}
