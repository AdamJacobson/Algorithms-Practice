# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require 'byebug'

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_array = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)

    if val > self.max
      @max_array = RingBuffer.new
    else
      idx = @max_array.length - 1
      while idx >= 0 && @max_array[idx] <= val
        @max_array.pop
        idx -= 1
      end
    end

    @max_array.push(val)
  end

  def dequeue
    val = @store.shift
    @max_array.shift if val == self.max

    val
  end

  def max
    return 0 if @max_array.length == 0

    @max_array[0]
  end

  def length
    @store.length
  end

end
