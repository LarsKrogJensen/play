defmodule Play.Router do
  use Plug.Router
  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "hello")
  end

  match(_, do: send_resp(conn, 404, "Not found"))
end
