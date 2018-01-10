defmodule RestTwitch.Cache do
  defmodule Options do
    defstruct ttl: 86400
  end

  def start_link(client) do
    GenServer.start_link(__MODULE__, [client], [name: :twitch_cache])
  end

  def init([client]) do
    {:ok, %{client: client}}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, state.client |> Exredis.query(["GET", key]), state}
  end

  def handle_call({:set, key, value}, _from, state) do
    {:reply, state.client |> Exredis.query(["SET", key, value]), state}
  end

  def handle_call({:del, key}, _from, state) do
    {:reply, state.client |> Exredis.query(["DEL", key]), state}
  end

  def handle_call({:incr, key}, _from, state) do
    {:reply, state.client |> Exredis.query(["INCR", key]), state}
  end

  def handle_call({:expire, key, ttl}, _from, state) do
    {:reply, state.client |> Exredis.query(["EXPIRE", key, ttl]), state}
  end

  def get(key) do
    GenServer.call(:twitch_cache, {:get, key})
  end

  def set(key, value) do
    GenServer.call(:twitch_cache, {:set, key, value})
  end

  def delete(key) do
    GenServer.call(:twitch_cache, {:del, key})
  end

  def incr(key) do
    GenServer.call(:twitch_cache, {:incr, key})
  end

  def expire(key, ttl \\ 86400) do
    GenServer.call(:twitch_cache, {:expire, key, ttl})
  end
end