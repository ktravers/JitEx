#! /usr/bin/env elixir

# Usage
#
# ./jitex <command> <arg>
#
# Ex. `./jitex init .`

[command | args] = System.argv()

case command do
  "init" ->
    {:ok, cwd} = File.cwd()
    path = List.first(args) || cwd

    git_dir = "#{path}/.git"

    [git_dir, "#{git_dir}/objects", "#{git_dir}/refs"]
    |> Enum.each(fn dir ->
      dir
      |> Path.expand()
      |> File.mkdir_p()
    end)

    "#{git_dir}/HEAD"
    |> Path.expand()
    |> File.touch()

    IO.puts "Initialized empty Git repository in #{path}"
  _ ->
    IO.puts "Invalid command"
end
