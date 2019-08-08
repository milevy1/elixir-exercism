defmodule Bob do
  @moduledoc """
   This is Bob. :-)
   """

  @doc """
  He answers 'Whatever.' to anything else.

  Returns `:ok`.

  ## Examples

      iex> Bob.hey("Tom-ay-to, tom-aaaah-to.")
      "Whatever."

  """
  def hey(_), do: "Whatever."

end
