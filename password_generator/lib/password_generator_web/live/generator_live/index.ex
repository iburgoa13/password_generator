defmodule PasswordGeneratorWeb.GeneratorLive.Index do
  use PasswordGeneratorWeb, :live_view

  alias PasswordGenerator.Passwords
  alias PasswordGenerator.Passwords.Generator

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :passwords, Passwords.list_passwords())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Generator")
    |> assign(:generator, Passwords.get_generator!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Generator")
    |> assign(:generator, %Generator{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Passwords")
    |> assign(:generator, nil)
  end

  @impl true
  def handle_info({PasswordGeneratorWeb.GeneratorLive.FormComponent, {:saved, generator}}, socket) do
    {:noreply, stream_insert(socket, :passwords, generator)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    generator = Passwords.get_generator!(id)
    {:ok, _} = Passwords.delete_generator(generator)

    {:noreply, stream_delete(socket, :passwords, generator)}
  end
end
