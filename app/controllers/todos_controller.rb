class TodosController < ApplicationController
  def index
    todos = Todo.order("created_at DESC")
    render json: todos
  end

  def create
    todo = Todo.create(todo_param)

    render json: todo, status: :created
  end

  def show
    todo = Todo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: 'Todo not found', status: :not_found
  end

  def update
    todo = Todo.find(params[:id])
    todo.update(todo_param)

    render json: todo, status: :ok
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy

    head :no_content, status: :no_content
  end

  private 
  def todo_param
    params.require(:todo).permit(:title, :done)
  end
end
