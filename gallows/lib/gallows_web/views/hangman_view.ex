defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def join(characters), do: characters |> Enum.join(" ")
end
