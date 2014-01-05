require "spec_helper"

describe PreciosController do
  describe "routing" do

    it "routes to #index" do
      get("/precios").should route_to("precios#index")
    end

    it "routes to #new" do
      get("/precios/new").should route_to("precios#new")
    end

    it "routes to #show" do
      get("/precios/1").should route_to("precios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/precios/1/edit").should route_to("precios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/precios").should route_to("precios#create")
    end

    it "routes to #update" do
      put("/precios/1").should route_to("precios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/precios/1").should route_to("precios#destroy", :id => "1")
    end

  end
end
