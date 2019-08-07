defmodule RomanNumerals do
  @integers [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
  @romans ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]

  def numeral(0), do: ""

  def numeral(number) do
    integer = Enum.find(@integers, fn integer -> number >= integer end)
    integer_index = Enum.find_index(@integers, fn integer -> number >= integer end)
    roman_numeral = Enum.at(@romans, integer_index)

    roman_numeral <> numeral(number - integer)
  end
end
