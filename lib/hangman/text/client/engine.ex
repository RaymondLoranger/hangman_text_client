defmodule Hangman.Text.Client.Engine do
  @moduledoc """
  Starts a game locally or remotely:

    - locally when local node is not alive (`:nonode@nohost`)
    - remotely on node `:hangman_engine@<hostname>` otherwise
  """

  use PersistConfig

  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.{Engine, Game}
  alias Hangman.Text.Client

  alias Hangman.Text.Client.Message.{
    CannotConnectToNode,
    ConnectedToNode,
    EngineNodeDown,
    EngineNotStarted,
    EnsureEngineStarted,
    GameAlreadyStarted
  }

  @doc """
  Starts locally or remotely a _Hangman Game_ named `game_name`.
  """
  @spec new_game(Game.name()) :: Game.name() | no_return
  def new_game(game_name), do: node() |> new_game(game_name)

  ## Private functions

  @spec new_game(node, Game.name()) :: Game.name() | no_return
  defp new_game(:nonode@nohost = _local_node, game_name) do
    {:ok, _apps} = Application.ensure_all_started(:hangman_engine)
    {:ok, _pid} = Engine.new_game(game_name)
    game_name
  end

  defp new_game(_local_node, game_name) do
    engine_node = Client.engine_node()

    if Node.connect(engine_node) do
      ConnectedToNode.message(engine_node) |> ANSI.puts()
    else
      CannotConnectToNode.message(engine_node) |> ANSI.puts()
      self() |> Process.exit(:normal)
    end

    # Synchronizes the global name server with all nodes known to this node.
    :ok = :global.sync()

    # Remote procedure call to call a function on a remote node.
    case :rpc.call(engine_node, Engine, :new_game, [game_name]) do
      {:ok, _pid} ->
        game_name

      # E.g. `Hangman.Text.Client.start("scaffold")` on 2 client nodes.
      {:error, {:already_started, _pid}} ->
        GameAlreadyStarted.message(game_name, engine_node) |> ANSI.puts()
        self() |> Process.exit(:normal)

      # Extremely unlikely since we've already connected at this point.
      {:badrpc, :nodedown} ->
        EngineNodeDown.message(engine_node) |> ANSI.puts()
        self() |> Process.exit(:normal)

      # E.g. `iex --sname hangman_engine` without adding option `-S mix`.
      {:badrpc, {:EXIT, {:undef, _}}} ->
        EngineNotStarted.message(engine_node) |> ANSI.puts()
        self() |> Process.exit(:normal)

      # `:noproc` when client node itself is `:hangman_engine@<hostname>`
      # or on the engine node after app `:hangman_engine` crashed/exited.
      # To fix the issue: Application.ensure_all_started(:hangman_engine)
      {:badrpc, {:EXIT, {:noproc, _}}} ->
        EnsureEngineStarted.message(engine_node) |> ANSI.puts()
        self() |> Process.exit(:normal)

      error ->
        exit(error)
    end
  end
end
