defmodule Hangman.Text.Client.Player do
  @moduledoc """
  Plays a game until it is won, lost or stopped.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Engine
  alias Hangman.Text.Client.{Mover, Prompter, State, Summary}

  @doc """
  Plays a game until it is won, lost or stopped.
  """
  # won, lost, good guess, bad guess, already used, initializing...
  @spec play(State.t()) :: no_return
  def play(%State{tally: %{game_state: :won}} = state),
    do: end_game(state, [:light_cyan, "Bravo, you WON!"])

  def play(%State{tally: %{game_state: :lost}} = state),
    do: end_game(state, [:fuchsia, "Sorry, you lost."])

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
  def end_game(%State{game_name: game_name, tally: tally}, message)
      when tally.game_state in [:won, :lost] do
    ANSI.puts(message)

    word =
      Enum.map(tally.letters, fn
        [letter] -> [:light_red, " ", letter]
        letter -> [:light_cyan, " ", letter]
      end)

    ["\nWord was: ", word] |> ANSI.puts()
    Engine.end_game(game_name)
    self() |> Process.exit(:normal)
  end

  def end_game(%State{game_name: game_name} = state, message) do
    # Game was stopped or ended: resign to reveal missing letters.
    state = put_in(state.tally, Engine.resign(game_name))
    end_game(state, message)
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
end
