require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
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

  def child_indices(parent_idx, length)
    if parent_idx >= length
      return []
    end

    left = child_indices((parent_idx * 2) + 1)
    right = child_indices((parent_idx * 2) + 2)

    [].concat(left).concat(right)
  end

  def parent_index(child_idx)
    debugger
    ((child_idx - 1) / 2)
  end

  public
  def self.child_indices(len, parent_index)
  end

  def self.parent_index(child_index)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
