defmodule TextClient.State do
  # @moduledoc """
  # Holds the state of a text client playing the Hangman game.
  # """
  @moduledoc false

  alias __MODULE__
  alias Hangman.Game

  defstruct(
    player: "",
    tally: %{},
    guess: ""
  )

  @type t :: %State{
               player: String.t,
               tally: Game.tally,
               guess: String.codepoint
             }

  @spec init(String.t) :: t
  def init(player) do
    %State{player: player, tally: Hangman.tally(player)}
  end
end
