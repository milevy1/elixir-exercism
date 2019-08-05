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
  def to_rna(dna) do
    Enum.map(dna, &dna_char_to_rna/1)
  end

  defp dna_char_to_rna(char) do
    case char do
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
      _ -> '?'
    end
  end
end
