defmodule PasswordGenerator.Passwords.Generator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "generators" do
    field :longitud, :integer, default: 12
    field :mayusculas, :boolean, default: true
    field :numeros, :boolean, default: true
    field :especiales, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(generator, attrs) do
    generator
    |> cast(attrs, [:longitud, :mayusculas, :numeros, :especiales])
    |> validate_required([:longitud])
    |> validate_number(:longitud, greater_than: 0)
  end
end
