require "./test/blocks_test.rb"
require 'pp'

class Array

  def get_evens
    self.even_map { |i| i }
  end

  def even_map
    if block_given?
      res = []
      self.each_with_index do |n, i|
        res <<  yield(n) if i.even?
      end
      res
    else
      raise "No block given for even_map"
    end
  end

  def even_reduce(acc)
    if block_given?
      self.get_evens.reduce(acc) { |a, b| yield(a,b)  }
    else
      raise "No block given for even_reduce"
    end
  end

  def even_reduce_arg(acc, func)
    self.get_evens.reduce(acc) { |a, b| func.call(a, b) }
  end

  def map_with_siblings
    res = []
    self.each do |n| 
     res << [n < 2 ? nil : self[n-2], self[n-1], self[n]]
    end
    res
  end

end