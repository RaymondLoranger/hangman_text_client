defmodule Hangman.Text.Client.Player do
  alias Hangman.Engine
  alias Hangman.Text.Client.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing...
  @spec play(State.t()) :: no_return
  def play(%State{tally: %{game_state: :won}} = state),
    do: end_game(state, "Bravo, #{state.player_name}, you WON!")

  def play(%State{tally: %{game_state: :lost}} = state),
    do: end_game(state, "Sorry, #{state.player_name}, you lost.")

  def play(%State{tally: %{game_state: :good_guess}} = state),
    do: continue(state, "Good guess!")

  def play(%State{tally: %{game_state: :bad_guess}} = state),
    do: continue(state, "Letter '#{state.guess}' not in the word...")

  def play(%State{tally: %{game_state: :already_used}} = state),
    do: continue(state, "Letter '#{state.guess}' already used...")

  # initializing
  def play(%State{} = state), do: continue(state)

  @spec end_game(State.t(), String.t()) :: no_return
  def end_game(%State{tally: tally, game_name: game_name}, msg) do
    IO.puts(msg)
    IO.puts("\nThe word was: #{Enum.join(tally.letters, " ")}")
    Engine.end_game(game_name)
    self() |> Process.exit(:normal)
  end

  ## Private functions

  @spec continue(State.t(), String.t()) :: no_return
  defp continue(state, msg) do
    IO.puts(msg)
    continue(state)
  end

  @spec continue(State.t()) :: no_return
  defp continue(state) do
    state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end
end
