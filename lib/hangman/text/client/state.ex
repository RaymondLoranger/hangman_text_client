defmodule Hangman.Text.Client.State do
  @moduledoc """
  Creates a state struct for the _Hangman Game_.

  The state struct contains the fields:

    - `game_name`
    - `tally`
    - `guess`

  representing the properties of a state in the _Hangman Game_.
  """

  alias __MODULE__
  alias Hangman.{Engine, Game}

  @enforce_keys [:game_name, :tally]
  defstruct [:game_name, :tally, :guess]

  @typedoc "A state struct for the Hangman Game"
  @type t :: %State{
          game_name: Game.name(),
          tally: Game.tally(),
          guess: Game.letter() | nil
        }

  @doc """
  Creates a state struct from a `game_name`.
  """
  @spec new(Game.name()) :: t
  def new(game_name) do
    %State{
      game_name: game_name,
      tally: Engine.tally(game_name)
    }
  end
end
