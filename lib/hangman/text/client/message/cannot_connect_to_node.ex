defmodule Hangman.Text.Client.Message.CannotConnectToNode do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node) :: ANSI.ansilist()
  def message(node) do
    [
      :light_yellow,
      "Cannot connect to node ",
      :light_white,
      :italic,
      "#{inspect(node)}",
      :light_yellow,
      :not_italic,
      "."
    ]
  end
end
