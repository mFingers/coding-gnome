defmodule TextClient.Summary do
  def display(game = %{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{tally.letters |> Enum.join}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters used: #{game.game_service.used |> MapSet.to_list |> Enum.join(", ")}"
    ]
    game
  end
end
