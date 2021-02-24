use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pxblog, PxblogWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pxblog, Pxblog.Repo,
  username: "roman",
  password: "postgres",
  database: "pxblog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :comeonin, bcrypt_log_rounds: 4
