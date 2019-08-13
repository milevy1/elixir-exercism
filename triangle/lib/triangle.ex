defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive"}
  end

  def kind(a, b, c) when a + b <= c or b + c <= a or a + c <= b do
    {:error, "side lengths violate triangle inequality"}
  end

  def kind(a, b, c) when a == b and b == c do
    {:ok, :equilateral}
  end

  def kind(a, b, c) when a == b or b == c or a == c do
    {:ok, :isosceles}
  end

  def kind(_a, _b, _c) do
    {:ok, :scalene}
  end
end
