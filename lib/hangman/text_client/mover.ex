defmodule Hangman.TextClient.Mover do
  # @moduledoc """
  # Makes a Hangman game move.
  # """
  @moduledoc false

  alias Hangman.Engine
  alias Hangman.TextClient.State

  @spec make_move(State.t()) :: State.t()
  def make_move(%State{game_name: game_name, guess: guess} = state),
    do: put_in(state.tally, Engine.make_move(game_name, guess))
end
