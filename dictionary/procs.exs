defmodule Procs do
  def greet(count) do
    receive do
      {:boom, reason} ->
        exit(reason)

      {:add, n} ->
        greet(count + n)

      :reset ->
        greet(0)

      msg ->
        IO.puts("#{count}: Hello, #{inspect msg}")
        greet(count)
    end
  end
end
