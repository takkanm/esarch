defmodule Esarch.Mixfile do
  use Mix.Project

  def project do
    [app: :esarch,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [ main_module: CLI ],
     description: "CLI tool for esa.io search",
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp package do
    [
      name: :postgrex,
      files: ["lib", "mix.exs", "README*", "LICENCE"],
      maintainers: ["takkanm"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/takkanm/esarch"}
    ]
  end
end
