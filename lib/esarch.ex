defmodule Esa do
  use HTTPoison.Base

  def process_url(url) do
    "https://api.esa.io" <> url
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end
end

defmodule Esarch do
  @config_file_path "~/.config/esarch.json"
  @token_key        "esa_token"

  def add(token) do
    config = load_config
    write_config(Map.merge(config, %{@token_key => token}))
  end

  def search(organization, keywords, page) do
    search_and_show organization, keywords, page, &show_post/1
  end

  def search_with_md_format(organization, keywords, page) do
    search_and_show organization, keywords, page, &show_post_with_md_format/1
  end

  defp search_and_show(organization, keywords, page, print_func) do
    get_result(organization, keywords, page) |> show_result(print_func)
  end

  defp get_result(organization, keywords, page) do
    token = fetch_token
    header = %{"Authorization" => "Bearer #{token}"}
    case Esa.get("/v1/teams/#{organization}/posts?q=#{keywords}&page=#{page}", header) do
      {:ok, %{body: body, headers: _}} ->
        body
      _ ->
        :error
    end
  end

  defp show_result(%{"posts" => posts, "total_count" => count}, print_func) do
    IO.puts "#{count} page Hit\n"
    posts |> Enum.each(print_func)
  end

  defp show_post(%{"name" => name, "url" => url}) do
    IO.puts "#{url} : #{name}"
  end

  defp show_post_with_md_format(%{"name" => name, "url" => url}) do
    IO.puts "[#{name}](#{url})"
  end

  defp load_config do
    case read_config_file |> Poison.decode do
      {:error, :invalid, 0} ->
        %{}
      {:error, _ ,_} ->
        :error
      {:ok, config} ->
        config
    end
  end

  defp fetch_token do
    case Map.fetch(load_config, @token_key) do
      {:ok, token} -> token
      :error -> :error
    end
  end

  defp read_config_file do
    File.touch(file_path)
    case File.read(file_path) do
      {:ok, ""} ->
        ""
      {:ok, body} ->
        body
      error ->
        error
    end
  end

  defp write_config(config) do
    case Poison.encode(config) do
      {:ok, config_json} ->
        File.write(file_path, "#{config_json}\n")
      _ ->
        :error
    end
  end

  defp file_path do
    Path.expand(@config_file_path)
  end
end
