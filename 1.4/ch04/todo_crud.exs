defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new, do: %TodoList{}

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
