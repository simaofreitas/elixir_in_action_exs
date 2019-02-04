defmodule MultiDict do
  def new, do: %{}

  def add(list, key, value) do
    Map.update(
      list,
      key,
      [value],
      &[value | &1]
    )
  end

  def get(list, key) do
    Map.get(list, key, [])
  end
end

defmodule TodoList do
  def new, do: MultiDict.new

  def add_entry(list, date, title) do
    MultiDict.add(list, date, title)
  end

  def entries(list, date) do
    MultiDict.get(list, date)
  end
end
