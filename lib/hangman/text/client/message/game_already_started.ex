defmodule Hangman.Text.Client.Message.GameAlreadyStarted do
  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Game

  @spec message(Game.name(), node) :: ANSI.ansilist()
  def message(name, node) do
    [
      :gold,
      "Hangman Game ",
      :light_white,
      :italic,
      "#{name}",
      :gold,
      :not_italic,
      " already started on node ",
      :light_white,
      :italic,
      "#{inspect(node)}",
      :gold,
      :not_italic,
      "."
    ]
  end
end
