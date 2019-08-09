defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    clean_non_bracket_chars(str)
    |> split_to_charlist
    |> build_bracket_stack
    |> all_brackets_closed?
  end

  def clean_non_bracket_chars(str) do
    String.replace(str, ~r/[^\(\)\[\]\{\}]/, "")
  end

  def split_to_charlist(str) do
    String.split(str, "", trim: true)
  end

  def build_bracket_stack(charlist) do
    Enum.reduce(charlist, [], fn x, acc ->
     case {x, Enum.at(acc, -1)} do
       {")", "("} -> Enum.drop(acc, -1)
       {"]", "["} -> Enum.drop(acc, -1)
       {"}", "{"} -> Enum.drop(acc, -1)
       {_, _} -> acc ++ [x]
     end
   end)
  end

  def all_brackets_closed?(charlist) do
    length(charlist) == 0
  end
end
