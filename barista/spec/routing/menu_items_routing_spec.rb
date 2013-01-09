require "spec_helper"

describe MenuItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/menu_items").should route_to("menu_items#index")
    end

    it "routes to #new" do
      get("/menu_items/new").should route_to("menu_items#new")
    end

    it "routes to #show" do
      get("/menu_items/1").should route_to("menu_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/menu_items/1/edit").should route_to("menu_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/menu_items").should route_to("menu_items#create")
    end

    it "routes to #update" do
      put("/menu_items/1").should route_to("menu_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/menu_items/1").should route_to("menu_items#destroy", :id => "1")
    end

  end
end
