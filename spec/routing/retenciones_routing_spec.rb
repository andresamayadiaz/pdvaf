require "spec_helper"

describe RetencionesController do
  describe "routing" do

    it "routes to #index" do
      get("/retenciones").should route_to("retenciones#index")
    end

    it "routes to #new" do
      get("/retenciones/new").should route_to("retenciones#new")
    end

    it "routes to #show" do
      get("/retenciones/1").should route_to("retenciones#show", :id => "1")
    end

    it "routes to #edit" do
      get("/retenciones/1/edit").should route_to("retenciones#edit", :id => "1")
    end

    it "routes to #create" do
      post("/retenciones").should route_to("retenciones#create")
    end

    it "routes to #update" do
      put("/retenciones/1").should route_to("retenciones#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/retenciones/1").should route_to("retenciones#destroy", :id => "1")
    end

  end
end
