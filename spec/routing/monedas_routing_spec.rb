require "spec_helper"

describe MonedasController do
  describe "routing" do

    it "routes to #index" do
      get("/monedas").should route_to("monedas#index")
    end

    it "routes to #new" do
      get("/monedas/new").should route_to("monedas#new")
    end

    it "routes to #show" do
      get("/monedas/1").should route_to("monedas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/monedas/1/edit").should route_to("monedas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/monedas").should route_to("monedas#create")
    end

    it "routes to #update" do
      put("/monedas/1").should route_to("monedas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/monedas/1").should route_to("monedas#destroy", :id => "1")
    end

  end
end
