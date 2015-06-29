# DONEish
defmodule RestTwitch.Users do
  alias RestTwitch.Request
  alias RestTwitch.TokenRequest
  import ExPrintf

  defmodule User do
    defstruct [
      :type,
      :name,
      :created_at,
      :_links,
      :logo,
      :_id,
      :display_name,
      :bio
    ]
  end

  @doc """
  GET /users/:user  Get user object

  ## Example
  RestTwitch.Users.get("nimolo00")
  %RestTwitch.Users.User{_id: 15255898,
   _links: %{"self" => "https://api.twitch.tv/kraken/users/nimolo00"},
   bio: "Enter your text here.", created_at: "2010-09-04T04:58:51Z",
   display_name: "Nimolo00",
   logo: "http://static-cdn.jtvnw.net/jtv_user_pictures/nimolo00-profile_image-e93f42babc1380a2-300x300.png",
   name: "nimolo00", type: "user"}

  """
  def get(user) do
    "/users/%s"
      |> sprintf([user])
      |> Request.get_body!()
      |> Request.decode_json!(RestTwitch.Channels.User)
  end

  @doc """
  # Authenticated, required scope: user_read

  Gets the logged in users object

  ## Example
  System.get_env("TWITCH_ACCESS_TOKEN") |>
  RestTwitch.Users.user()
  """
  def user(token) do
    "/user"
      |> Request.get_token_body!(token)
      |> Request.decode_json!(RestTwitch.Users.User)
  end

  @doc """
  # Authenticated, required scope: user_read

  GET /streams/followed   Get list of streams user is following

  limit   optional  integer   Maximum number of objects in array. Default is 25. Maximum is 100.

  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Example
  System.get_env("TWITCH_ACCESS_TOKEN") |>
  RestTwitch.Users.streams_following([limit: 25])

  """
  def streams_following(token, opts \\ []) do
    "/streams/followed"
      |> Request.get_token_body!(token, [], opts)
      |> Request.decode_json!("streams", [RestTwitch.Streams.Stream])
  end

  @doc """
  # Authenticated, required scope: user_read

  GET /videos/followed  Get list of videos belonging to channels user is following
  https://github.com/justintv/Twitch-API/blob/master/v3_resources/users.md#get-videosfollowed
  Gets the videos this user follows

  limit   optional  integer   Maximum number of objects in array. Default is 10. Maximum is 100.

  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Example

  token = System.get_env("TWITCH_ACCESS_TOKEN")

  RestTwitch.Users.videos_followed(token)
  """
  def videos_followed(token, opts \\ []) do
    "/videos/followed"
      |> Request.get_token_body!(token, [], opts)
      |> Request.decode_json!("videos", [RestTwitch.Videos.Video])
  end
end
