module ProductsHelper
    def number_to_indian_currency(price)
    " ₹ #{price.to_s.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/,"\\1,")} "
    end
end
