defmodule CLI do
  def main(args) do
    option_strict = [add: :boolean, page: :integer]

    case OptionParser.parse(args, switches: option_strict) do
      {[add: true], [organization, token], _} ->
        Esarch.add(organization, token)
      {[], [organization|keywords], _} ->
        Esarch.search(organization, keywords, 1)
      {[page: page], [organization|keywords], _} ->
        Esarch.search(organization, keywords, page)
      opt ->
        IO.inspect opt
        usage
    end
  end

  def usage do
    IO.puts("hi")
  end
end
