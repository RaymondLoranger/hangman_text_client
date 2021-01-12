defmodule Hangman.Text.Client.State do
  @moduledoc """
  Holds the state of a text client playing the _Hangman Game_.
  """

  alias __MODULE__
  alias Hangman.Engine
  alias Hangman.Engine.Game

  @enforce_keys [:game_name, :player_name, :tally]
  defstruct(
    game_name: "",
    player_name: "",
    tally: %{},
    guess: ""
  )

  @type player_name :: String.t()
  @type t :: %State{
          game_name: Game.name(),
          player_name: player_name,
          tally: Game.tally(),
          guess: String.codepoint()
        }

  @spec new(Game.name(), player_name) :: t
  def new(game_name, player_name) do
    %State{
      game_name: game_name,
      player_name: player_name,
      tally: Engine.tally(game_name)
    }
  end
end
