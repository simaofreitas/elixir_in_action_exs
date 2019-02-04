defmodule Ch03 do
  def list_len([]), do: 0
  def list_len([_|t]), do: 1 + list_len(t)

  def range(from, from), do: [from]
  def range(from, to), do: [from] ++ range(from + 1, to)

  def positive([]), do: []
  def positive([h|t]) when h > 0, do: [h] ++ positive(t)
  def positive([_|t]), do: positive(t)
end
