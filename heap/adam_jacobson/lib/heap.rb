require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    # prc represents the ideal condition. If true, nothing needs to be done.
    prc = Proc.new { |parent, child| parent < child } if prc.nil?
    @store = []
  end

  def count
    @store.length
  end

  def extract
    last = self.count - 1

    @store[0], @store[last] = @store[last], @store[0]
    val = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0)

    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    @store = BinaryMinHeap.heapify_up(@store, self.count - 1)
  end

  def self.child_indices(len, parent_idx)
    children = []

    maybe = [(parent_idx * 2) + 1, (parent_idx * 2) + 2]
    maybe.each { |ch| children << ch if ch < len }

    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    ((child_index - 1) / 2)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 } # min heap
    child_idxs = self.child_indices(len, parent_idx)

    while child_idxs.any?
      parent = array[parent_idx]
      child_idxs = child_idxs.select { |i| prc.call(parent, array[i]) > 0 }

      if child_idxs.empty?
        return array
      elsif child_idxs.length == 1
        swap_idx = child_idxs[0]
      else
        case prc.call(array[child_idxs[0]], array[child_idxs[1]])
        when 1
          swap_idx = child_idxs[1]
        else
          swap_idx = child_idxs[0]
        end
      end

      array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]
      parent_idx = swap_idx

      child_idxs = self.child_indices(len, parent_idx)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = Proc.new { |el1, el2| el1 <=> el2 } if prc.nil?

    while child_idx > 0
      parent_idx = self.parent_index(child_idx)

      parent = array[parent_idx]
      child = array[child_idx]

      if prc.call(parent, child) > 0
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        child_idx = parent_idx
      else
        return array
      end
    end

    array
  end
end
