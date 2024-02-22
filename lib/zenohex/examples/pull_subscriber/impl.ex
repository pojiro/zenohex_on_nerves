defmodule Zenohex.Examples.PullSubscriber.Impl do
  @moduledoc false

  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def pull() do
    GenServer.call(__MODULE__, :pull)
  end

  def init(args) do
    session = Map.fetch!(args, :session)
    key_expr = Map.fetch!(args, :key_expr)
    callback = Map.fetch!(args, :callback)

    {:ok, pull_subscriber} = Zenohex.Session.declare_pull_subscriber(session, key_expr)
    state = %{pull_subscriber: pull_subscriber, callback: callback}

    recv_timeout(state)

    {:ok, state}
  end

  def handle_info(:loop, state) do
    recv_timeout(state)
    {:noreply, state}
  end

  def handle_call(:pull, _from, state) do
    :ok = Zenohex.PullSubscriber.pull(state.pull_subscriber)
    {:reply, :ok, state}
  end

  defp recv_timeout(state) do
    case Zenohex.PullSubscriber.recv_timeout(state.pull_subscriber) do
      {:ok, sample} ->
        state.callback.(sample)
        send(self(), :loop)

      {:error, :timeout} ->
        send(self(), :loop)

      {:error, error} ->
        Logger.error(inspect(error))
    end
  end
end
