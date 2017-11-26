defmodule TextClient.Player do
  # @moduledoc """
  # Models a Hangman game player.
  # """
  @moduledoc false

  alias TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing
  @spec play(State.t) :: no_return
  def play(%State{tally: %{game_state: :won}} = state) do
    end_game(state, "You WON!")
  end
  def play(%State{tally: %{game_state: :lost}} = state) do
    end_game(state, "Sorry, you lost!")
  end
  def play(%State{tally: %{game_state: :good_guess}} = state) do
    continue(state, "Good guess!")
  end
  def play(%State{tally: %{game_state: :bad_guess}} = state) do
    continue(state, "Sorry, not in the word...")
  end
  def play(%State{tally: %{game_state: :already_used}} = state) do
    continue(state, "Letter already used...")
  end
  def play(%State{} = state), do: continue(state)

  @spec end_game(State.t, String.t) :: :ok
  def end_game(%State{player: player} = state, msg) do
    Summary.display(state)
    IO.puts(msg)
    Hangman.end_game(player)
  end

  ## Private functions

  @spec continue(State.t, String.t | nil) :: no_return
  defp continue(state, msg \\ nil) do
    if msg, do: IO.puts(msg)
    state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end
end
