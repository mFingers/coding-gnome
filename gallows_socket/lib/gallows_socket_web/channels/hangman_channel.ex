defmodule GallowsSocketWeb.HangmanChannel do
  require Logger
  use Phoenix.Channel

  def join("hangman:game", _, socket) do
    game = Hangman.new_game
    socket = assign(socket, :game, game)
    { :ok, socket }
  end

  def handle_in("tally", _, socket) do
    socket.assigns.game
    |> Hangman.tally
    |> send_tally(socket)
  end

  def handle_in("make_move", guess, socket) do
    socket.assigns.game
    |> Hangman.make_move(guess)
    |> send_tally(socket)
  end

  def handle_in("new_game", _, socket) do
    socket = socket |> assign(:game, Hangman.new_game)
    { :ok, socket }
  end

  def handle_in(message, _, _socket) do
    Logger.error("Unknown message #{message}")
  end

  defp send_tally(tally = %{ game_state: { :lost, word } }, socket) do
    tally = Map.merge(tally, %{ game_state: :lost, word: word })
    Logger.info (inspect tally)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  defp send_tally(tally, socket) do
    Logger.info (inspect tally)
    push(socket, "tally", tally)
    { :noreply, socket }
  end
end
