defmodule RestTwitch.Teams do 
	defmodule Team do
    defstruct [
      :_links,
      :_id,
      :name,
      :info,
      :display_name,
      :created_at,
      :updated_at,
      :logo,
      :banner,
      :background
    ]
  end
end