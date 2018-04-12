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
  def start(player \\ random_player()) do
    player
    |> new_game()
    |> State.init()
    |> Player.play()
  end

  ## Private functions

  @spec random_player() :: String.t()
  defp random_player() do
    length = Enum.random(4..10)

    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, length)
  end

  @spec new_game(String.t()) :: String.t() | no_return
  defp new_game(player) do
    Node.connect(@node)
    :ok = :global.sync()

    case :rpc.call(@node, Engine, :new_game, [player]) do
      {:ok, _pid} -> player
      error -> exit(error)
    end
  end
end
