defmodule A1NewWeb.Resolvers.Menu do
  alias A1New.Menu

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end
end
