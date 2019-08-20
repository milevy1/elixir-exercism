defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_head | tail]) do
    1 + count(tail)
  end

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse(list) do
    reverse(list, [])
  end
  def reverse([], reversed), do: reversed
  def reverse([head | tail], reversed) do
    reverse(tail, [head | reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []
  def filter([head | tail], f) do
    cond do
      f.(head) -> [head | filter(tail, f)]
      true -> filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append([], []), do: []
  def append(list_1, []), do: list_1
  def append([], list_2), do: list_2
  def append([h1 | []], [h2 | t2]) do
    [h1 | append([h2], t2)]
  end
  def append([h1 | t1], list_2) do
    [h1 | append(t1, list_2)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([list_1 | []]), do: list_1
  def concat([list_1 | [list_2 | rest_of_lists]]) do
    concat([append(list_1, list_2) | rest_of_lists])
  end
end
