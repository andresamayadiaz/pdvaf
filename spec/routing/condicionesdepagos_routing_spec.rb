require "spec_helper"

describe CondicionesdepagosController do
  describe "routing" do

    it "routes to #index" do
      get("/condicionesdepagos").should route_to("condicionesdepagos#index")
    end

    it "routes to #new" do
      get("/condicionesdepagos/new").should route_to("condicionesdepagos#new")
    end

    it "routes to #show" do
      get("/condicionesdepagos/1").should route_to("condicionesdepagos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/condicionesdepagos/1/edit").should route_to("condicionesdepagos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/condicionesdepagos").should route_to("condicionesdepagos#create")
    end

    it "routes to #update" do
      put("/condicionesdepagos/1").should route_to("condicionesdepagos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/condicionesdepagos/1").should route_to("condicionesdepagos#destroy", :id => "1")
    end

  end
end
