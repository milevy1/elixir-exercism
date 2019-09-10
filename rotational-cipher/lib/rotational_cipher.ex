defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> Enum.map(fn char -> rotate_char(char, shift) end)
    |> to_string
  end

  def rotate_char(char, shift) when char + shift < 123 do # normal shift
    char + shift
  end

  def rotate_char(char, shift) do # shift loops alphabet
    rotate_char(97, char + shift - 123)
  end
end
