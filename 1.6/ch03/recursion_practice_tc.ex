defmodule Rec do
  def list_len(list), do: do_list_len(0, list)

  defp do_list_len(current_length, []), do: current_length
  defp do_list_len(current_length, [_ | tail]), do: do_list_len(current_length + 1, tail)

  def range(a, b), do: do_range([], a, b)

  defp do_range(current_list, a, a), do: current_list ++ [a]
  defp do_range(current_list, a, b), do: do_range(current_list ++ [a], a + 1, b)

  def positive(list), do: get_positives([], list)

  defp get_positives(current_list, []), do: current_list

  defp get_positives(current_list, [head | tail]) do
    case head > 0 do
      true -> get_positives(current_list ++ [head], tail)
      false -> get_positives(current_list, tail)
    end
  end
end
