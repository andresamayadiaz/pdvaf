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

describe ConfiguracionesController do

  # This should return the minimal set of attributes required to create a valid
  # Configuracion. As you add validations to Configuracion, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "nombre" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ConfiguracionesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all configuraciones as @configuraciones" do
      configuracion = Configuracion.create! valid_attributes
      get :index, {}, valid_session
      assigns(:configuraciones).should eq([configuracion])
    end
  end

  describe "GET show" do
    it "assigns the requested configuracion as @configuracion" do
      configuracion = Configuracion.create! valid_attributes
      get :show, {:id => configuracion.to_param}, valid_session
      assigns(:configuracion).should eq(configuracion)
    end
  end

  describe "GET new" do
    it "assigns a new configuracion as @configuracion" do
      get :new, {}, valid_session
      assigns(:configuracion).should be_a_new(Configuracion)
    end
  end

  describe "GET edit" do
    it "assigns the requested configuracion as @configuracion" do
      configuracion = Configuracion.create! valid_attributes
      get :edit, {:id => configuracion.to_param}, valid_session
      assigns(:configuracion).should eq(configuracion)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Configuracion" do
        expect {
          post :create, {:configuracion => valid_attributes}, valid_session
        }.to change(Configuracion, :count).by(1)
      end

      it "assigns a newly created configuracion as @configuracion" do
        post :create, {:configuracion => valid_attributes}, valid_session
        assigns(:configuracion).should be_a(Configuracion)
        assigns(:configuracion).should be_persisted
      end

      it "redirects to the created configuracion" do
        post :create, {:configuracion => valid_attributes}, valid_session
        response.should redirect_to(Configuracion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved configuracion as @configuracion" do
        # Trigger the behavior that occurs when invalid params are submitted
        Configuracion.any_instance.stub(:save).and_return(false)
        post :create, {:configuracion => { "nombre" => "invalid value" }}, valid_session
        assigns(:configuracion).should be_a_new(Configuracion)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Configuracion.any_instance.stub(:save).and_return(false)
        post :create, {:configuracion => { "nombre" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested configuracion" do
        configuracion = Configuracion.create! valid_attributes
        # Assuming there are no other configuraciones in the database, this
        # specifies that the Configuracion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Configuracion.any_instance.should_receive(:update).with({ "nombre" => "MyString" })
        put :update, {:id => configuracion.to_param, :configuracion => { "nombre" => "MyString" }}, valid_session
      end

      it "assigns the requested configuracion as @configuracion" do
        configuracion = Configuracion.create! valid_attributes
        put :update, {:id => configuracion.to_param, :configuracion => valid_attributes}, valid_session
        assigns(:configuracion).should eq(configuracion)
      end

      it "redirects to the configuracion" do
        configuracion = Configuracion.create! valid_attributes
        put :update, {:id => configuracion.to_param, :configuracion => valid_attributes}, valid_session
        response.should redirect_to(configuracion)
      end
    end

    describe "with invalid params" do
      it "assigns the configuracion as @configuracion" do
        configuracion = Configuracion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Configuracion.any_instance.stub(:save).and_return(false)
        put :update, {:id => configuracion.to_param, :configuracion => { "nombre" => "invalid value" }}, valid_session
        assigns(:configuracion).should eq(configuracion)
      end

      it "re-renders the 'edit' template" do
        configuracion = Configuracion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Configuracion.any_instance.stub(:save).and_return(false)
        put :update, {:id => configuracion.to_param, :configuracion => { "nombre" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested configuracion" do
      configuracion = Configuracion.create! valid_attributes
      expect {
        delete :destroy, {:id => configuracion.to_param}, valid_session
      }.to change(Configuracion, :count).by(-1)
    end

    it "redirects to the configuraciones list" do
      configuracion = Configuracion.create! valid_attributes
      delete :destroy, {:id => configuracion.to_param}, valid_session
      response.should redirect_to(configuraciones_url)
    end
  end

end
