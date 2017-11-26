defmodule TextClient.Mover do
  # @moduledoc """
  # Makes a Hangman game move.
  # """
  @moduledoc false

  alias TextClient.State

  @spec make_move(State.t) :: State.t
  def make_move(%State{player: player, guess: guess} = state) do
    struct(state, tally: Hangman.make_move(player, guess))
  end
end
