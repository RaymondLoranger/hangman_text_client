defmodule Hangman.Text.Client.Engine do
  @moduledoc """
  Starts a game locally or remotely:

    - locally when local node is inactive
    - remotely on node `:hangman_engine@<hostname>` otherwise
  """
  use PersistConfig

  alias Hangman.{Engine, Game}

  @doc """
  Starts a game locally or remotely.
  """
  @spec new_game(node) :: Game.name() | no_return
  def new_game(:nonode@nohost = _local_node) do
    {:ok, _apps} = Application.ensure_all_started(:hangman_engine)
    game_name = Game.random_name()
    {:ok, _pid} = Engine.new_game(game_name)
    game_name
  end

  def new_game(local_node) do
    {engine_node, game_name} = {engine_node(), "#{local_node}"}

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

      {:badrpc, {:EXIT, {reason, _}}} when reason in [:undef, :noproc] ->
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
