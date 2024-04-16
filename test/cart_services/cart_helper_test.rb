require 'test_helper'
require 'minitest/autorun'
require 'cart_services/cart_helper'

class CartHelperTest < Minitest::Test
    describe 'Cart Methods' do
        def setup
            @cart = CartServices::CartHelper
        end


        it "Adds item to cart successfully" do
            subject = @cart.new

            subject.stub(:item_class , add_item_mock) do
                subject.add_item("Pen",10)

                assert_equal subject.cart_items.size , 1
            end
        end


        it "Removes item from cart successfully" do
            subject = @cart.new
            subject.stub(:item_class , remove_item_mock) do
                subject.add_item("Pen",10)
                result = subject.remove_item_by_index(0)
                assert_equal result,"Item Deleted"
                
            end
        end


        it "Remove item from cart using index unsuccessfull" do
            subject = @cart.new
            subject.stub(:item_class , remove_item_mock) do
                subject.add_item("Pen",10)
                result = subject.remove_item_by_index(1)
                assert_equal result,"No Such Item!"
                
            end
        end


        it "Cart Total updates when item added" do
            subject = @cart.new
            subject.stub(:item_class , add_item_mock) do
                subject.add_item("Pen",10)
                assert_equal subject.cart_total,10
                
            end
        end


        it "Cart Total updates when item removed" do
            subject = @cart.new
            subject.stub(:item_class , remove_item_mock) do
                subject.add_item("Pen",10)
                subject.remove_item_by_index(0)

                assert_equal subject.cart_total,0
            end
        end


        it "Succesfully remove item from cart using name" do
            subject = @cart.new

            subject.stub(:item_class , remove_by_name_success_mock) do
                subject.add_item("Pen",10)
                result = subject.remove_item_by_name("Pen")

                assert_equal result,"Item Deleted"
            end
        end


        it "Failed to remove item from cart using wrong name" do
            subject = @cart.new

            subject.stub(:item_class , remove_by_name_failure_mock) do
                subject.add_item("Pen",10)
                result = subject.remove_item_by_name("Pen")

                assert_equal result,"No Such Item!"
            end
        end


        def add_item_mock 
            mock = Minitest::Mock.new
            mock.expect(:new,mock,["Pen",10])
            mock.expect(:price,10)
            mock
        end

        def remove_item_mock 
            mock = Minitest::Mock.new
            mock.expect(:new,mock,["Pen",10])
            mock.expect(:price,10)
            mock.expect(:price,10)
            mock
        end

        def remove_by_name_success_mock
            mock = Minitest::Mock.new
            mock.expect(:new,mock,["Pen",10])
            mock.expect(:price,10)
            mock.expect(:price,10)
            mock.expect(:name,"Pen")
            mock
        end

        def remove_by_name_failure_mock
            mock = Minitest::Mock.new
            mock.expect(:new,mock,["Pen",10])
            mock.expect(:price,10)
            mock.expect(:price,10)
            mock.expect(:name,"Ball")
            mock
        end

    end

end