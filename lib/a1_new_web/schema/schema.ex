defmodule A1NewWeb.Schema do
  use Absinthe.Schema
  alias A1NewWeb.Resolvers
  
  import_types(__MODULE__.MenuTypes)

  # query do
  #   import_fields(:menu_queries)
  # end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  # mutation do
  #   @desc "Create a new link"
  #   field :create_link, :link do
  #     arg :url, non_null(:string)
  #     arg :description, non_null(:string)

  #     resolve &NewsResolver.create_link/3
  #   end
  # end

  scalar :date do
    parse(fn input ->
      with %Absinthe.Blueprint.Input.String{value: value} <- input,
           {:ok, date} <- Date.from_iso8601(value) do
        {:ok, date}
      else
        _ -> :error
      end
    end)

    serialize(fn date ->
      Date.to_iso8601(date)
    end)
  end

  query do
    field :search, list_of(:search_result) do
      arg :matching, non_null(:string)
      resolve &Resolvers.Menu.search/3
    end
  end

  union :search_result do
    types [:menu_item, :category]
    resolve_type fn
      %A1New.Menu.Item{}, _ ->
        :menu_item
      %A1New.Menu.Category{}, _ ->
        :category
      _, _ ->
        nil
    end
  end
end
