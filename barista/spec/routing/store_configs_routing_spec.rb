require "spec_helper"

describe StoreConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/store_configs").should route_to("store_configs#index")
    end

    it "routes to #new" do
      get("/store_configs/new").should route_to("store_configs#new")
    end

    it "routes to #show" do
      get("/store_configs/1").should route_to("store_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/store_configs/1/edit").should route_to("store_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/store_configs").should route_to("store_configs#create")
    end

    it "routes to #update" do
      put("/store_configs/1").should route_to("store_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/store_configs/1").should route_to("store_configs#destroy", :id => "1")
    end

  end
end
