defmodule Bob do
  @moduledoc """
   This is Bob. :-)
   """

   @doc """
   Returns "Whoa, chill out!" to all capital chars
   Returns "Whatever." to anything else.

   ## Examples

   iex> Bob.hey("WATCH OUT!")
   "Whoa, chill out!"

   iex> Bob.hey("Tom-ay-to, tom-aaaah-to.")
   "Whatever."

   """
   def hey(string) do
     cond do
       string == String.upcase(string) -> "Whoa, chill out!"
       true -> "Whatever."
     end
   end

end
