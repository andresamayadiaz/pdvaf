require "spec_helper"

describe FormasdepagosController do
  describe "routing" do

    it "routes to #index" do
      get("/formasdepagos").should route_to("formasdepagos#index")
    end

    it "routes to #new" do
      get("/formasdepagos/new").should route_to("formasdepagos#new")
    end

    it "routes to #show" do
      get("/formasdepagos/1").should route_to("formasdepagos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/formasdepagos/1/edit").should route_to("formasdepagos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/formasdepagos").should route_to("formasdepagos#create")
    end

    it "routes to #update" do
      put("/formasdepagos/1").should route_to("formasdepagos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/formasdepagos/1").should route_to("formasdepagos#destroy", :id => "1")
    end

  end
end
