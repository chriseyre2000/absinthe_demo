defmodule A1NewWeb.Schema do
  use Absinthe.Schema

  # alias A1New.{Menu, Repo}
  alias A1NewWeb.Resolvers

  scalar :date do
    parse fn input ->
      case Date.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end

    serialize fn date ->
      Date.to_iso8601(date)
    end
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :description, :string
    field :added_on, :date
  end

  @desc "Filtering options for the new menu list"
  input_object :menu_item_filter do

    @desc "Matching a name"
    field :name, :string

    @desc "Matching a category description"
    field :category, :string

    @desc "Matching a tag"
    field :tag, :string

    @desc "Priced above a value"
    field :priced_above, :float

    @desc "Priced below a value"
    field :priced_below, :float

    @desc "Added to the menu before this date"
    field :added_before, :date

    @desc "Added to the menu after this date"
    field :added_after, :date

  end

  query do
    field :menu_items, list_of(:menu_item),
      description: "The list of the available items in the menu." do
      arg :filter, :menu_item_filter
      arg :order, type: :sort_order, default_value: :asc

      resolve(&Resolvers.Menu.menu_items/3)
    end
  end

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
end
