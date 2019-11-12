import Config

config :play,
       Play.Repo,
       url: System.get_env("DATABASE_URL"),
       ssl: true,
       pool_size: 2
