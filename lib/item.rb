class Item
  attr_reader :quantity, :product, :price

  SKIPPED_SALES_TAX = %w[book food chocolate chocolates pills]

  def initialize(quantity, product, price)
    @quantity = quantity.to_i
    @product = product
    @price = BigDecimal(price)
  end

  def import_tax
    @import_tax ||= begin
      unless product.downcase.include?('imported')
        0
      else
        total_price * 0.05
      end
    end
  end

  def sales_tax
    @sales_tax ||= begin
      if (product.split & SKIPPED_SALES_TAX).size > 0
        0
      else
        total_price * 0.1
      end
    end
  end

  def total_price
    quantity * price
  end

  def total_tax
    round(sales_tax + import_tax)
  end

  private

  def round(number, increment = 0.05)
    return number unless number.is_a?(BigDecimal)
    BigDecimal(((number / increment).round(0, :up) * increment).to_s)
  end
end
