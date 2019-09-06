defmodule BankAccount do
  use GenServer

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end
  def init(state), do: {:ok, state}

  def handle_call(_, _from, %{status: 0} = state), do: {:reply, {:error, :account_closed}, state}

  def handle_call(:balance, _from, state) do
    {:reply, state[:balance], state}
  end

  def handle_call({:update, amount}, _from, state) do
   {:reply, state[:balance], %{state | balance: state.balance + amount}}
  end

  def handle_call(:close_bank, _from, state) do
   {:reply, state[:balance], %{state | status: 0}}
  end

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    start_link(%{balance: 0, status: 1})
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(_account) do
    GenServer.call(__MODULE__, :close_bank)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(_account) do
    GenServer.call(__MODULE__, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(_account, amount) do
    GenServer.call(__MODULE__, {:update, amount})
  end
end
