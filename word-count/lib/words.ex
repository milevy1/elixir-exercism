defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    downcase(sentence)
    |> clean_special_chars
    |> split_on(" ", "_")
    |> Enum.reduce(%{}, fn word, accumulator -> build_word_count(word, accumulator) end)
  end

  def split_on(sentence, " ", "_") do
    String.split(sentence, ~r/ |\_/, trim: true)
  end

  def downcase(word) do
    String.downcase(word)
  end

  def clean_special_chars(word) do
    String.replace(word, ~r/[^A-Za-z0-9\-ö\_ ]/, "")
  end

  def build_word_count(word, accumulator) do
    Map.update(accumulator, word, 1, &(&1 + 1))
  end
end
