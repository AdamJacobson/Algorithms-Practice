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
    node = find(value)
    @root = nil if node == @root
    delete_node(node) if node
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      return tree_node
    end

    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end

  private

  def delete_reference_to_node(node)
    if node.parent
      if node.parent.left == node
        node.parent.left = nil
      else
        node.parent.right = nil
      end
    end
  end

  def delete_node(node)
    if !node.left && !node.right
      delete_reference_to_node(node)
    elsif node.left && !node.right
      node = node.left
    elsif !node.left && node.right
      node = node.right
    else
      replacement = maximum(node.left)
      node.value = replacement.value

      delete_node(replacement)
    end
  end

  def insert_rec(value, tree_node)
    case value <=> tree_node.value
    when 1
      if tree_node.right.nil?
        new_node = BSTNode.new(value)
        new_node.parent = tree_node
        tree_node.right = new_node
        return
      end
      insert_rec(value, tree_node.right)
    else
      if tree_node.left.nil?
        new_node = BSTNode.new(value)
        new_node.parent = tree_node
        tree_node.left = new_node
        return
      end
      insert_rec(value, tree_node.left)
    end
  end
end
