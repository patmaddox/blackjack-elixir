defmodule Blackjack.Player do
  defstruct ~w[name cash chips]a

  def new(name, cash) do
    %__MODULE__{name: name, cash: cash, chips: 0}
  end

  def buy_chips(player_or_error, amount) do
    transfer(player_or_error, :cash, :chips, amount)
  end

  def cash_out(player_or_error, amount) do
    transfer(player_or_error, :chips, :cash, amount)
  end

  defp transfer(%__MODULE__{} = player, from, to, amount) do
    if Map.get(player, from) < amount do
      {:error, "Not enough #{from}"}
    else
      player
      |> adjust(from, -amount)
      |> adjust(to, amount)
    end
  end

  defp transfer({:error, _} = error, _from, _to, _amount), do: error

  defp adjust(player, money_bag, amount) do
    Map.update!(player, money_bag, & &1 + amount)
  end
end
