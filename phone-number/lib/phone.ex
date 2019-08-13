defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    case {country_code?(cleaned_number(raw)),
          digits?(cleaned_number(raw)),
          contains_letters?(raw),
          String.first(area_code(cleaned_number(raw))),
          exchange_code(cleaned_number(raw))} do
      {_, _, _, _, "0"} -> "0000000000"
      {_, _, _, _, "1"} -> "0000000000"
      {_, _, _, "1", _} -> "0000000000"
      {_, _, _, "0", _} -> "0000000000"
      {"1", 10, false, _, _} -> cleaned_number(raw)
      {"1", 11, false, _, _} -> String.slice(cleaned_number(raw), 1..-1)
      _ -> "0000000000"
    end
  end

  def cleaned_number(raw) do
    String.replace(raw, ~r/\D/, "")
  end

  def contains_letters?(raw) do
    case Regex.run(~r/[a-zA-z]/, raw) do
      nil -> false
      _ -> true
    end
  end

  def country_code?(cleaned_number) do
    case digits?(cleaned_number) do
      10 -> "1"
      _ -> String.first(cleaned_number)
    end
  end

  def digits?(number) do
    String.length(number)
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(cleaned_number) do
    case digits?(cleaned_number) do
      10 -> String.slice(cleaned_number, 0..2)
      _ -> String.slice(cleaned_number, 1..3)
    end
  end

  def exchange_code(cleaned_number) do
    case digits?(cleaned_number) do
      10 -> String.at(cleaned_number, 3)
      _ -> String.at(cleaned_number, 4)
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
  end
end
