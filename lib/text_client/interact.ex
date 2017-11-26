defmodule TextClient.Interact do
  # @moduledoc """
  # Interacts with a client playing a Hangman game.
  # """
  @moduledoc false

  alias TextClient.{Player, State}

  @spec start() :: no_return
  def start() do
    Dictionary.random_word()
    |> Hangman.new_game()
    |> State.init()
    |> Player.play()
  end
end
