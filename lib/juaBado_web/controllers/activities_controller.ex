defmodule JuaBadoWeb.ActivitiesController do
  use Phoenix.Controller, formats: [:json]
  alias JuaBado.Activities

	def index(conn, _params) do
		activities = %{activities: Activities.list_activities()}
		render(conn, :index, activities)
	end
end
