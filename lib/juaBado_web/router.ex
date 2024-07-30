defmodule JuabadoWeb.Router do
  use JuabadoWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JuabadoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, false
  end



  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", JuabadoWeb do
    pipe_through :browser

    #get "/", PageController, :home

    get "/dashboard", PageController, :home
    live "/", DashboardLive

  end


  # Other scopes may use custom stacks.
  scope "/api", JuabadoWeb do
    pipe_through :api
    get "/activities", ActivitiesController, :index
    get "/stamps", StampsController, :index
    get "/stamps_complete", StampsController, :index_complete

    post "/stamps/create_now", StampsController, :create_now_stamp
  end

  #def dashboard_path(conn, _params), do: Routes.live_dashboard_path(conn, %{})


  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:juabado, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JuabadoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
