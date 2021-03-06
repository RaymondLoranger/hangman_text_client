defmodule Hangman.Text.Client.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hangman_text_client,
      version: "0.1.25",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_apps: [:hangman_engine]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      included_applications: [:hangman_engine],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:hangman_engine, github: "RaymondLoranger/hangman_engine"},
      {:hangman_game, github: "RaymondLoranger/hangman_game"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
