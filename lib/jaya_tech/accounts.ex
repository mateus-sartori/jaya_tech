defmodule JayaTech.Accounts do
  import Ecto.Query, warn: false
  alias JayaTech.Repo

  alias JayaTech.Accounts.User

  @spec get_user!(integer()) :: %User{}
  def get_user!(id), do: Repo.get!(User, id)

  def get_random() do
    query =
      from u in User,
        order_by: fragment("RANDOM()"),
        limit: 1,
        select: u.id

    Repo.one!(query)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
