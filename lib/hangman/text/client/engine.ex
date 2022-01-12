defmodule Hangman.Text.Client.Engine do
  @moduledoc """
  Starts a game locally or remotely:

    - locally when local node is not alive
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
    game_name = Atom.to_string(local_node)
    engine_node = engine_node()

    if Node.connect(engine_node) do
      puts(:connected, {engine_node})
    else
      puts(:cannot_connect, {engine_node})
      self() |> Process.exit(:normal)
    end

    # Synchronizes the global name server with all nodes known to this node.
    :ok = :global.sync()

    # Remote procedure call to call a function on a remote node.
    case :rpc.call(engine_node, Engine, :new_game, [game_name]) do
      {:ok, _pid} ->
        game_name

      {:error, {:already_started, _pid}} ->
        puts(:game_already_started, {game_name, engine_node})
        game_name

      {:badrpc, :nodedown} ->
        puts(:engine_node_down, {engine_node})
        self() |> Process.exit(:normal)

      {:badrpc, {:EXIT, {reason, _}}} when reason in [:undef, :noproc] ->
        puts(:engine_not_started, {engine_node})
        self() |> Process.exit(:normal)

      error ->
        exit(error)
    end
  end

  ## Private functions

  @spec engine_node :: node
  defp engine_node, do: get_env(:engine_node)

  @spec puts(atom, tuple) :: :ok
  defp puts(:cannot_connect, {node}) do
    IO.puts("Cannot connect to node #{inspect(node)}.")
  end

  defp puts(:connected, {node}) do
    IO.puts("Connected to node #{inspect(node)}...")
  end

  defp puts(:game_already_started, {name, node}) do
    {name, node} = {inspect(name), inspect(node)}
    IO.puts("Hangman Game #{name} already started on node #{node}.")
  end

  defp puts(:engine_node_down, {node}) do
    IO.puts("Hangman Engine node #{inspect(node)} is down.")
  end

  defp puts(:engine_not_started, {node}) do
    IO.puts("Hangman Engine not started on node #{inspect(node)}.")
  end
end
