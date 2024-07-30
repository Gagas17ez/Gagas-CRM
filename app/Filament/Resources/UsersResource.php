<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UsersResource\Pages;
use App\Filament\Resources\UsersResource\RelationManagers;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\FileUpload;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Hash;
use Filament\Forms\Components\Select;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Tables\Columns\BadgeColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Components\Grid;

class UsersResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    public static function form(Form $form): Form
    {
        if (auth()->user()->role != 1) {
            return abort(403, 'Unauthorized');
        }
        return $form
            ->schema([
                Section::make()->schema([
                    Grid::make(2)->schema([
                        TextInput::make('name')
                            ->required()
                            ->label('Nama'),

                        TextInput::make('email')
                            ->email()
                            ->required()
                            ->label('Email'),

                        TextInput::make(name: 'password')->required()->label('Password')->password()
                            ->dehydrateStateUsing(fn(string $state): string => Hash::make($state)),

                        Select::make('role')
                            ->options([
                                1 => 'Admin',
                                2 => 'Sales',
                                3 => 'Management',
                            ])
                            ->required()
                            ->label('Role'),
                    ])
                ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        if (auth()->user()->role != 1) {
            return abort(403, 'Unauthorized');
        }
        return $table
            ->columns([
                TextColumn::make('name')->label('Name'),

                TextColumn::make('email')
                    ->icon('heroicon-m-envelope')
                    ->copyable()
                    ->copyMessage('Email tercopy')
                    ->copyMessageDuration(1000),

                BadgeColumn::make('role')
                    ->formatStateUsing(fn($state) => match ($state) {
                        1 => 'Admin',
                        2 => 'Sales',
                        3 => 'Management',
                        default => 'unknown',
                    })
                    ->colors([
                        'primary' => 1,
                        'success' => 2,
                        'warning' => 3,
                    ])->label('Role'),
            ])
            ->filters([
                SelectFilter::make('role')
                    ->options([
                        1 => 'Admin',
                        2 => 'Sales',
                        3 => 'Management',
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        if (!isset($data['value'])) {
                            return $query;
                        }

                        return $query->where('role', $data['value']);
                    })
                    ->label('Filter by Role'),
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

    public static function shouldRegisterNavigation(): bool
    {
        return auth()->user()->role == 1;
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUsers::route('/create'),
            'edit' => Pages\EditUsers::route('/{record}/edit'),
        ];
    }
}
