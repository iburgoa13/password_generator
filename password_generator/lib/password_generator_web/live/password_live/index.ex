defmodule PasswordGeneratorWeb.PasswordLive.Index do
  use PasswordGeneratorWeb, :live_view
  import Phoenix.HTLM.Link
  alias ElixirLS.LanguageServer.Plugins.Phoenix
  alias PasswordGenerator.Passwords.Generator

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, %{
       longitud: 12,
       mayusculas: true,
       numeros: true,
       especiales: true,
       contraseña: nil,
       error: nil
     })}
  end

  def handle_event("generar", params, socket) do
    longitud = String.to_integer(params["longitud"] || "12")
    mayusculas = Map.get(params, "mayusculas", "false") == "true"
    numeros = Map.get(params, "numeros", "false") == "true"
    especiales = Map.get(params, "especiales", "false") == "true"

    case Generator.generar_contraseña(longitud, mayusculas, numeros, especiales) do
      {:ok, contraseña} ->
        {:noreply, assign(socket, contraseña: contraseña, error: nil)}

      {:error, error} ->
        {:noreply, assign(socket, contraseña: nil, error: error)}
    end
  end
end
