defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code <= 0 or code >= 32, do: []
  def commands(code) do
    Integer.to_string(code, 2)
    |> String.graphemes
    |> Enum.reverse
    |> Stream.with_index
    |> reverse?
    |> Enum.map(fn x -> secret(x) end)
    |> Enum.reject(&is_nil/1)
  end

  def secret(x) do
    case x do
      {"1", 0} -> "wink"
      {"1", 1} -> "double blink"
      {"1", 2} -> "close your eyes"
      {"1", 3} -> "jump"
      {_, _} -> nil
    end
  end

  def reverse?(list) do
    cond do
      Enum.at(list, 4) == {"1", 4} -> Enum.reverse(list) |> Enum.slice(1..-1)
      true -> list
    end
  end
end
