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

describe ListadepreciosController do

  # This should return the minimal set of attributes required to create a valid
  # Listadeprecio. As you add validations to Listadeprecio, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "nombre" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ListadepreciosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all listadeprecios as @listadeprecios" do
      listadeprecio = Listadeprecio.create! valid_attributes
      get :index, {}, valid_session
      assigns(:listadeprecios).should eq([listadeprecio])
    end
  end

  describe "GET show" do
    it "assigns the requested listadeprecio as @listadeprecio" do
      listadeprecio = Listadeprecio.create! valid_attributes
      get :show, {:id => listadeprecio.to_param}, valid_session
      assigns(:listadeprecio).should eq(listadeprecio)
    end
  end

  describe "GET new" do
    it "assigns a new listadeprecio as @listadeprecio" do
      get :new, {}, valid_session
      assigns(:listadeprecio).should be_a_new(Listadeprecio)
    end
  end

  describe "GET edit" do
    it "assigns the requested listadeprecio as @listadeprecio" do
      listadeprecio = Listadeprecio.create! valid_attributes
      get :edit, {:id => listadeprecio.to_param}, valid_session
      assigns(:listadeprecio).should eq(listadeprecio)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Listadeprecio" do
        expect {
          post :create, {:listadeprecio => valid_attributes}, valid_session
        }.to change(Listadeprecio, :count).by(1)
      end

      it "assigns a newly created listadeprecio as @listadeprecio" do
        post :create, {:listadeprecio => valid_attributes}, valid_session
        assigns(:listadeprecio).should be_a(Listadeprecio)
        assigns(:listadeprecio).should be_persisted
      end

      it "redirects to the created listadeprecio" do
        post :create, {:listadeprecio => valid_attributes}, valid_session
        response.should redirect_to(Listadeprecio.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved listadeprecio as @listadeprecio" do
        # Trigger the behavior that occurs when invalid params are submitted
        Listadeprecio.any_instance.stub(:save).and_return(false)
        post :create, {:listadeprecio => { "nombre" => "invalid value" }}, valid_session
        assigns(:listadeprecio).should be_a_new(Listadeprecio)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Listadeprecio.any_instance.stub(:save).and_return(false)
        post :create, {:listadeprecio => { "nombre" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested listadeprecio" do
        listadeprecio = Listadeprecio.create! valid_attributes
        # Assuming there are no other listadeprecios in the database, this
        # specifies that the Listadeprecio created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Listadeprecio.any_instance.should_receive(:update).with({ "nombre" => "MyString" })
        put :update, {:id => listadeprecio.to_param, :listadeprecio => { "nombre" => "MyString" }}, valid_session
      end

      it "assigns the requested listadeprecio as @listadeprecio" do
        listadeprecio = Listadeprecio.create! valid_attributes
        put :update, {:id => listadeprecio.to_param, :listadeprecio => valid_attributes}, valid_session
        assigns(:listadeprecio).should eq(listadeprecio)
      end

      it "redirects to the listadeprecio" do
        listadeprecio = Listadeprecio.create! valid_attributes
        put :update, {:id => listadeprecio.to_param, :listadeprecio => valid_attributes}, valid_session
        response.should redirect_to(listadeprecio)
      end
    end

    describe "with invalid params" do
      it "assigns the listadeprecio as @listadeprecio" do
        listadeprecio = Listadeprecio.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Listadeprecio.any_instance.stub(:save).and_return(false)
        put :update, {:id => listadeprecio.to_param, :listadeprecio => { "nombre" => "invalid value" }}, valid_session
        assigns(:listadeprecio).should eq(listadeprecio)
      end

      it "re-renders the 'edit' template" do
        listadeprecio = Listadeprecio.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Listadeprecio.any_instance.stub(:save).and_return(false)
        put :update, {:id => listadeprecio.to_param, :listadeprecio => { "nombre" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested listadeprecio" do
      listadeprecio = Listadeprecio.create! valid_attributes
      expect {
        delete :destroy, {:id => listadeprecio.to_param}, valid_session
      }.to change(Listadeprecio, :count).by(-1)
    end

    it "redirects to the listadeprecios list" do
      listadeprecio = Listadeprecio.create! valid_attributes
      delete :destroy, {:id => listadeprecio.to_param}, valid_session
      response.should redirect_to(listadeprecios_url)
    end
  end

end
