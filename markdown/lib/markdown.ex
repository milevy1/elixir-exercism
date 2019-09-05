defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  # Refactored nested callbacks to pipe operators
  def parse(input) do
    String.split(input, "\n")
    |> Enum.map_join(&process/1)
    |> add_unordered_list_tags
  end

  # Refactored .process nested if statements into multiple
  # functions with guards checking the first char value
  # Refactored nested callbacks to pipe operators
  defp process("#" <> _tail = line) do
    parse_header_md_level(line)
    |> enclose_with_header_tag
  end

  defp process("*" <> _tail = line) do
    parse_list_md_level(line)
  end

  # Refactored nested callbacks to pipe operators
  defp process(line) do
    String.split(line)
    |> enclose_with_paragraph_tag
  end

  # Added helper function .header_size
  defp parse_header_md_level(line) do
    [h | t] = String.split(line)
    {header_size(h), Enum.join(t, " ")}
  end

  defp header_size(header), do: String.length(header) |> to_string

  # Refactored nested callbacks to pipe operators
  # Renamed argument "l" to "line"
  defp parse_list_md_level(line) do
    words = String.trim_leading(line, "* ") |> String.split
    "<li>" <> join_words_with_tags(words) <> "</li>"
  end

  # Renamed argument "htl" to "words"
  # Renamed argument "h" to "header_size"
  defp enclose_with_header_tag({header_size, words}) do
    "<h" <> header_size <> ">" <> words <> "</h" <> header_size <> ">"
  end

  # Renamed argument "t" to "line"
  defp enclose_with_paragraph_tag(line) do
    "<p>#{join_words_with_tags(line)}</p>"
  end

  # Refactored nested callbacks to pipe operators
  # Renamed argument "t" to "words"
  # Renamed fn variable "w" to "word"
  defp join_words_with_tags(words) do
    Enum.map_join(words, " ", &replace_md_with_tag/1)
  end

  # Renamed argument "w" to "word"
  defp replace_md_with_tag(word) do
    replace_prefix_md(word) |> replace_suffix_md
  end

  # Renamed argument "w" to "word"
  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  # Renamed argument "w" to "word"
  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  # Renamed .patch to .add_unordered_list_tags
  # Refactored nested callbacks to pipe operators
  # Renamed argument "l" to "line"
  defp add_unordered_list_tags(line) do
    String.replace(line, "<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
