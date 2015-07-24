defmodule MyEnum do

  def all?(collection, predicate), do: Enum.reduce(collection, &(predicate.(&1) && &2))

  def each(collection, func) do
    last = Enum.reduce(collection, fn (e, a) -> func.(a); e end)
    func.(last)
  end

  # things will be reversed
  def filter(collection, predicate) do
    Enum.reduce(collection, [], fn (e, a) -> 
      cond do 
        predicate.(e) -> [e | a]
        true -> a 
      end
    end)
  end

  def flatten([]), do: []
  def flatten([h | t]) when is_list(h), do: h |> Enum.concat(t) |> flatten
  def flatten([h | t]), do: [h | flatten(t)] 

end
