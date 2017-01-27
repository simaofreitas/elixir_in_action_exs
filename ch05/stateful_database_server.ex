defmodule DatabaseServer do
  def start do
    spawn(fn ->
      connection = :rand.uniform(100)
      loop(connection)
    end)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def loop(connection) do
    receive do
      {:run_query, caller, query_def} ->
        query_result = connection |> run_query(query_def)
        send(caller, {:query_result, query_result})
    end

    loop(connection)
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after 5000 ->
      {:error, :timeout}
    end
  end

  defp run_query(connection, query_def) do
    :timer.sleep(2000)
    "Connection #{connection}: #{query_def} result"
  end
end
