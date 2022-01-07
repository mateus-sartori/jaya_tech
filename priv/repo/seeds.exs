# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JayaTech.Repo.insert!(%JayaTech.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias JayaTech.Accounts

Accounts.create_user(%{name: "mateus"})
Accounts.create_user(%{name: "valdeir"})
Accounts.create_user(%{name: "lucas"})
Accounts.create_user(%{name: "paulo"})
