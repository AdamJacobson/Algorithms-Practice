require_relative "static_array"

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
    raise "index out of bounds" unless index < length
    i = (self.start_idx + index) % capacity
    self.store[i]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" unless index < length
    i = (self.start_idx + index) % capacity
    self.store[i] = val
  end

  # O(1)
  def pop
    val = self[self.length - 1]
    self.length -= 1
    val
  end

  # [a, b, c, _, _, x]
  #  0  1  2  3  4  5
  #  (5 + 4) % 6 = 9 % 6 = 3

  # O(1) ammortized
  def push(val)
    resize! if self.length == self.capacity

    # i = (self.start_idx + self.length) % self.capacity
    self.length += 1
    # self[i] = val
    self[self.length - 1] = val
  end

  # O(1)
  def shift
    self.start_idx = (self.start_idx + 1) % self.capacity
    self.length -= 1
  end

  # O(1) ammortized
  def unshift(val)
    resize! if self.length == self.capacity

    self.start_idx -= 1
    self[start_idx - 1] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    puts "Resize ring buffer to #{capacity * 2}"

    self.capacity *= 2
    new_store = StaticArray.new(self.capacity)

    ring_idx = start_idx
    new_idx = 0
    while new_idx < length
      new_store[new_idx] = self.store[ring_idx]

      ring_idx = (ring_idx + 1) % self.capacity
      new_idx += 1
    end

    self.store = new_store
  end
end
