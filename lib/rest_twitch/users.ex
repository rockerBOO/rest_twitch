defmodule RestTwitch.Users do
  alias RestTwitch.Request 
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
      iex> RestTwitch.Users.get("nimolo00")
      %RestTwitch.Users.User{_id: 15255898,
       _links: %{"self" => "https://api.twitch.tv/kraken/users/nimolo00"},
       bio: "Enter your text here.", created_at: "2010-09-04T04:58:51Z",
       display_name: "Nimolo00",
       logo: "http://static-cdn.jtvnw.net/jtv_user_pictures/nimolo00-profile_image-e93f42babc1380a2-300x300.png",
       name: "nimolo00", type: "user"}

  """
  def get(user) do
    sprintf("/users/%s", [user])
      |> Request.get_body
      |> Poison.decode!(as: User)
  end

  @doc """
  Authenticated, required scope: user_read
  
  Gets the logged in users object

  ## Example
    iex> RestTwitch.Users.get(:user)
    "nimolo00"
  """
  # def get(:user) do
  #   "/user"
  #     |> Request.get_body
  #     |> Request.process_response_body(:channels, RestTwitch.Channels.Channel)
  # end

  @doc """
  Gets the videos this user follows
  """
  # def videos_followed(user) do
  #   "/videos/followed"
  #     |> Request.get_body
  #     |> Request.process_response_body(:videos, RestTwitch.Videos.Video)
  # end
end