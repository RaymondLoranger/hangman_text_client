defmodule Hangman.TextClient.Interact do
  # @moduledoc """
  # Interacts with a client playing a Hangman game.
  # """
  @moduledoc false

  use PersistConfig

  alias Hangman.Engine
  alias Hangman.TextClient.{Player, State}

  @node Application.get_env(@app, :hangman_node)

  @spec start(String.t()) :: no_return
  def start(player_name) when is_binary(player_name),
    do: game_name() |> new_game() |> State.init(player_name) |> Player.play()

  ## Private functions

  @spec game_name() :: String.t()
  defp game_name() do
    length = Enum.random(4..10)

    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, length)
  end

  @spec new_game(String.t()) :: String.t() | no_return
  defp new_game(game_name) do
    Node.connect(@node)
    :ok = :global.sync()

    case :rpc.call(@node, Engine, :new_game, [game_name]) do
      {:ok, _pid} -> game_name
      error -> exit(error)
    end
  end
end
