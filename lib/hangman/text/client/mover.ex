defmodule Hangman.Text.Client.Mover do
  @moduledoc """
  Makes a _Hangman Game_ move.
  """

  alias Hangman.Engine
  alias Hangman.Text.Client.State

  @spec make_move(State.t()) :: State.t()
  def make_move(%State{game_name: game_name, guess: guess} = state),
    do: put_in(state.tally, Engine.make_move(game_name, guess))
end
