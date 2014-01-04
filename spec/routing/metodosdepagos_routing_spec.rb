require "spec_helper"

describe MetodosdepagosController do
  describe "routing" do

    it "routes to #index" do
      get("/metodosdepagos").should route_to("metodosdepagos#index")
    end

    it "routes to #new" do
      get("/metodosdepagos/new").should route_to("metodosdepagos#new")
    end

    it "routes to #show" do
      get("/metodosdepagos/1").should route_to("metodosdepagos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/metodosdepagos/1/edit").should route_to("metodosdepagos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/metodosdepagos").should route_to("metodosdepagos#create")
    end

    it "routes to #update" do
      put("/metodosdepagos/1").should route_to("metodosdepagos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/metodosdepagos/1").should route_to("metodosdepagos#destroy", :id => "1")
    end

  end
end
