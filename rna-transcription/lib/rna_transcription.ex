defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'

  Given a DNA strand, its transcribed RNA strand is formed by
  replacing each nucleotide with its complement:
  G -> C
  C -> G
  T -> A
  A -> U

  """
  @spec to_rna([char]) :: [char]
  def to_rna([_head | _tail] = dna) do
    Enum.map(dna, &to_rna/1)
  end

  def to_rna(?G), do: ?C
  def to_rna(?C), do: ?G
  def to_rna(?T), do: ?A
  def to_rna(?A), do: ?U
end
