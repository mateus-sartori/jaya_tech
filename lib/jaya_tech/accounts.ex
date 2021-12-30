defmodule JayaTech.Accounts do
  import Ecto.Query, warn: false
  alias JayaTech.Repo

  alias JayaTech.Accounts.User

  @spec get_user!(integer()) :: %User{}
  def get_user!(id), do: Repo.get!(User, id)
end
