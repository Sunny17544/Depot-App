require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
      assert true
  end

  test "should create a new product" do
    post products_path, params: { product: { name: "Sunny", model: "Sunny", colour: "sunny"   } }
  end

  test "should create Product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { name: "Sunny", model: "Bunny", colour: "Munny" } }
    end
  
    assert_redirected_to product_path(Product).last
  end
  
  test "ajax request" do
    product = products(:one)
    get product_url(product), xhr: true
  
    assert_equal "hello world", @response.body
    assert_equal "text/javascript", @response.media_type
  end


  test "edit action should be success" do
    get :edit 
    assert_response :success
  end

  test "new should be success" do
    get :new
    assert_response :success
  end
end
