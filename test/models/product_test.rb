require "test_helper"

class ProductTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "should not save product without name" do
     product = Product.new
     assert_not product.save, "Saved the Product without a name"
   end

   test "should report error" do
    assert_raises(NameError) do
      some_undefined_variable
    end
  end

  test "should not save product without model" do
    product = Product.new
    assert_not product.save, "Saved the Product without a model"
  end

  #test "should not save product without colour" do
   # product = Product.new
    #assert_not product.save, "Saved the Product without a colour"
  #end
  
  test "should not save negeivite values in price" do
    product = Product.new(name: "Sunny", model: "Nissan", colour: "Red", price: -2000)
    assert_not product.save 
    assert product.errors[:price].any?
  end

  test "Should not save  without image" do
    product = Product.new(name: "Bunny", model: "Duke", colour: "orange", price: 13400)
    assert_not product.save

    assert product.errors[:image].any?
  end

  test "All Details are succesfully saved" do
    product=Product.last
    assert product.errors[:name].none?
    assert product.errors[:model].none?
    assert product.errors[:colour].none?
    assert product.errors[:price].none?   
    assert product.errors[:image].none?
  end

  
end
