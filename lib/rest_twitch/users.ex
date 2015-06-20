defmodule RestTwitch.Users do 
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
  # GET /users/:user  Get user object
  # GET /user   Get user object
  # GET /streams/followed   Get list of streams user is following
  # GET /videos/followed  Get list of videos belonging to channels user is following	

  @doc """
  Gets the user object
  """
  def get(user) do
    sprintf("/users/%s", [user])
      |> Request.request_get
      |> Request.process_response_body("channels", RestTwitch.Channels.Channel)
  end

  @doc """
  Gets the logged in users object
  """
  def get("user") do
    "/user"
      |> Request.request_get
      |> Request.process_response_body("channels", RestTwitch.Channels.Channel)
  end

  @doc """
  Gets the videos this user follows
  """
  def videos_followed(user) do
    "/videos/followed"
      |> Request.request_get
      |> Request.process_response_body("videos", RestTwitch.Videos.Video)
  end
end