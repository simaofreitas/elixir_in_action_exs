defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(%TodoList{entries: entries, auto_id: auto_id} = list, entry) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, auto_id, entry)

    %TodoList{list | entries: new_entries, auto_id: auto_id + 1}
  end

  def entries(%TodoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn({_, entry}) -> entry.date == date end)
    |> Enum.map(fn({_, entry}) -> entry end)
  end

  def update_entry(list, %{} = new_entry) do
    update_entry(list, new_entry.id, fn(_) -> new_entry end)
  end

  def update_entry(%TodoList{entries: entries} = list, entry_id, updater_fn) do
    case entries[entry_id] do
      nil -> list
      old_entry ->
        new_entry = updater_fn.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %TodoList{ list | entries: new_entries }
    end
  end

  def delete_entry(%TodoList{entries: entries} = list, entry_id) do
    %TodoList{ list | entries: Map.delete(entries, entry_id) }
  end
end

defmodule TodoList.CsvImporter do
  def read_file(file) do
    file
    |> read_lines
    |> create_entries
    |> TodoList.new
  end

  defp read_lines(file_name) do
    file_name
    |> File.stream!
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  defp create_entries(lines) do
    lines
    |> Stream.map(&extract_fields/1)
    |> Stream.map(&create_entry/1)
  end

  defp extract_fields(line) do
    line
    |> String.split(",")
    |> convert_fields_to_tuple
  end

  defp convert_fields_to_tuple([date, title]) do
    {parse_date(date), title}
  end

  defp parse_date(date_string) do
    date_string
    |> String.split("/")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  defp create_entry({date, title}) do
    %{date: date, title: title}
  end
end
