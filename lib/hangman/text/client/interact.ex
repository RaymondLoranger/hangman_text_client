defmodule Hangman.Text.Client.Interact do
  @moduledoc """
  Interacts with a client playing a _Hangman Game_.
  """

  use PersistConfig

  alias Hangman.Engine
  alias Hangman.Text.Client.{Player, State}

  @node get_env(:hangman_engine_node)

  @spec start(String.t()) :: no_return
  def start(player_name) when is_binary(player_name),
    do: game_name() |> new_game() |> State.new(player_name) |> Player.play()

  ## Private functions

  @spec game_name() :: String.t()
  defp game_name() do
    length = Enum.random(4..10)

    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    # Starting at 0 with length "length"...
    |> binary_part(0, length)
  end

  @spec new_game(String.t()) :: String.t() | no_return
  defp new_game(game_name) do
    Node.connect(@node)
    :ok = :global.sync()

    case :rpc.call(@node, Engine, :new_game, [game_name]) do
      {:ok, _pid} ->
        game_name

      {:badrpc, :nodedown} ->
        IO.puts("Hangman Engine not started.")
        self() |> Process.exit(:normal)

      error ->
        exit(error)
    end
  end
end
