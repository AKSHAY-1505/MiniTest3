module CartServices

    class CartHelper
        attr_reader :cart_items , :cart_total

        def initialize
            @cart_items = []
            @cart_total = 0
        end

        def add_item(item_name,item_price)
            item = item_class.new(item_name,item_price)
            @cart_items << item
            @cart_total = @cart_total + item.price
        end

        def remove_item_by_index(index)
            begin
                item = @cart_items.delete_at(index)
                @cart_total = @cart_total - item.price
                return "Item Deleted"
            rescue
                return "No Such Item!"
            end
        end

        def remove_item_by_name(name)
            @cart_items.each_with_index do |item,index|
                if item.name == name
                    @cart_total = @cart_total - item.price
                    @cart_items.delete_at(index)
                    return "Item Deleted"
                end
            end
            return "No Such Item!"
        end

        def item_class(class_name: Item)
            class_name
        end
    end
end