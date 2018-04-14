defmodule Hangman.TextClient.Player do
  @moduledoc false

  alias Hangman.Engine
  alias Hangman.TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing
  @spec play(State.t()) :: no_return
  def play(%State{tally: %{game_state: :won}} = state),
    do: end_game(state, "#{state.player_name}, you WON!")

  def play(%State{tally: %{game_state: :lost}} = state),
    do: end_game(state, "#{state.player_name}, you lost.")

  def play(%State{tally: %{game_state: :good_guess}} = state),
    do: continue(state, "Good guess!")

  def play(%State{tally: %{game_state: :bad_guess}} = state),
    do: continue(state, "Sorry, '#{state.guess}' NOT in the word...")

  def play(%State{tally: %{game_state: :already_used}} = state),
    do: continue(state, "Letter '#{state.guess}' already used...")

  def play(%State{} = state), do: continue(state)

  @spec end_game(State.t(), String.t()) :: true
  def end_game(%State{game_name: game_name} = state, msg) do
    Summary.display(state)
    IO.puts(msg)
    Engine.end_game(game_name)
    self() |> Process.exit(:normal)
  end

  ## Private functions

  @spec continue(State.t(), String.t()) :: no_return
  defp continue(state, msg \\ "") do
    unless msg == "", do: IO.puts(msg)

    state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end
end
