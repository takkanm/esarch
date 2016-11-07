defmodule CLI do
  def main(args) do
    option_strict = [add: :boolean, page: :integer, help: :boolean]

    case OptionParser.parse(args, switches: option_strict) do
      {[help: true], _, _} ->
        usage
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
    IO.puts "esarch [--page N] organization_name keyword1 [keyword2 keyword3 ...]"
  end
end
