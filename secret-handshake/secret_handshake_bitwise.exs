import Bitwise

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
    cmds =[{0b00001, "wink"}, {0b00010, "double blink"}, {0b00100, "close your eyes"}, {0b01000, "jump"}]
    |> List.foldl([], fn {bit, cmd}, acc ->
      if bit_set?(code, bit), do: [cmd | acc], else: acc
    end) |> Enum.reverse()

    if bit_set?(code, 0b10000), do: Enum.reverse(cmds), else: cmds
  end

    defp bit_set?(code, bit) do
    (code &&& bit) > 0
    end
end
