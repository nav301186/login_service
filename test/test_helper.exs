ExUnit.start

Mix.Task.run "ecto.create", ~w(-r LoginService.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r LoginService.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(LoginService.Repo)

