class Order < ApplicationRecord

    has_many :order_items
    #has_one :checkout
    #before_save :set_subtotal



    def subtotal
      order_items.collect{|order_item| order_item.valid? ? order_item.unit_price * order_item.quantity : 0}.sum
    end
    
    #def sub_total
        #sum = 0
        #self.order_items.each do |order_item|
          #sum+= order_item.total
        #end
        #return sum
    #end

    def total
        unit_price * quantity
    end


    #private

    #def set_subtotal
        #self.subtotal = subtotal
    #end
end
