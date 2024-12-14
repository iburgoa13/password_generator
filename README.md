# password_generator

hola

# Primer paso
mix archive.install hex phx_new


Antes de comenzar, asegúrate de tener lo necesario instalado:

Elixir y Erlang: Son esenciales para ejecutar proyectos en Phoenix.
Phoenix Framework: Si no lo tienes, instálalo con:
bash
Copiar código
mix archive.install hex phx_new
Node.js: Phoenix lo usa para gestionar assets del frontend.
PostgreSQL (opcional): Aunque este proyecto no requiere una base de datos inicialmente, Phoenix se configura por defecto con Postgres.


entrar en proyecto y hacer mix deps.get

We are almost there! The following steps are missing:

    $ cd password_generator

Then configure your database in config/dev.exs and run:

    $ mix ecto.create

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server


docker run --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=password_generator_dev -p 5432:5432 -d postgres

