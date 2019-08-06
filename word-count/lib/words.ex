defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    split_on(sentence, " ", "_")
    |> Enum.reduce(%{}, fn word, accumulator ->
      downcase(word)
      |> clean_special_chars
      |> reduce_word(accumulator)
    end)
  end

  def split_on(sentence, " ", "_") do
    String.split(sentence, ~r/ |\_/)
  end

  def downcase(word) do
    String.downcase(word)
  end

  def clean_special_chars(word) do
    String.replace(word, ~r/[^A-Za-z0-9\-ö]/, "")
  end

  def reduce_word("", accumulator) do
    accumulator
  end

  def reduce_word(word, accumulator) do
    if accumulator[word] do
      %{accumulator | word => accumulator[word] + 1}
    else
      Map.put(accumulator, word, 1)
    end
  end
end
