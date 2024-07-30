# defmodule JuabadoWeb.PageController do
#   use JuabadoWeb, :controller
#   alias HTTPoison
#   alias Jason

#   def home(conn, _params) do
#     activities_response = HTTPoison.get("http://localhost:4000/api/activities")
#     stamps_response = HTTPoison.get("http://localhost:4000/api/stamps_complete")

#     case {activities_response, stamps_response} do
#       {{:ok, %HTTPoison.Response{status_code: 200, body: activities_body}},
#        {:ok, %HTTPoison.Response{status_code: 200, body: stamps_body}}} ->
#         activities = Jason.decode!(activities_body)
#         stamps = Jason.decode!(stamps_body) |> Enum.reverse()

#         render(conn, "dashboard.html", layout: false, activities: activities, stamps: stamps)

#       _ ->
#         conn
#         |> put_status(:internal_server_error)
#         |> put_flash(:error, "Failed to load dashboard data")
#         |> redirect(to: Routes.page_path(conn, :home))
#     end
#   end
# end


# defmodule JuabadoWeb.PageController do
#   use JuabadoWeb, :controller
#   alias HTTPoison
#   alias Jason

#   def home(conn, _params) do
#     activities_response = HTTPoison.get("http://localhost:4000/api/activities")
#     stamps_response = HTTPoison.get("http://localhost:4000/api/stamps_complete")

#     case {activities_response, stamps_response} do
#       {{:ok, %HTTPoison.Response{status_code: 200, body: activities_body}},
#        {:ok, %HTTPoison.Response{status_code: 200, body: stamps_body}}} ->
#         activities = Jason.decode!(activities_body)
#         stamps = Jason.decode!(stamps_body)

#         # Sort stamps by time in descending order (newest first)
#         sorted_stamps = Enum.sort_by(stamps, fn stamp -> DateTime.from_iso8601(stamp["time"]) end, {:desc, &DateTime.to_unix/1})

#         render(conn, "dashboard.html", layout: false, activities: activities, stamps: sorted_stamps)

#       _ ->
#         conn
#         |> put_status(:internal_server_error)
#         |> put_flash(:error, "Failed to load dashboard data")
#         |> redirect(to: Routes.page_path(conn, :home))
#     end
#   end
# end
