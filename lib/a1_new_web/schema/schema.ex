defmodule A1NewWeb.Schema do
  use Absinthe.Schema
  alias A1NewWeb.Resolvers

  import_types(__MODULE__.MenuTypes)

  @desc "An error occoured trying to persist input"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

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
    import_fields(:menu_queries)

    field :search, list_of(:search_result) do
      arg(:matching, non_null(:string))
      resolve(&Resolvers.Menu.search/3)
    end
  end

  scalar :decimal do
    parse(fn
      %{value: value}, _ ->
        {d, _} = Decimal.parse(value)
        {:ok, d}

      _, _ ->
        :error
    end)

    serialize(&to_string/1)
  end

  input_object :menu_item_input do
    field :name, non_null(:string)
    field :description, :string
    field :price, non_null(:decimal)
    field :category_id, non_null(:id)
  end

  mutation do
    field :create_menu_item, :menu_item_result do
      arg(:input, non_null(:menu_item_input))
      resolve(&Resolvers.Menu.create_item/3)
    end
  end

  interface :search_result do
    field :name, :string

    resolve_type(fn
      %A1New.Menu.Item{}, _ ->
        :menu_item

      %A1New.Menu.Category{}, _ ->
        :category

      _, _ ->
        nil
    end)
  end
end
