defmodule Bob do

   def hey(string) do
     cond do
       is_question?(string) -> "Sure."
       is_shouting?(string) -> "Whoa, chill out!"
       true -> "Whatever."
     end
   end

   def is_question?(string) do
     String.ends_with?(string, "?")
   end

   def is_shouting?(string) do
     string == String.upcase(string)
   end

end
