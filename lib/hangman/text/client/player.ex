defmodule Hangman.Text.Client.Player do
  @moduledoc """
  Plays a game until it is won, lost or stopped.
  """

  alias Hangman.{Game, Engine}
  alias Hangman.Text.Client.{Mover, Prompter, State, Summary}

  @alphabet Enum.map(?a..?z, &<<&1>>)
  @bad :light_red
  @emit? true
  @good :light_green
  @lost :light_magenta
  @rep :light_yellow
  @won :light_cyan

  @doc """
  Plays a game until it is won, lost or stopped.
  """
  # won, lost, good guess, bad guess, already used, initializing...
  @spec play(State.t()) :: no_return
  def play(%State{tally: %{game_state: :won}} = state),
    do: end_game(state, [@won, "Bravo, you WON!"])

  def play(%State{tally: %{game_state: :lost}} = state),
    do: end_game(state, [@lost, "Sorry, you lost."])

  def play(%State{tally: %{game_state: :good_guess}} = state),
    do: continue(state, [@good, "Good guess!"])

  def play(%State{tally: %{game_state: :bad_guess}} = state),
    do: continue(state, [@bad, "Bad guess..."])

  def play(%State{tally: %{game_state: :already_used}} = state),
    do: continue(state, [@rep, "Already used..."])

  # initializing
  def play(%State{} = state), do: continue(state)

  @doc """
  Displays a `message` and ends the game normally.
  """
  @spec end_game(State.t(), IO.ANSI.ansidata()) :: no_return
  def end_game(%State{tally: tally, game_name: game_name}, message) do
    message |> IO.ANSI.format(@emit?) |> IO.puts()
    tally = win_lose(tally, game_name)
    IO.puts("\nThe word was: #{Enum.join(tally.letters, " ")}")
    Engine.end_game(game_name)
    self() |> Process.exit(:normal)
  end

  ## Private functions

  @spec continue(State.t(), IO.ANSI.ansidata()) :: no_return
  defp continue(state, message) do
    message |> IO.ANSI.format(@emit?) |> IO.puts()
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

  @spec win_lose(Game.tally(), Game.name()) :: Game.tally()
  defp win_lose(%{game_state: game_state} = tally, _game_name)
       when game_state in [:won, :lost],
       do: tally

  defp win_lose(%{guesses: guesses}, game_name) do
    [guess | _] = @alphabet -- guesses
    Engine.make_move(game_name, guess) |> win_lose(game_name)
  end
end
