defmodule Blackjack do
  defmodule Player do
    defstruct ~w[name cash chips]a
  end

  def new_player(name, cash) do
    %Player{name: name, cash: cash, chips: 0}
  end

  def buy_chips(player, amount) do
    increase_chips(player, amount)
    |> decrease_cash(amount)
  end

  defp increase_chips(player, amount) do
    Map.update!(player, :chips, fn old_chips -> old_chips + amount end)
  end

  defp decrease_cash(player, amount) do
    Map.update!(player, :cash, fn old_cash -> old_cash - amount end)
  end
end
