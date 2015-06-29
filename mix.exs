defmodule RestTwitch.Mixfile do
  use Mix.Project

  def project do
    [app: :rest_twitch,
     version: "0.1.4",
     elixir: "~> 1.0",
     description: "REST API for Twitch.tv",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison, :oauth2]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.7"},
      {:oauth2, "~> 0.1.0"},
      {:exprintf, github: "parroty/exprintf"},
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      contributors: ["Dave Lage"]
    ]
  end
end
