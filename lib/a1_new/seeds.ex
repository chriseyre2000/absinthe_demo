# ---
# Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
# ---
defmodule A1New.Seeds do
  def run() do
    alias A1New.Menu
    alias A1New.Repo
    alias A1New.Menu.Item
    alias A1New.Menu.ItemTag
    alias A1New.Menu.Category

    #
    # TAGS
    #

    vegetarian =
      %ItemTag{name: "Vegetarian"}
      |> Repo.insert!()

    _vegan =
      %ItemTag{name: "Vegan"}
      |> Repo.insert!()

    _gluten_free =
      %ItemTag{name: "Gluten Free"}
      |> Repo.insert!()

    #
    # SANDWICHES
    #

    sandwiches = %Category{name: "Sandwiches"} |> Repo.insert!()

    _rueben =
      %Item{name: "Reuben", price: 4.50, category: sandwiches}
      |> Repo.insert!()

    _croque =
      %Item{name: "Croque Monsieur", price: 5.50, category: sandwiches}
      |> Repo.insert!()

    _muffuletta =
      %Item{name: "Muffuletta", price: 5.50, category: sandwiches}
      |> Repo.insert!()

    _bahn_mi =
      %Item{name: "Bánh mì", price: 4.50, category: sandwiches}
      |> Repo.insert!()

    _vada_pav =
      %Item{name: "Vada Pav", price: 4.50, category: sandwiches, tags: [vegetarian]}
      |> Repo.insert!()

    #
    # SIDES
    #

    sides = %Category{name: "Sides"} |> Repo.insert!()

    _fries =
      %Item{name: "French Fries", price: 2.50, category: sides}
      |> Repo.insert!()

    _papadum =
      %Item{name: "Papadum", price: 1.25, category: sides}
      |> Repo.insert!()

    _pasta_salad =
      %Item{name: "Pasta Salad", price: 2.50, category: sides}
      |> Repo.insert!()

    #
    # BEVERAGES
    #

    beverages = %Category{name: "Beverages"} |> Repo.insert!()

    _water =
      %Item{name: "Water", price: 0, category: beverages}
      |> Repo.insert!()

    _soda =
      %Item{name: "Soft Drink", price: 1.5, category: beverages}
      |> Repo.insert!()

    _lemonade =
      %Item{name: "Lemonade", price: 1.25, category: beverages}
      |> Repo.insert!()

    _chai =
      %Item{name: "Masala Chai", price: 1.5, category: beverages}
      |> Repo.insert!()

    _vanilla_milkshake =
      %Item{name: "Vanilla Milkshake", price: 3.0, category: beverages}
      |> Repo.insert!()

    _chocolate_milkshake =
      %Item{name: "Chocolate Milkshake", price: 3.0, category: beverages}
      |> Repo.insert!()

    :ok
  end
end
