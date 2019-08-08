defmodule Bob do

   def hey(string) do
     cond do
       is_silent?(string) -> "Fine. Be that way!"
       is_shouting_question?(string) -> "Calm down, I know what I'm doing!"
       is_question?(string) -> "Sure."
       is_shouting?(string) -> "Whoa, chill out!"
       true -> "Whatever."
     end
   end

   def is_silent?(""), do: true
   def is_silent?(string) do
     String.trim(string) == ""
   end

   def is_shouting_question?(string) do
     is_question?(string) && is_shouting?(string)
   end

   def is_question?(string) do
     String.ends_with?(string, "?")
   end

   def is_shouting?(string) do
     string == String.upcase(string) &&
      string != String.downcase(string)
   end

end
