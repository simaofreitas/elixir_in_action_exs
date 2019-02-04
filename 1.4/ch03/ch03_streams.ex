defmodule Ch03Streams do
  def line_lenghts!(file) do
    File.stream!(file)
    |> Enum.map(&String.length(&1))
  end

  def longest_line!(file) do
    File.stream!(file)
    |> Stream.map(&(&1))
    |> Enum.max_by(&String.length(&1))
  end

  def longest_line_length!(file) do
    File.stream!(file)
    |> Stream.map(&String.length(&1))
    |> Enum.max
  end

  def words_per_line!(file) do
    File.stream!(file)
    |> Enum.map(&String.split(&1) |> length)
  end
end
