defmodule Gameest do
  use ExUnit.Case, async: true

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game letters are all lowercase" do
    game = Game.new_game
    assert game.letters |> (Enum.all? fn(l) -> l =~ ~r/^[a-z]*$/ end)
  end

  test "state isn't changed for a won game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game |> Map.put(:game_state, state)
      assert { game, _ } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game
    { game, _ } = Game.make_move(game, "x")
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left === 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "w")
    { game, _ } = Game.make_move(game, "i")
    { game, _ } = Game.make_move(game, "b")
    { game, _ } = Game.make_move(game, "l")
    { game, _ } = Game.make_move(game, "e")
    assert game.game_state == :won
  end

  test "a bad guessed is recognized" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "game lost" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "a")
    assert game.turns_left == 6
    { game, _ } = Game.make_move(game, "h")
    assert game.turns_left == 5
    { game, _ } = Game.make_move(game, "c")
    assert game.turns_left == 4
    { game, _ } = Game.make_move(game, "d")
    assert game.turns_left == 3
    { game, _ } = Game.make_move(game, "j")
    assert game.turns_left == 2
    { game, _ } = Game.make_move(game, "f")
    assert game.turns_left == 1
    { game, _ } = Game.make_move(game, "g")
    assert game.game_state == :lost
    assert game.turns_left == 0
  end
end
