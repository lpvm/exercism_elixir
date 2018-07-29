defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # if code greater than 15 (11111) then it's necessary to remove extra
    code = if code > 31, do: code - 32 * div(code, 32), else: code

    to_reverse = true and code >= 16
    code = if to_reverse, do: code - 16, else: code

    to_jump = true and code >= 8
    code = if to_jump, do: code - 8, else: code

    to_close_your_eyes = true and code >= 4
    code = if to_close_your_eyes, do: code - 4, else: code

    to_double_blink = true and code >= 2
    code = if to_double_blink, do: code - 2, else: code

    to_wink = true and code >= 1

    commands = []

    commands = if to_jump, do: ["jump"] ++ commands, else: commands
    commands = if to_close_your_eyes, do: ["close your eyes"] ++ commands, else: commands
    commands = if to_double_blink, do: ["double blink"] ++ commands, else: commands
    commands = if to_wink, do: ["wink"] ++ commands, else: commands

    if to_reverse, do: commands |> Enum.reverse, else: commands
end

#  defp getAction(dec) do
#    case dec do
#      1 -> "wink"
#      2 -> "double blink"
#      4 -> "close your eyes"
#      8 -> "jump"
#    end
#  end
#
#  defp decimalToBinary(dec) do
#    dec
#    |> Integer.to_string(2)
#    |> String.to_integer
#  end
end
