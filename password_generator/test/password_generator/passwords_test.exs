defmodule PasswordGenerator.PasswordsTest do
  use PasswordGenerator.DataCase

  alias PasswordGenerator.Passwords

  describe "passwords" do
    alias PasswordGenerator.Passwords.Generator

    import PasswordGenerator.PasswordsFixtures

    @invalid_attrs %{}

    test "list_passwords/0 returns all passwords" do
      generator = generator_fixture()
      assert Passwords.list_passwords() == [generator]
    end

    test "get_generator!/1 returns the generator with given id" do
      generator = generator_fixture()
      assert Passwords.get_generator!(generator.id) == generator
    end

    test "create_generator/1 with valid data creates a generator" do
      valid_attrs = %{}

      assert {:ok, %Generator{} = generator} = Passwords.create_generator(valid_attrs)
    end

    test "create_generator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Passwords.create_generator(@invalid_attrs)
    end

    test "update_generator/2 with valid data updates the generator" do
      generator = generator_fixture()
      update_attrs = %{}

      assert {:ok, %Generator{} = generator} = Passwords.update_generator(generator, update_attrs)
    end

    test "update_generator/2 with invalid data returns error changeset" do
      generator = generator_fixture()
      assert {:error, %Ecto.Changeset{}} = Passwords.update_generator(generator, @invalid_attrs)
      assert generator == Passwords.get_generator!(generator.id)
    end

    test "delete_generator/1 deletes the generator" do
      generator = generator_fixture()
      assert {:ok, %Generator{}} = Passwords.delete_generator(generator)
      assert_raise Ecto.NoResultsError, fn -> Passwords.get_generator!(generator.id) end
    end

    test "change_generator/1 returns a generator changeset" do
      generator = generator_fixture()
      assert %Ecto.Changeset{} = Passwords.change_generator(generator)
    end
  end
end
