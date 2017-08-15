require_relative "static_array"

class DynamicArray
  attr_reader :length # Number of items currently held

  def initialize
    self.length = 0
    self.capacity = 1
    self.store = StaticArray.new(capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless index < length
    self.store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless index < length
    self.store[index] = value
  end

  # O(1)
  def pop
    value = self[length - 1]
    self.length -= 1
    value
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if self.length == self.capacity
    self.length += 1
    self.store[length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity *= 2
    new_store = StaticArray.new(self.capacity)

    self.length.times { |idx| new_store[idx] = self.store[idx] }

    self.store = new_store
  end
end
