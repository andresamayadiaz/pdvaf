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

describe ClientesController do

  # This should return the minimal set of attributes required to create a valid
  # Cliente. As you add validations to Cliente, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "rfc" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all clientes as @clientes" do
      cliente = Cliente.create! valid_attributes
      get :index, {}, valid_session
      assigns(:clientes).should eq([cliente])
    end
  end

  describe "GET show" do
    it "assigns the requested cliente as @cliente" do
      cliente = Cliente.create! valid_attributes
      get :show, {:id => cliente.to_param}, valid_session
      assigns(:cliente).should eq(cliente)
    end
  end

  describe "GET new" do
    it "assigns a new cliente as @cliente" do
      get :new, {}, valid_session
      assigns(:cliente).should be_a_new(Cliente)
    end
  end

  describe "GET edit" do
    it "assigns the requested cliente as @cliente" do
      cliente = Cliente.create! valid_attributes
      get :edit, {:id => cliente.to_param}, valid_session
      assigns(:cliente).should eq(cliente)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cliente" do
        expect {
          post :create, {:cliente => valid_attributes}, valid_session
        }.to change(Cliente, :count).by(1)
      end

      it "assigns a newly created cliente as @cliente" do
        post :create, {:cliente => valid_attributes}, valid_session
        assigns(:cliente).should be_a(Cliente)
        assigns(:cliente).should be_persisted
      end

      it "redirects to the created cliente" do
        post :create, {:cliente => valid_attributes}, valid_session
        response.should redirect_to(Cliente.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cliente as @cliente" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cliente.any_instance.stub(:save).and_return(false)
        post :create, {:cliente => { "rfc" => "invalid value" }}, valid_session
        assigns(:cliente).should be_a_new(Cliente)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cliente.any_instance.stub(:save).and_return(false)
        post :create, {:cliente => { "rfc" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cliente" do
        cliente = Cliente.create! valid_attributes
        # Assuming there are no other clientes in the database, this
        # specifies that the Cliente created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cliente.any_instance.should_receive(:update).with({ "rfc" => "MyString" })
        put :update, {:id => cliente.to_param, :cliente => { "rfc" => "MyString" }}, valid_session
      end

      it "assigns the requested cliente as @cliente" do
        cliente = Cliente.create! valid_attributes
        put :update, {:id => cliente.to_param, :cliente => valid_attributes}, valid_session
        assigns(:cliente).should eq(cliente)
      end

      it "redirects to the cliente" do
        cliente = Cliente.create! valid_attributes
        put :update, {:id => cliente.to_param, :cliente => valid_attributes}, valid_session
        response.should redirect_to(cliente)
      end
    end

    describe "with invalid params" do
      it "assigns the cliente as @cliente" do
        cliente = Cliente.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cliente.any_instance.stub(:save).and_return(false)
        put :update, {:id => cliente.to_param, :cliente => { "rfc" => "invalid value" }}, valid_session
        assigns(:cliente).should eq(cliente)
      end

      it "re-renders the 'edit' template" do
        cliente = Cliente.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cliente.any_instance.stub(:save).and_return(false)
        put :update, {:id => cliente.to_param, :cliente => { "rfc" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cliente" do
      cliente = Cliente.create! valid_attributes
      expect {
        delete :destroy, {:id => cliente.to_param}, valid_session
      }.to change(Cliente, :count).by(-1)
    end

    it "redirects to the clientes list" do
      cliente = Cliente.create! valid_attributes
      delete :destroy, {:id => cliente.to_param}, valid_session
      response.should redirect_to(clientes_url)
    end
  end

end
