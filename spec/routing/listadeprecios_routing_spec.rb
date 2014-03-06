require "spec_helper"

describe ListadepreciosController do
  describe "routing" do

    it "routes to #index" do
      get("/listadeprecios").should route_to("listadeprecios#index")
    end

    it "routes to #new" do
      get("/listadeprecios/new").should route_to("listadeprecios#new")
    end

    it "routes to #show" do
      get("/listadeprecios/1").should route_to("listadeprecios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/listadeprecios/1/edit").should route_to("listadeprecios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/listadeprecios").should route_to("listadeprecios#create")
    end

    it "routes to #update" do
      put("/listadeprecios/1").should route_to("listadeprecios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/listadeprecios/1").should route_to("listadeprecios#destroy", :id => "1")
    end

  end
end
