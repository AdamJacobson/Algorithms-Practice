require_relative "static_array"

require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    self.length = 0
    self.capacity = 8
    self.start_idx = 0
    self.store = StaticArray.new(capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    i = (self.start_idx + index) % capacity
    self.store[i]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    i = (self.start_idx + index) % capacity
    self.store[i] = val
  end

  # O(1)
  def pop
    val = self[self.length - 1]
    self.length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if self.length == self.capacity

    self.length += 1
    self[self.length - 1] = val

    val
  end

  # O(1)
  def shift
    val = self[0]
    self.start_idx = (self.start_idx + 1) % self.capacity
    self.length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if self.length == self.capacity

    self.start_idx = (self.start_idx - 1) % self.capacity
    self.store[self.start_idx] = val

    self.length += 1
  end

  def to_a
    idx = self.start_idx
    count = 0

    items = []

    while count < self.length
      items << self.store[idx]
      idx = (idx + 1) % self.capacity
      count += 1
    end

    items
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless 0 <= index && index < self.length
  end

  def resize!
    current_elements = self.to_a
    self.start_idx = 0

    self.capacity *= 2
    new_store = StaticArray.new(self.capacity)

    current_elements.each_with_index do |el, idx|
      new_store[idx] = el
    end

    self.store = new_store
  end
end
