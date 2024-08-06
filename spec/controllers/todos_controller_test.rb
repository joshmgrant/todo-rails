require "rails_helper"

RSpec.describe TodosController, type: :controller do

  describe 'GET index' do
    it 'should render success' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    let(:create_params) do
      { todo: { done: false, title: "Hello Rails" }}
    end

    it 'should create todos' do
      expect { post :create, params: create_params }.to change(Todo, :count).by(1)
    end
  end

  describe 'PUT update' do
    let(:todo) { create(:todo, title: "New Todo", done: true) }
    let(:update_params) do 
      { id: todo.id, todo: { title: "Learning Rails" }}
    end

    it 'should update todos' do
      expect do 
        put :update, params: update_params
        todo.reload 
      end.to change(todo, :title).from("New Todo").to("Learning Rails")
    end
  end

  describe 'DELETE destroy' do
    let(:todo) { create(:todo) }

    it 'should destroy todo' do
      delete :destroy, params: { id: todo.id }
      expect(response).to have_http_status(:no_content)
    end
  end
  
  describe 'GET show' do
    let(:todo) { create(:todo) }

    it 'should show one todo' do
      get :show, params: { id: todo.id }
      expect(response).to have_http_status(:success)
    end
  end

  # test "should return not found for non-existing todo" do
  #   get todo_url(id: 'non-existing-id')
  #   assert_response :not_found
  #   assert_equal 'Todo not found', @response.body
  # end

end
