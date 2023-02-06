defmodule Hangman.Text.Client.Player do
  @moduledoc """
  Plays a game until it is won, lost or stopped.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.{Game, Engine}
  alias Hangman.Text.Client.{Mover, Prompter, State, Summary}

  @alphabet Enum.map(?a..?z, &<<&1>>)

  @doc """
  Plays a game until it is won, lost or stopped.
  """
  # won, lost, good guess, bad guess, already used, initializing...
  @spec play(State.t()) :: no_return
  def play(%State{tally: %{game_state: :won}} = state),
    do: end_game(state, [:light_cyan, "Bravo, you WON!"])

  def play(%State{tally: %{game_state: :lost}} = state),
    do: end_game(state, [:light_magenta, "Sorry, you lost."])

  def play(%State{tally: %{game_state: :good_guess}} = state),
    do: continue(state, [:light_green, "Good guess!"])

  def play(%State{tally: %{game_state: :bad_guess}} = state),
    do: continue(state, [:light_red, "Bad guess..."])

  def play(%State{tally: %{game_state: :already_used}} = state),
    do: continue(state, [:light_yellow, "Already used..."])

  # initializing
  def play(%State{} = state), do: continue(state)

  @doc """
  Displays a `message` and ends the game normally.
  """
  @spec end_game(State.t(), ANSI.ansilist()) :: no_return
  def end_game(%State{tally: tally, game_name: game_name}, message) do
    ANSI.puts(message)
    # Ensure all letters are revealed...
    %{letters: letters} = win_lose(tally, game_name)
    ["\nWord was: ", :light_cyan, " #{Enum.join(letters, " ")}"] |> ANSI.puts()
    Engine.end_game(game_name)
    self() |> Process.exit(:normal)
  end

  ## Private functions

  @spec continue(State.t(), ANSI.ansilist()) :: no_return
  defp continue(state, message \\ []) do
    unless Enum.empty?(message), do: ANSI.puts(message)

    state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  @spec win_lose(Game.tally(), Game.name()) :: Game.tally()
  defp win_lose(%{game_state: game_state} = tally, _game_name)
       when game_state in [:won, :lost],
       do: tally

  # If game was stopped, keep guessing until it's won or lost.
  defp win_lose(%{guesses: guesses}, game_name) do
    [guess | _] = @alphabet -- guesses
    Engine.make_move(game_name, guess) |> win_lose(game_name)
  end
end
