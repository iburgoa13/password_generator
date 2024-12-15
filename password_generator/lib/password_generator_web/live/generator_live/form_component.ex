defmodule PasswordGeneratorWeb.GeneratorLive.FormComponent do
  use PasswordGeneratorWeb, :live_component

  alias PasswordGenerator.Passwords

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage generator records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="generator-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Generator</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{generator: generator} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Passwords.change_generator(generator))
     end)}
  end

  @impl true
  def handle_event("validate", %{"generator" => generator_params}, socket) do
    changeset = Passwords.change_generator(socket.assigns.generator, generator_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"generator" => generator_params}, socket) do
    save_generator(socket, socket.assigns.action, generator_params)
  end

  defp save_generator(socket, :edit, generator_params) do
    case Passwords.update_generator(socket.assigns.generator, generator_params) do
      {:ok, generator} ->
        notify_parent({:saved, generator})

        {:noreply,
         socket
         |> put_flash(:info, "Generator updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_generator(socket, :new, generator_params) do
    case Passwords.create_generator(generator_params) do
      {:ok, generator} ->
        notify_parent({:saved, generator})

        {:noreply,
         socket
         |> put_flash(:info, "Generator created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
