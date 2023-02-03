defmodule Hangman.Text.Client.Message.ConnectedToNode do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node) :: ANSI.ansilist()
  def message(node) do
    [
      :gold,
      "Connected to node ",
      :light_white,
      :italic,
      "#{inspect(node)}",
      :gold,
      :not_italic,
      "..."
    ]
  end
end
