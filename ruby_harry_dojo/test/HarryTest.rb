require "src/Harry"
require "test/unit"

class HarryTest < Test::Unit::TestCase
  def test_price_zero_book_is_zero
    harry = Harry.new()
    assert_equal(0,harry.basket_price())
  end

  def test_price_one_book_is_8
    harry = Harry.new()
    harry.add_book(:book_one)
    assert_equal(8,harry.basket_price())
  end
 
  def test_price_two_same_books_is_16
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_one)
    assert_equal(16,harry.basket_price())
  end

  def test_price_two_different_books_is_15_2
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    assert_equal(15.2,harry.basket_price())
  end

  def test_price_3_different_books_is_21_6
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    harry.add_book(:book_three)
    assert_equal(21.6,harry.basket_price())
  end

  def test_price_4_different_books_is_25_6
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    harry.add_book(:book_three)
    harry.add_book(:book_five)
    assert_equal(25.6,harry.basket_price())
  end

  def test_price_5_different_books_is_30
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    harry.add_book(:book_three)
    harry.add_book(:book_four)
    harry.add_book(:book_five)
    assert_equal(30,harry.basket_price())
  end

  def test_price_1_plus_2_different_books_is_23_2
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    assert_equal(23.2,harry.basket_price())
  end

  def test_price_complex_basket
    harry = Harry.new()
    harry.add_book(:book_one)
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    harry.add_book(:book_three)
    harry.add_book(:book_one)
    harry.add_book(:book_two)
    harry.add_book(:book_three)
    harry.add_book(:book_four)
    harry.add_book(:book_five)
    assert_equal(59.6,harry.basket_price())
  end
end
