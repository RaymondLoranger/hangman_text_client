defmodule Hangman.Text.Client.Message.CannotConnectToNode do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node, node) :: ANSI.ansilist()
  def message(local_node, engine_node) do
    [
      :light_yellow,
      "Local node ",
      :light_white,
      "#{inspect(local_node)}",
      :light_yellow,
      " cannot connect to engine node ",
      :light_white,
      "#{inspect(engine_node)}",
      :light_yellow,
      "."
    ]
  end
end
