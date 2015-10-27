# What is it good for?

# I've been using it for transforming data
# (the T in ETL)

# Transproc is a neat functional library that is
# great for transformations (https://github.com/solnic/transproc)
require 'transproc'

# Use transproc's functions
class Function
  extend Transproc::Registry
  import Transproc::HashTransformations
end

RenameKey = -> (from, to) {
  -> (row) {
    row
  }
}

TRANSFORMS = [
  Function[:deep_symbolize_keys],
  Function[:accept_keys, [:id, :title, :updated_at]],
  RenameKey[:title, :name],
]

require 'json'
products = JSON.load(File.open('products.json'))['products']

p = products.map do |row|
  result = Hash[row]

  TRANSFORMS.each do |t|
    result = t[result]
  end
  result
end
