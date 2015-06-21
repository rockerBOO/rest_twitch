defmodule RestTwitch.Subscriptions do
  defmodule Subscription do
    defstruct [
      :_id,
      :link,
      :created_at,
      user: %RestTwitch.Users.User{},
    ]
  end

  # 
  # 
  # GET /users/:user/subscriptions/:channel   Check if user subscribes to channel

  @doc """
  # Authenticated, required scope: channel_subscriptions
  GET /channels/:channel/subscriptions  Get list of users subscribed to channel
  Get list of users subscribed to channel


  """
  def get(channel) do
   
  end

  @doc """
  # Authenticated, required scope: channel_subscriptions
  GET /channels/:channel/subscriptions/:user  Check if channel has user subscribed
  Check if channel has user subscribed
  """
  def subscribed(channel, user) do

  end
end