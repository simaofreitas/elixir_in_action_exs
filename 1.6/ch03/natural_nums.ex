defmodule NaturalNums do
  def print(x) when x <= 0, do: 0
  def print(1), do: IO.puts(1)

  def print(n) do
    print(n - 1)
    IO.puts(n)
  end
end
