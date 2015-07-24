defmodule Guess do
  def guess(actual, low..high) when low === high, do: low
  def guess(actual, low..high) when low + 1 === high and actual > low, do: high
  def guess(actual, low..high) when actual <= div(low + high, 2) do
    IO.puts "Guessing #{div(low + high, 2)}."
    guess(actual, low..div(low + high, 2))
  end
  def guess(actual, low..high) when actual >= div(low + high, 2) do
    IO.puts "Guessing #{div(low + high, 2)}."
    guess(actual, div(low + high, 2)..high)
  end
end
