defmodule CLI do
  def main(args) do
    option_strict = [add: :boolean, page: :integer, help: :boolean, md_format: :boolean]

    case OptionParser.parse(args, switches: option_strict) do
      {[help: true], _, _} ->
        usage
      {[add: true], [token], _} ->
        Esarch.add(token)
      {[], [organization|keywords], _} ->
        Esarch.search(organization, keywords, 1)
      {[page: page], [organization|keywords], _} ->
        Esarch.search(organization, keywords, page)
      {[md_format: true], [organization|keywords], _} ->
        Esarch.search_with_md_format(organization, keywords, 1)
      _ ->
        usage
    end
  end

  def usage do
    IO.puts "esarch [--page N] organization_name keyword1 [keyword2 keyword3 ...]"
  end
end
