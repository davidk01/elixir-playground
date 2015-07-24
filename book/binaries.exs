defmodule Binaries do
  def parse_file(filename) do
    {:ok, f} = File.open(filename)
    for line <- IO.stream(f, :line) do
      [id, state, amount] = String.rstrip(line) |> String.split(",")
      [id: id, ship_to: state, net_amount: amount]
    end
  end
end
