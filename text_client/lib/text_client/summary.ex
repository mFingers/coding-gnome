defmodule TextClient.Summary do
  def display(game) do
    IO.puts [
      "\n",
      "Word so far: #{game.tally.letters |> Enum.join}\n",
      "Guesses left: #{game.tally.turns_left}\n",
      # "Letters used: #{game.game_service.used |> MapSet.to_list |> Enum.join(", ")}"
    ]
    game
  end
end
