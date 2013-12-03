class Harry
  def initialize
    @basket = Hash.new 0
    @reduc = { 1 => 1, 2 => 0.95, 3 => 0.9, 4 => 0.8, 5 => 0.75 }
  end

  def basket_price
    price = 0
    while(@basket.size > 0)
      price += package_price
    end
    price
  end

  def package_price
    price = 0
    key_size = @basket.size
    @basket.each_key do |key| 
      if @basket[key] == 1
        @basket.delete(key)
      else
        @basket[key] -= 1 
      end
      price += 8
    end 
    price *= @reduc[key_size]
  end

  def add_book(book)
    @basket[book] += 1
  end
end
