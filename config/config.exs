# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :elixir, ansi_enabled: true # mix messages in colors

config :logger, backends: [
  # :console,
  {LoggerFileBackend, :info_log}
]
# config :logger, compile_time_purge_level: :info # purges debug messages
config :logger, compile_time_purge_level: :error # keeps only error messages
config :logger, level: :error # uncomment to stop logging
format = "$date $time [$level] $levelpad$message\n"
config :logger, :info_log, format: format
config :logger, :info_log, path: "./log/info.log", level: :info

#     import_config "#{Mix.env}.exs"
