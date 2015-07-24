fizz_buzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, x) -> x
end

Enum.map 1..100, fn n -> IO.puts(fizz_buzz.(rem(n, 3), rem(n, 5), n)) end
