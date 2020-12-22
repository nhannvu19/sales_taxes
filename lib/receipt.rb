require_relative './item'
require 'bigdecimal'
require 'csv'

class Receipt
  attr_accessor :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def execute
    unless filepath && File.exist?(filepath)
      puts "File #{filepath} is missing"
      return [-1, 'file_missing']
    end

    total_price = total_tax = 0

    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      quantity, product, price = row.values_at(:quantity, :product, :price)

      item = Item.new(quantity, product, price)
      total_tax += item.total_tax
      total_price += item.total_price

      puts [quantity, product, normalize(item.total_price + item.total_tax)].join(',')
    end

    total_amount = BigDecimal(total_price) + BigDecimal(total_tax)

    total_tax = normalize(total_tax)
    total_amount = normalize(total_amount)

    puts "Sales Tax: #{total_tax}"
    puts "Total Amount: #{total_amount}"

    [total_tax, total_amount]
  end

  private

  def normalize(number)
    '%.2f' % number
  end
end
