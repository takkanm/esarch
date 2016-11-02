defmodule Esarch do
  @config_file_path "~/.config/esarch.json"

  def add(organization, token) do
    IO.inspect [organization, token]
    IO.inspect load_config
  end

  defp load_config do
    File.touch(file_path)
    case File.read(file_path) do
      {:ok, ""} ->
        %{}
      {:ok, body} ->
        body
      error ->
        error
    end
  end

  defp file_path do
    Path.expand(@config_file_path)
  end
end
