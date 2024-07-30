defmodule juabadoWeb.ActivitiesController do
  use Phoenix.Controller, formats: [:json]
  alias juabado.Activities

	def index(conn, _params) do
		activities = %{activities: Activities.list_activities()}
		render(conn, :index, activities)
	end
end
