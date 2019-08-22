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
  def parse(input) do
    # patch(Enum.join(Enum.map(String.split(m, "\n"), fn t -> process(t) end)))
    String.split(input, "\n")
    |> Enum.map(fn line -> process(line) end)
    |> Enum.join
    |> patch
  end

  # defp process(t) do
  #   if String.starts_with?(t, "#") || String.starts_with?(t, "*") do
  #     if String.starts_with?(t, "#") do
  #       enclose_with_header_tag(parse_header_md_level(t))
  #     else
  #       parse_list_md_level(t)
  #     end
  #   else
  #     enclose_with_paragraph_tag(String.split(t))
  #   end
  # end

  defp process(input) when is_list(input) do

  end

  defp process(input) when is_binary(input) do
    [head | tail] = String.to_char(input)
    process([head | tail])
  end

  defp process(<<first_char :: binary-size(1)>> <> _tail = line) when first_char == "#" do
    parse_header_md_level(line)
    |> enclose_with_header_tag
  end

  defp process(<<first_char :: binary-size(1)>> <> _tail = line) when first_char == "*" do
    parse_list_md_level(line)
  end

  defp process(line) do
    String.split(line)
    |> enclose_with_paragraph_tag
  end

  defp parse_header_md_level(line) do
    [h | t] = String.split(line)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h" <> hl <> ">" <> htl <> "</h" <> hl <> ">"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    Enum.join(Enum.map(t, fn w -> replace_md_with_tag(w) end), " ")
  end

  defp replace_md_with_tag(w) do
    replace_suffix_md(replace_prefix_md(w))
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp patch(l) do
    String.replace_suffix(
      String.replace(l, "<li>", "<ul>" <> "<li>", global: false),
      "</li>",
      "</li>" <> "</ul>"
    )
  end
end
