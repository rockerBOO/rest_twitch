defmodule RestTwitch.Follows do
  alias RestTwitch.Request
  import ExPrintf

  defmodule Follow do
    defstruct [
      :_links,
      :notifications,
      :created_at,
      user: %RestTwitch.Users.User{},
      channel: %RestTwitch.Channels.Channel{},
    ]
  end

  @doc """
  GET /users/:user/follows/channels   Get a user's list of followed channels
  Get a user's list of followed channels

  limit      int     Maximum number of objects in list. Default is 25. Maximum is 100.

  offset     int     Object offset for pagination. Default is 0.

  direction  string  Creation date sorting direction. Default is "desc". Valid values are "asc" and "desc".

  ## Examples
  RestTwitch.Follows.get("test_user1", %{"direction" => "desc"})
  """
  def get(user, opts \\ %{}) do
    "/users/%s/follows/channels?%s"
      |> sprintf([user, URI.encode_query(opts)])
      |> Request.get_body!()
      |> Request.decode_json!("follows", [Follow])
  end

  @doc """
  GET /users/:user/follows/channels/:target   Get status of follow relationship between user and target channel
  Get status of follow relationship between user and target channel

  ## Examples
  RestTwitch.Follows.follows("test_user1", "test_channel")
  "test_user1 is not following test_channel"
  """
  def follows(user, target) do
    r = "/users/%s/follows/channels/%s"
      |> sprintf([user, target])
      |> Request.get_body!()
      |> Request.decode_json!("channel", RestTwitch.Channels.Channel)
  end

  @doc """
  # Authenticated, required scope: user_follows_edit
  PUT /users/:user/follows/channels/:target   Follow a channel
  Follow a channel

  notifications   boolean   Whether :user should receive email/push notifications (depending on their notification settings) when :target goes live. Default is false.
  """
  # put!(url, body, headers \\ [], options \\ [])
  def follow(token, user, target, opts \\ []) do
    sprintf("/users/%s/follows/channels/%s?%s", [user, target, URI.encode_query(opts)])
      |> Request.do_put!(token, [])
  end

  @doc """
  # Authenticated, required scope: user_follows_edit
  DELETE /users/:user/follows/channels/:target  Unfollow a channel
  Unfollow a channel
  """
  def delete(user, :unfollow, target) do
    sprintf("/users/%s/follows/channels/%s", [user, target])
      |> Request.do_delete!()
      |> Request.decode_json!("channels", [RestTwitch.Channels.Channel])
  end
end