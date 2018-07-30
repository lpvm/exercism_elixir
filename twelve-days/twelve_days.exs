defmodule TwelveDays do

  @verses %{
    1 => "a Partridge in a Pear Tree.",
    2 => "two Turtle Doves",
    3 => "three French Hens",
    4 => "four Calling Birds",
    5 => "five Gold Rings",
    6 => "six Geese-a-Laying",
    7 => "seven Swans-a-Swimming",
    8 => "eight Maids-a-Milking",
    9 => "nine Ladies Dancing",
    10 => "ten Lords-a-Leaping",
    11 => "eleven Pipers Piping",
    12 => "twelve Drummers Drumming"
  }

  @ordinals %{
    1 => "first",
    2 => "second",
    3 => "third",
    4 => "fourth",
    5 => "fifth",
    6 => "sixth",
    7 => "seventh",
    8 => "eighth",
    9 => "ninth",
    10 => "tenth",
    11 => "eleventh",
    12 => "twelfth"
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the " <> @ordinals[number] <> " day of Christmas my true love gave to me, " <> verse_aux(number)
  end

  defp verse_aux(number) when number <= 1 do
    @verses[number]
  end

  defp verse_aux(number) do

    if number === 2 
      do @verses[number] <> ", and " <> verse_aux(number - 1)
      else @verses[number] <> ", " <> verse_aux(number - 1)
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    text = for v <- starting_verse..ending_verse, into: "" do
        verse(v) <> "\n"
       end
    text |> String.trim()
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end

#On the third day of Christmas my true love gave to me, three French Hens, two Turtle Doves, and .

