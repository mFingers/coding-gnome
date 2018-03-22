defmodule GallowsSocketWeb.HangmanChannel do
  require Logger
  use Phoenix.Channel

  def join("hangman:game", _, socket) do
    game = Hangman.new_game
    socket = assign(socket, :game, game)
    { :ok, socket }
  end

  def handle_in("tally", _, socket) do
    tally = socket.assigns.game |> Hangman.tally
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in(message, _, _socket) do
    Logger.error("Unknown message #{message}")
  end
end
