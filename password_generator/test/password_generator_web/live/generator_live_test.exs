defmodule PasswordGeneratorWeb.GeneratorLiveTest do
  use PasswordGeneratorWeb.ConnCase

  import Phoenix.LiveViewTest
  import PasswordGenerator.PasswordsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_generator(_) do
    generator = generator_fixture()
    %{generator: generator}
  end

  describe "Index" do
    setup [:create_generator]

    test "lists all passwords", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/passwords")

      assert html =~ "Listing Passwords"
    end

    test "saves new generator", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/passwords")

      assert index_live |> element("a", "New Generator") |> render_click() =~
               "New Generator"

      assert_patch(index_live, ~p"/passwords/new")

      assert index_live
             |> form("#generator-form", generator: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#generator-form", generator: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/passwords")

      html = render(index_live)
      assert html =~ "Generator created successfully"
    end

    test "updates generator in listing", %{conn: conn, generator: generator} do
      {:ok, index_live, _html} = live(conn, ~p"/passwords")

      assert index_live |> element("#passwords-#{generator.id} a", "Edit") |> render_click() =~
               "Edit Generator"

      assert_patch(index_live, ~p"/passwords/#{generator}/edit")

      assert index_live
             |> form("#generator-form", generator: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#generator-form", generator: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/passwords")

      html = render(index_live)
      assert html =~ "Generator updated successfully"
    end

    test "deletes generator in listing", %{conn: conn, generator: generator} do
      {:ok, index_live, _html} = live(conn, ~p"/passwords")

      assert index_live |> element("#passwords-#{generator.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#passwords-#{generator.id}")
    end
  end

  describe "Show" do
    setup [:create_generator]

    test "displays generator", %{conn: conn, generator: generator} do
      {:ok, _show_live, html} = live(conn, ~p"/passwords/#{generator}")

      assert html =~ "Show Generator"
    end

    test "updates generator within modal", %{conn: conn, generator: generator} do
      {:ok, show_live, _html} = live(conn, ~p"/passwords/#{generator}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Generator"

      assert_patch(show_live, ~p"/passwords/#{generator}/show/edit")

      assert show_live
             |> form("#generator-form", generator: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#generator-form", generator: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/passwords/#{generator}")

      html = render(show_live)
      assert html =~ "Generator updated successfully"
    end
  end
end
