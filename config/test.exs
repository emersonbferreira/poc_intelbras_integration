import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :poc_intelbras_integration, PocIntelbrasIntegration.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "poc_intelbras_integration_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :poc_intelbras_integration, PocIntelbrasIntegrationWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ycqUn5E7ILfJZyGy++sGiY5E6DAEoAtEcoYzKYueUpfmgMLire1EqfyD5XE8zCcj",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
