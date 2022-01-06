defmodule Hangman.Text.Client.Mover do
  @moduledoc """
  Makes a move by guessing a letter.
  """

  alias Hangman.Engine
  alias Hangman.Text.Client.State

  @doc """
  Makes a move by guessing a letter.
  """
  @spec make_move(State.t()) :: State.t()
  def make_move(%State{game_name: game_name, guess: guess} = state),
    do: put_in(state.tally, Engine.make_move(game_name, guess))
end
