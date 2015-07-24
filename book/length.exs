defmodule Length do
  def len([]), do: 0
  def len([h | t]), do: 1 + len(t)
end
