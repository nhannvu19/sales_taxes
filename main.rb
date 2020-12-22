require_relative './lib/receipt'

filepath = ARGV[0]
service = Receipt.new(filepath)
service.execute