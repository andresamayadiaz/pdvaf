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

describe ConceptosController do

  # This should return the minimal set of attributes required to create a valid
  # Concepto. As you add validations to Concepto, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "cantidad" => "9.99" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ConceptosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all conceptos as @conceptos" do
      concepto = Concepto.create! valid_attributes
      get :index, {}, valid_session
      assigns(:conceptos).should eq([concepto])
    end
  end

  describe "GET show" do
    it "assigns the requested concepto as @concepto" do
      concepto = Concepto.create! valid_attributes
      get :show, {:id => concepto.to_param}, valid_session
      assigns(:concepto).should eq(concepto)
    end
  end

  describe "GET new" do
    it "assigns a new concepto as @concepto" do
      get :new, {}, valid_session
      assigns(:concepto).should be_a_new(Concepto)
    end
  end

  describe "GET edit" do
    it "assigns the requested concepto as @concepto" do
      concepto = Concepto.create! valid_attributes
      get :edit, {:id => concepto.to_param}, valid_session
      assigns(:concepto).should eq(concepto)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Concepto" do
        expect {
          post :create, {:concepto => valid_attributes}, valid_session
        }.to change(Concepto, :count).by(1)
      end

      it "assigns a newly created concepto as @concepto" do
        post :create, {:concepto => valid_attributes}, valid_session
        assigns(:concepto).should be_a(Concepto)
        assigns(:concepto).should be_persisted
      end

      it "redirects to the created concepto" do
        post :create, {:concepto => valid_attributes}, valid_session
        response.should redirect_to(Concepto.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved concepto as @concepto" do
        # Trigger the behavior that occurs when invalid params are submitted
        Concepto.any_instance.stub(:save).and_return(false)
        post :create, {:concepto => { "cantidad" => "invalid value" }}, valid_session
        assigns(:concepto).should be_a_new(Concepto)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Concepto.any_instance.stub(:save).and_return(false)
        post :create, {:concepto => { "cantidad" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested concepto" do
        concepto = Concepto.create! valid_attributes
        # Assuming there are no other conceptos in the database, this
        # specifies that the Concepto created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Concepto.any_instance.should_receive(:update).with({ "cantidad" => "9.99" })
        put :update, {:id => concepto.to_param, :concepto => { "cantidad" => "9.99" }}, valid_session
      end

      it "assigns the requested concepto as @concepto" do
        concepto = Concepto.create! valid_attributes
        put :update, {:id => concepto.to_param, :concepto => valid_attributes}, valid_session
        assigns(:concepto).should eq(concepto)
      end

      it "redirects to the concepto" do
        concepto = Concepto.create! valid_attributes
        put :update, {:id => concepto.to_param, :concepto => valid_attributes}, valid_session
        response.should redirect_to(concepto)
      end
    end

    describe "with invalid params" do
      it "assigns the concepto as @concepto" do
        concepto = Concepto.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Concepto.any_instance.stub(:save).and_return(false)
        put :update, {:id => concepto.to_param, :concepto => { "cantidad" => "invalid value" }}, valid_session
        assigns(:concepto).should eq(concepto)
      end

      it "re-renders the 'edit' template" do
        concepto = Concepto.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Concepto.any_instance.stub(:save).and_return(false)
        put :update, {:id => concepto.to_param, :concepto => { "cantidad" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested concepto" do
      concepto = Concepto.create! valid_attributes
      expect {
        delete :destroy, {:id => concepto.to_param}, valid_session
      }.to change(Concepto, :count).by(-1)
    end

    it "redirects to the conceptos list" do
      concepto = Concepto.create! valid_attributes
      delete :destroy, {:id => concepto.to_param}, valid_session
      response.should redirect_to(conceptos_url)
    end
  end

end
