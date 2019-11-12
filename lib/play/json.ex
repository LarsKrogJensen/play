defmodule Play.Json do

  @spec jsonize_keys(map(), [:atom]) :: map()
  def jsonize_keys(json, fields) do
    # fields is a list of atoms
    json
    |> Map.take(fields)
    |> Enum.map(fn ({key, value}) -> {to_json_key(key), value} end)
    |> Enum.into(%{})
  end

  @spec atomize_keys(map(), [:atom]) :: map()
  def atomize_keys(json, fields) do
    keys = Enum.map(fields, &Atom.to_string/1)
           |> Enum.map(&Recase.to_camel/1)
    json
    |> Map.take(keys)
    |> Enum.map(fn ({key, value}) -> {from_json_key(key), value} end)
    |> Enum.into(%{})
  end

  @spec to_json_key(:atom) :: String.t()
  defp to_json_key(key) do
    key
    |> Atom.to_string
    |> Recase.to_camel
  end

  @spec to_json_key(String.t()) :: :atom
  defp from_json_key(key) do
    key
    |> Recase.to_snake
    |> String.to_atom
  end

end
