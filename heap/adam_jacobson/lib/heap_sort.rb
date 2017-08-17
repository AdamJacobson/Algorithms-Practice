require_relative "heap"

class Array
  def heap_sort!
    self.length.times do |i|
      BinaryMinHeap.heapify_up(self, i)
    end

    self.length.times do |i|
      last = self.length - 1 - i

      self[0], self[last] = self[last], self[0]
      BinaryMinHeap.heapify_down(self, 0, last)
    end

    self.reverse!
  end
end
