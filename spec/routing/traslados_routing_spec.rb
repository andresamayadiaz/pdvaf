require "spec_helper"

describe TrasladosController do
  describe "routing" do

    it "routes to #index" do
      get("/traslados").should route_to("traslados#index")
    end

    it "routes to #new" do
      get("/traslados/new").should route_to("traslados#new")
    end

    it "routes to #show" do
      get("/traslados/1").should route_to("traslados#show", :id => "1")
    end

    it "routes to #edit" do
      get("/traslados/1/edit").should route_to("traslados#edit", :id => "1")
    end

    it "routes to #create" do
      post("/traslados").should route_to("traslados#create")
    end

    it "routes to #update" do
      put("/traslados/1").should route_to("traslados#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/traslados/1").should route_to("traslados#destroy", :id => "1")
    end

  end
end
