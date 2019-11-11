import Config

config :play, ecto_repos: [Play.Repo]

import_config "#{Mix.env}.exs"
