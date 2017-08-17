require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    # prc represents the ideal condition. If true, nothing needs to be done.
    prc = Proc.new { |parent, child| parent < child } if prc.nil?
    @heap = []
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
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
    prc = Proc.new { |parent, child| parent < child } if prc.nil?
    child_idxs = self.child_indices(len, parent_idx)

    while child_idxs.any? { |idx| idx < len - 1 }
      parent = array[parent_idx]
      children = [array[child_idxs[0]], array[child_idxs[1]]]

      if !prc.call(parent, children[0])
        array[parent_idx], array[child_idxs[0]] = array[child_idxs[0]], array[parent_idx]
        parent_idx = child_idxs[0]
      elsif !prc.call(parent, children[1])
        array[parent_idx], array[child_idxs[1]] = array[child_idxs[1]], array[parent_idx]
        parent_idx = child_idxs[1]
      else
        return array # No swapping done. Item is in correct position
      end

      child_idxs = self.child_indices(len, parent_idx)
    end

    return array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
