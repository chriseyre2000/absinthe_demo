defmodule A1NewWeb.Schema do
use Absinthe.Schema

query do
  # <<Ignore this for now>>
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
