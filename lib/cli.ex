defmodule CLI do
  def main(args) do
    option_strict = [add: :boolean]

    case OptionParser.parse(args, switches: option_strict) do
      {[add: true], [organization, token], _} ->
        Esarch.add(organization, token)
      opt ->
        IO.inspect opt
        usage
    end
  end

  def usage do
    IO.puts("hi")
  end
end
