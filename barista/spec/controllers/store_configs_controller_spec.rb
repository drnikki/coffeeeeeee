require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StoreConfigsController do

  # This should return the minimal set of attributes required to create a valid
  # StoreConfig. As you add validations to StoreConfig, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StoreConfigsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all store_configs as @store_configs" do
      store_config = StoreConfig.create! valid_attributes
      get :index, {}, valid_session
      assigns(:store_configs).should eq([store_config])
    end
  end

  describe "GET show" do
    it "assigns the requested store_config as @store_config" do
      store_config = StoreConfig.create! valid_attributes
      get :show, {:id => store_config.to_param}, valid_session
      assigns(:store_config).should eq(store_config)
    end
  end

  describe "GET new" do
    it "assigns a new store_config as @store_config" do
      get :new, {}, valid_session
      assigns(:store_config).should be_a_new(StoreConfig)
    end
  end

  describe "GET edit" do
    it "assigns the requested store_config as @store_config" do
      store_config = StoreConfig.create! valid_attributes
      get :edit, {:id => store_config.to_param}, valid_session
      assigns(:store_config).should eq(store_config)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new StoreConfig" do
        expect {
          post :create, {:store_config => valid_attributes}, valid_session
        }.to change(StoreConfig, :count).by(1)
      end

      it "assigns a newly created store_config as @store_config" do
        post :create, {:store_config => valid_attributes}, valid_session
        assigns(:store_config).should be_a(StoreConfig)
        assigns(:store_config).should be_persisted
      end

      it "redirects to the created store_config" do
        post :create, {:store_config => valid_attributes}, valid_session
        response.should redirect_to(StoreConfig.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store_config as @store_config" do
        # Trigger the behavior that occurs when invalid params are submitted
        StoreConfig.any_instance.stub(:save).and_return(false)
        post :create, {:store_config => { "name" => "invalid value" }}, valid_session
        assigns(:store_config).should be_a_new(StoreConfig)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        StoreConfig.any_instance.stub(:save).and_return(false)
        post :create, {:store_config => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested store_config" do
        store_config = StoreConfig.create! valid_attributes
        # Assuming there are no other store_configs in the database, this
        # specifies that the StoreConfig created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        StoreConfig.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => store_config.to_param, :store_config => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested store_config as @store_config" do
        store_config = StoreConfig.create! valid_attributes
        put :update, {:id => store_config.to_param, :store_config => valid_attributes}, valid_session
        assigns(:store_config).should eq(store_config)
      end

      it "redirects to the store_config" do
        store_config = StoreConfig.create! valid_attributes
        put :update, {:id => store_config.to_param, :store_config => valid_attributes}, valid_session
        response.should redirect_to(store_config)
      end
    end

    describe "with invalid params" do
      it "assigns the store_config as @store_config" do
        store_config = StoreConfig.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StoreConfig.any_instance.stub(:save).and_return(false)
        put :update, {:id => store_config.to_param, :store_config => { "name" => "invalid value" }}, valid_session
        assigns(:store_config).should eq(store_config)
      end

      it "re-renders the 'edit' template" do
        store_config = StoreConfig.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StoreConfig.any_instance.stub(:save).and_return(false)
        put :update, {:id => store_config.to_param, :store_config => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested store_config" do
      store_config = StoreConfig.create! valid_attributes
      expect {
        delete :destroy, {:id => store_config.to_param}, valid_session
      }.to change(StoreConfig, :count).by(-1)
    end

    it "redirects to the store_configs list" do
      store_config = StoreConfig.create! valid_attributes
      delete :destroy, {:id => store_config.to_param}, valid_session
      response.should redirect_to(store_configs_url)
    end
  end

end
