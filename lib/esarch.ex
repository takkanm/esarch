defmodule Esarch do
  @config_file_path "~/.config/esarch.json"

  def add(organization, token) do
    config = load_config
    write_config(Map.merge(config, %{organization => token}))
    show_organizations_in_config
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
        File.write(file_path, config_json)
      _ ->
        :error
    end
  end

  defp show_organizations_in_config do
    load_config |> Enum.each(fn({org, _}) -> IO.puts org end)
  end

  defp file_path do
    Path.expand(@config_file_path)
  end
end
