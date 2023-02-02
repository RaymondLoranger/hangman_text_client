defmodule Hangman.Text.Client.Message.GameAlreadyStarted do
  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Game

  @spec message(Game.name(), node) :: ANSI.ansilist()
  def message(name, node) do
    [
      :light_yellow,
      "Hangman Game ",
      :light_white,
      :italic,
      "#{name}",
      :light_yellow,
      :not_italic,
      " already started on node ",
      :light_white,
      :italic,
      "#{inspect(node)}",
      :light_yellow,
      :not_italic,
      "."
    ]
  end
end
