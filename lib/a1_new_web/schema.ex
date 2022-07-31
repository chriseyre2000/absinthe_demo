defmodule A1NewWeb.Schema do
  use Absinthe.Schema

  alias A1New.{Menu, Repo}
  alias A1NewWeb.Resolvers

  object :menu_item do
    field :id, :id
    field :name, :string
    field :description, :string
  end

  query do
    field :menu_items, list_of(:menu_item),
      description: "The list of the available items in the menu." do
      arg :matching, :string
      arg :order, type: sort_order, default_value: :asc

      resolve &Resolvers.Menu.menu_items/3
    end
  end



  enum :sort_order do
    value :asc
    value :desc
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
