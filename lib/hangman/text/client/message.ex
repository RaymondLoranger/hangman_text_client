defmodule Hangman.Text.Client.Message do
  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Game

  @spec cannot_connect_to_node(node, node) :: ANSI.ansilist()
  def cannot_connect_to_node(local_node, engine_node) do
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

  @spec connected_to_node(node, node) :: ANSI.ansilist()
  def connected_to_node(local_node, engine_node) do
    [
      :light_yellow,
      "Local node ",
      :light_white,
      "#{inspect(local_node)}",
      :light_yellow,
      " connected to engine node ",
      :light_white,
      "#{inspect(engine_node)}",
      :light_yellow,
      "..."
    ]
  end

  @spec engine_node_down(node) :: ANSI.ansilist()
  def engine_node_down(node) do
    [
      :light_yellow,
      "Hangman Engine node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      " is down."
    ]
  end

  @spec engine_not_started(node) :: ANSI.ansilist()
  def engine_not_started(node) do
    [
      :light_yellow,
      "Hangman Engine not started on node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end

  @spec ensure_engine_started(node) :: ANSI.ansilist()
  def ensure_engine_started(node) do
    [
      :light_yellow,
      "Ensure Hangman Engine is started on node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end

  @spec game_already_started(Game.name(), node) :: ANSI.ansilist()
  def game_already_started(name, node) do
    [
      :light_yellow,
      "Hangman Game ",
      :light_white,
      "#{name}",
      :light_yellow,
      " already started on engine node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end

  @spec game_started(Game.name(), node, pid) :: ANSI.ansilist()
  def game_started(name, node, pid) do
    [
      :light_yellow,
      "Hangman Game ",
      :light_white,
      "#{name} (#{inspect(pid)})",
      :light_yellow,
      " started on engine node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end
end
