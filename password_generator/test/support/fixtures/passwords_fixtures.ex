defmodule PasswordGenerator.PasswordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PasswordGenerator.Passwords` context.
  """

  @doc """
  Generate a generator.
  """
  def generator_fixture(attrs \\ %{}) do
    {:ok, generator} =
      attrs
      |> Enum.into(%{

      })
      |> PasswordGenerator.Passwords.create_generator()

    generator
  end
end
