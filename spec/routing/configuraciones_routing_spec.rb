require "spec_helper"

describe ConfiguracionesController do
  describe "routing" do

    it "routes to #index" do
      get("/configuraciones").should route_to("configuraciones#index")
    end

    it "routes to #new" do
      get("/configuraciones/new").should route_to("configuraciones#new")
    end

    it "routes to #show" do
      get("/configuraciones/1").should route_to("configuraciones#show", :id => "1")
    end

    it "routes to #edit" do
      get("/configuraciones/1/edit").should route_to("configuraciones#edit", :id => "1")
    end

    it "routes to #create" do
      post("/configuraciones").should route_to("configuraciones#create")
    end

    it "routes to #update" do
      put("/configuraciones/1").should route_to("configuraciones#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/configuraciones/1").should route_to("configuraciones#destroy", :id => "1")
    end

  end
end
