require "spec_helper"

describe ConceptosController do
  describe "routing" do

    it "routes to #index" do
      get("/conceptos").should route_to("conceptos#index")
    end

    it "routes to #new" do
      get("/conceptos/new").should route_to("conceptos#new")
    end

    it "routes to #show" do
      get("/conceptos/1").should route_to("conceptos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/conceptos/1/edit").should route_to("conceptos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/conceptos").should route_to("conceptos#create")
    end

    it "routes to #update" do
      put("/conceptos/1").should route_to("conceptos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/conceptos/1").should route_to("conceptos#destroy", :id => "1")
    end

  end
end
