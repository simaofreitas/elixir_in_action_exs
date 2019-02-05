defmodule Extract do
  def missing(user, list) do
    case Enum.filter(list, &(not Map.has_key?(user, &1))) do
      [] ->
        {:ok,
         %{
           login: user["login"],
           email: user["email"],
           password: user["password"]
         }}

      missing_fields ->
        {:error, "missing fields: #{Enum.join(missing_fields, ", ")}"}
    end
  end
end

# Extract.missing(%{"login" => "simao", "stuff" => "123", "email" => "wef@fwe", "password" => "evrwv"}, ["login", "email", "password"])
