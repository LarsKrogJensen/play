defmodule Play.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = System.get_env("PORT", "8080")
           |> String.to_integer
    IO.puts("Using port: " <> inspect(port))
    children = [
      Play.Repo,
      {
        Plug.Cowboy,
        scheme: :http,
        plug: Play.Router,
        options: [
          port: port
        ]
      },
    ]

    opts = [strategy: :one_for_one, name: Play.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
