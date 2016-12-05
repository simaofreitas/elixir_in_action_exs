defmodule Ch03Tr do
  def list_len(list) do
    calc_len(0, list)
  end

  defp calc_len(current, []), do: current
  defp calc_len(current, [_|t]), do: calc_len(current+1, t)

  def range(from, to) do
    p_range([], from, to)
  end

  defp p_range(current, from, from), do: current ++ [from]
  defp p_range(current, from, to), do: p_range(current ++ [from], from + 1, to)
  

  def positive(list) do
    p_positive([], list)
  end

  defp p_positive(current, []), do: current
  defp p_positive(current, [h|t]) when h > 0, do: p_positive(current ++ [h], t)
  defp p_positive(current, [_|t]), do: p_positive(current, t)
end
