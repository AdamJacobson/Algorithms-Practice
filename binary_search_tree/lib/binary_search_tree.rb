# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

require 'byebug'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
      return
    end

    insert_rec(value, @root)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?

    case value <=> tree_node.value
    when 0
      return tree_node
    when -1
      return find(value, tree_node.left)
    when 1
      return find(value, tree_node.right)
    end
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

  def insert_rec(value, tree_node)
    case value <=> tree_node.value
    when 1
      if tree_node.right.nil?
        tree_node.right = BSTNode.new(value)
        return
      end
      insert_rec(value, tree_node.right)
    else
      if tree_node.left.nil?
        tree_node.left = BSTNode.new(value)
        return
      end
      insert_rec(value, tree_node.left)
    end
  end
end
