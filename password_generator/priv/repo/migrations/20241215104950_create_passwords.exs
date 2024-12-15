defmodule PasswordGenerator.Repo.Migrations.CreateGenerators do
  use Ecto.Migration

  def change do
    create table(:generators) do
      add :longitud, :integer, null: false, default: 12
      add :mayusculas, :boolean, null: false, default: true
      add :numeros, :boolean, null: false, default: true
      add :especiales, :boolean, null: false, default: true

      timestamps()
    end
  end
end
