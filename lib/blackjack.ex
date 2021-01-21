defmodule Blackjack do
  defmodule Player do
    defstruct ~w[name cash chips]a
  end

  def new_player(name, cash) do
    %Player{name: name, cash: cash, chips: 0}
  end

  def buy_chips(player, amount) do
    player
    |> increase(:chips, amount)
    |> decrease(:cash, amount)
  end

  def cash_out(player, amount) do
    player
    |> increase(:cash, amount)
    |> decrease(:chips, amount)
  end

  defp increase(player, money_bag, amount) do
    Map.update!(player, money_bag, fn current_value -> current_value + amount end)
  end

  defp decrease(player, money_bag, amount) do
    if amount > Map.get(player, money_bag) do
      {:error, "Not enough #{money_bag}"}
    else
      Map.update!(player, money_bag, fn current_value -> current_value - amount end)
    end
  end
end
