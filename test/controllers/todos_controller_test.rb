require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todos_url
    assert_response :success
  end

  test "should create todos" do
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { done: false, title: "Hello Rails" } }
    end
  
    assert_response :created
  end

  test "should update todo" do   
    todo = create(:todo, title: "New Todo", done: true)
    patch todo_url(todo), params: { todo: { title: "Learning Rails" } }
   
    # no frontend or form here to manage
    # Reload association to fetch updated data and assert that title is updated.
    todo.reload
    assert_equal "Learning Rails", todo.title
    assert_same true, todo.done
  end

  test "should destroy todo" do
    todo = create(:todo)
    # assert_difference("Todo.count", -1) do
    #   delete todo_url(todo)
    # end
    
    assert_raises(ActiveRecord::RecordNotFound) do
      delete todo_url(todo)
      todo.reload
      todo
    end
  
    assert_response :no_content
  end

  test "should show todo" do
    todo = todos(:one)
    get todo_url(todo)
    assert_response :success
  end

  test "should return not found for non-existing todo" do
    get todo_url(id: 'non-existing-id')
    assert_response :not_found
    assert_equal 'Todo not found', @response.body
  end

end
