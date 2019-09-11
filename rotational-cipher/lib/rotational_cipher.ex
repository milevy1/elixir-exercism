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

  defguard is_lowercase(char) when char >= 97 and char <= 122
  defguard loops_lower_alphabet(char, shift) when char + shift < 123

  defguard is_uppercase(char) when char >= 65 and char <= 90
  defguard loops_upper_alphabet(char, shift) when char + shift < 91

  def rotate_char(char, shift) when is_lowercase(char) and loops_lower_alphabet(char, shift) do
    char + shift
  end

  def rotate_char(char, shift) when is_lowercase(char) do
    rotate_char(97, char + shift - 123)
  end

  def rotate_char(char, shift) when is_uppercase(char) and loops_upper_alphabet(char, shift) do
    char + shift
  end

  def rotate_char(char, shift) when is_uppercase(char) do
    rotate_char(65, char + shift - 91)
  end

  # All other chars (spaces, punctuation, etc.) are not rotated
  def rotate_char(char, _shift), do: char
end
