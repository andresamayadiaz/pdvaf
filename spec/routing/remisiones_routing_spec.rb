require "spec_helper"

describe RemisionesController do
  describe "routing" do

    it "routes to #index" do
      get("/remisiones").should route_to("remisiones#index")
    end

    it "routes to #new" do
      get("/remisiones/new").should route_to("remisiones#new")
    end

    it "routes to #show" do
      get("/remisiones/1").should route_to("remisiones#show", :id => "1")
    end

    it "routes to #edit" do
      get("/remisiones/1/edit").should route_to("remisiones#edit", :id => "1")
    end

    it "routes to #create" do
      post("/remisiones").should route_to("remisiones#create")
    end

    it "routes to #update" do
      put("/remisiones/1").should route_to("remisiones#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/remisiones/1").should route_to("remisiones#destroy", :id => "1")
    end

  end
end
