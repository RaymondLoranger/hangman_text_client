defmodule Hangman.Text.Client.Engine do
  use PersistConfig

  alias Hangman.{Engine, Game}
  alias Hangman.Engine.TopSup
  # alias Hangman.Text.Client.{Player, State}

  @spec new_game(node, Game.name()) :: Game.name() | no_return
  def new_game(:nonode@nohost = _node) do
    {:ok, _pid} = TopSup.start(:normal, :ok)
  end
  def new_game(engine_node, game_name) do
    if Node.connect(engine_node) do
      IO.puts("Connected to node #{inspect(engine_node)}...")
    else
      IO.puts("Cannot connect to node #{inspect(engine_node)}.")
      self() |> Process.exit(:normal)
    end

    # Synchronizes the global name server with all nodes known to this node.
    :ok = :global.sync()

    # Remote procedure call to call a function on a remote node.
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


  ## Private functions

  @spec engine_node :: node
  defp engine_node, do: get_env(:engine_node)
end
