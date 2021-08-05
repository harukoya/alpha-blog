require "test_helper"

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "normal", email: "normal@example.com", password: "password", admin: false)
    sign_in_as(@user)
    Category.create(name: "Sports")
    Category.create(name: "News")
  end

  test "Create new article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "test article", description: "test description", category_ids: [1, 2] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Article was created successfully.", response.body
  end
end
