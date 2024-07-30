defmodule juabadoWeb.StampsController do
  use Phoenix.Controller, formats: [:json]
  alias juabado.Stamps

	def index(conn, _params) do
		stamps = %{stamps: Stamps.list_stamps()}
		render(conn, :index, stamps)
	end

	def index_complete(conn, _params) do
		stamps = %{stamps: Stamps.list_complete_stamps()}
		render(conn, :index_complete, stamps)
	end

	def create_now_stamp(conn, _params) do
		# Access body_params directly for id and type
		%{"id" => id, "type" => type} = conn.body_params

		# Create the stamp (assuming Stamps.create_stamp_now/2 returns the created stamp)
		created_stamp = Stamps.create_stamp_now(id, type)
		# Render the show template with the newly created stamp
		conn
		|> put_status(:created)
		|> render(:show, %{stamp: created_stamp})
	end

end
