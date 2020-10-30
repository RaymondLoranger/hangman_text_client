defmodule Hangman.Text.Client.Interact do
  @moduledoc """
  Interacts with a client playing a _Hangman Game_.
  """

  use PersistConfig

  alias Hangman.Engine
  alias Hangman.Text.Client.{Player, State}

  @spec start(String.t()) :: no_return
  def start(player_name) when is_binary(player_name) do
    new_game(engine_node(), game_name())
    |> State.new(player_name)
    |> Player.play()
  end

  ## Private functions

  @spec game_name :: String.t()
  defp game_name do
    length = Enum.random(4..10)

    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    # Starting at 0 with length "length"...
    |> binary_part(0, length)
  end

  @spec engine_node :: node
  defp engine_node, do: get_env(:engine_node)

  @spec new_game(node, String.t()) :: String.t() | no_return
  defp new_game(engine_node, game_name) do
    if Node.connect(engine_node) do
      IO.puts("Connected to node #{inspect(engine_node)}.")
    else
      IO.puts("Cannot connect to node #{inspect(engine_node)}.")
      self() |> Process.exit(:normal)
    end

    :ok = :global.sync()

    case :rpc.call(engine_node, Engine, :new_game, [game_name]) do
      {:ok, _pid} ->
        game_name

      {:badrpc, :nodedown} ->
        IO.puts("Hangman Engine node #{inspect(engine_node)} is down.")
        self() |> Process.exit(:normal)

      {:badrpc, {:EXIT, {:undef, _}}} ->
        IO.puts("Hangman Engine not started on node #{inspect(engine_node)}.")
        self() |> Process.exit(:normal)

      error ->
        exit(error)
    end
  end
end
