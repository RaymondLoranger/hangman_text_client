defmodule Hangman.Text.Client.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hangman_text_client,
      version: "0.1.31",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Hangman Game",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps(),
      dialyzer: [plt_add_apps: [:hangman_engine]]
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/hangman_text_client"
  end

  defp description do
    """
    Text client for the Hangman Game.
    """
  end

  defp package do
    [
      # NOTE: "config/runtime.exs" included automatically!
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # App `:hangman_engine` must run in node `:hangman_engine@<hostname>`.
      included_applications: [:hangman_engine],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:hangman_engine, "~> 0.1"},
      {:hangman_game, "~> 0.1"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
