import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :jaya_tech, JayaTech.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "jaya_tech_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jaya_tech, JayaTechWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2aB//x6PVS91hqnOdi5ln856eJ0CmMvvFk6+TkGJGvPPQHnvtW6++LoUzIWLYFwJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
