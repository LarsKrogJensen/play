defmodule Play.Router do
  use Plug.Router
  alias Play.Settings

  plug(
    Plug.Parsers,
    parsers: [:json, Absinthe.Plug.Parser],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "hello")
  end

  put "/user/:user_name/settings" do
    settings = Settings.get_or_default(user_name)
    params = Settings.params_from_json(conn.body_params)
    result = settings
             |> Settings.changeset(params)
             |> Settings.upsert()

    case result do
      {:ok, _} -> send_resp(conn, 200, "OK")
      {:error, _} -> send_resp(conn, 400, "Shitty request")
    end
  end

  get "/user/:user_name/settings" do
    json = Settings.get_or_default(user_name)
    |> Settings.to_json
    |> Jason.encode!

    conn
    |>put_resp_content_type("application/json")
    |> send_resp(200, json)
  end


  match(_, do: send_resp(conn, 404, "Not found"))
end
