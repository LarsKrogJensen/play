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
    params = %{
      odds_format: conn.body_params["oddsFormat"],
      odds_change_action: conn.body_params["oddsChangeAction"],
      show_odds_change_options: conn.body_params["showOddsChangeOptions"]
    }
    changeset = settings
                |> Settings.changeset(params)
    IO.puts("changeset #{inspect changeset}")
    result = changeset
             |> Settings.upsert()

    case result do
      {:ok, _} -> send_resp(conn, 200, "OK")
      {:error, _} -> send_resp(conn, 400, "Shitty request")
    end
  end

  match(_, do: send_resp(conn, 404, "Not found"))
end
