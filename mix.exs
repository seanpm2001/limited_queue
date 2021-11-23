defmodule LimitedQueue.Mixfile do
  use Mix.Project

  @github_url "https://github.com/discord/limited_queue"

  def project do
    [
      app: :limited_queue,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      elixirc_options: [warnings_as_errors: ci?()],
      deps: deps(),
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:benchee, "~> 1.0", only: [:dev], runtime: false},
      {:benchee_html, "~> 1.0", only: [:dev], runtime: false},
      {:deque, "~> 1.2", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.25.1", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.14.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp ci?() do
    System.get_env("CI") == "true"
  end

  defp docs do
    source_ref = current_branch(ci?())

    [
      name: "limited_queue",
      extras: ["README.md", "LICENSE"],
      main: "readme",
      source_url_pattern: "#{@github_url}/blob/#{source_ref}/%{path}#L%{line}"
    ]
  end

  def package do
    [
      name: :limited_queue,
      description: "Simple Elixir queue, with a constant-time `size/1` and a maximum capacity.",
      maintainers: [],
      licenses: ["MIT"],
      files: ["lib/*", "mix.exs", "README*", "LICENSE*"],
      links: %{
        "GitHub" => @github_url
      }
    ]
  end

  @spec current_branch(is_continuous_integration :: boolean()) :: String.t()
  defp current_branch(true), do: "master"

  defp current_branch(false) do
    "git"
    |> System.cmd(["rev-parse", "--abbrev-ref", "HEAD"])
    |> elem(0)
  end

  defp elixirc_paths(:test) do
    elixirc_paths(:dev) ++ ["test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end
end
