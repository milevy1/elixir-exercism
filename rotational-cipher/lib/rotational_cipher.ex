defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(fn char ->
      cond do
        char in [48, 49, 50, 51, 52, 53, 54, 55, 56, 57] -> char # integers
        char == 32 -> 32
        char + shift > 122 ->
          char - rem(shift, 26) # 122 == 'z' so looping alphabet
        true -> char + shift
      end
    end)
    |> List.to_string
  end

  defp upcase?(char), do: char == String.upcase(char)
end
