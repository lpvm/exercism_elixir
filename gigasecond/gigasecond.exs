defmodule Gigasecond do

  @gigasecond 1_000_000_000

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    start = NaiveDateTime.new(year, month, day, hours, minutes, seconds)

    case start do
      {:ok, dt} ->
        dt 
        |> NaiveDateTime.add(@gigasecond)
        |> NaiveDateTime.to_erl()

      _ ->
        IO.puts("Error adding")
    end
  end
end
