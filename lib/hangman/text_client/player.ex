defmodule Hangman.TextClient.Player do
  # @moduledoc """
  # Models a Hangman game player.
  # """
  @moduledoc false

  alias Hangman.Engine
  alias Hangman.TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing
  @spec play(State.t()) :: no_return
  def play(%State{tally: %{game_state: :won}} = state) do
    end_game(state, "You WON!")
  end

  def play(%State{tally: %{game_state: :lost}} = state) do
    end_game(state, "Sorry, you lost.")
  end

  def play(%State{tally: %{game_state: :good_guess}} = state) do
    continue(state, "Good guess!")
  end

  def play(%State{tally: %{game_state: :bad_guess}} = state) do
    continue(state, "Sorry, '#{state.guess}' not in the word...")
  end

  def play(%State{tally: %{game_state: :already_used}} = state) do
    continue(state, "Letter '#{state.guess}' already used...")
  end

  def play(%State{} = state), do: continue(state)

  @spec end_game(State.t(), String.t()) :: true
  def end_game(%State{player: player} = state, msg) do
    Summary.display(state)
    IO.puts(msg)
    Engine.end_game(player)
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
