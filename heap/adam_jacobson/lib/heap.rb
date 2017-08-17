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

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
