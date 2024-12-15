defmodule PasswordGenerator.Passwords do
  @moduledoc """
  The Passwords context.
  """

  import Ecto.Query, warn: false
  alias PasswordGenerator.Repo
  alias PasswordGenerator.Passwords.Generator

  @doc """
  Returns the list of passwords.
  """
  def list_passwords do
    Repo.all(Generator)
  end

  @doc """
  Gets a single generator.
  """
  def get_generator!(id), do: Repo.get!(Generator, id)

  @doc """
  Creates a generator.
  """
  def create_generator(attrs \\ %{}) do
    %Generator{}
    |> Generator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a generator.
  """
  def update_generator(%Generator{} = generator, attrs) do
    generator
    |> Generator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a generator.
  """
  def delete_generator(%Generator{} = generator) do
    Repo.delete(generator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking generator changes.
  """
  def change_generator(%Generator{} = generator, attrs \\ %{}) do
    Generator.changeset(generator, attrs)
  end
end
