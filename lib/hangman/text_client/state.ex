defmodule Hangman.TextClient.State do
  # @moduledoc """
  # Holds the state of a text client playing the Hangman game.
  # """
  @moduledoc false

  alias __MODULE__
  alias Hangman.Engine
  alias Hangman.Engine.Game

  @enforce_keys [:player, :tally]
  defstruct(
    player: "",
    tally: %{},
    guess: ""
  )

  @type t :: %State{
          player: String.t(),
          tally: Game.tally(),
          guess: String.codepoint()
        }

  @spec init(String.t()) :: t
  def init(player), do: %State{player: player, tally: Engine.tally(player)}
end
