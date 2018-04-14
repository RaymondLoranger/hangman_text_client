defmodule Hangman.TextClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hangman_text_client,
      version: "0.1.1",
      elixir: "~> 1.6",
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
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:hangman_engine, github: "RaymondLoranger/hangman_engine"},
      {:persist_config, "~> 0.1"},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
