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
    # Build case switch for complments
    case dna do
      'G' -> 'C'
      'C' -> 'G'
      'T' -> 'A'
      'A' -> 'U'
      _ -> '?'
    end

    # Iterate through each char in string with complements case
  end
end
