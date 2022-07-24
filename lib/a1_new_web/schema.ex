defmodule A1NewWeb.Schema do
use Absinthe.Schema

alias A1New.{Menu, Repo}

query do
  field :menu_items, list_of(:menu_item) do
    resolve fn _, _, _ ->
      {:ok, Repo.all(Menu.Item)}
    end
  end
end

object :menu_item do
  field :id, :id
  field :name, :string
  field :description, :string
end

# mutation do
#   @desc "Create a new link"
#   field :create_link, :link do
#     arg :url, non_null(:string)
#     arg :description, non_null(:string)

#     resolve &NewsResolver.create_link/3
#   end
# end

end
