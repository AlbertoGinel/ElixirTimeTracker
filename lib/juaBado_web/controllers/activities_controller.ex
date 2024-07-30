defmodule JuabadoWeb.ActivitiesController do
  use Phoenix.Controller, formats: [:json]
  alias Juabado.Activities

	def index(conn, _params) do
		activities = %{activities: Activities.list_activities()}
		render(conn, :index, activities)
	end
end
