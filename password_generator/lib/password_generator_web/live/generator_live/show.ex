defmodule PasswordGeneratorWeb.GeneratorLive.Show do
  use PasswordGeneratorWeb, :live_view

  alias PasswordGenerator.Passwords

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:generator, Passwords.get_generator!(id))}
  end

  defp page_title(:show), do: "Show Generator"
  defp page_title(:edit), do: "Edit Generator"
end
