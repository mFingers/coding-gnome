# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :gallows_socket, GallowsSocketWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1H0eQnn9V8YofObRV4FtI+ZcM8c0v0Hz4HhYppJC9cp4v4lkwL4YBEk3vwT9a+tS",
  render_errors: [view: GallowsSocketWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GallowsSocket.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
