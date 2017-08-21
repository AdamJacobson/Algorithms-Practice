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
    if node == @root
      @root = nil
      return
    end
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
    return 0 if tree_node.nil?

    left_depth = tree_node.left.nil? ? 0 : 1 + depth(tree_node.left)
    right_depth = tree_node.right.nil? ? 0 : 1 + depth(tree_node.right)

    [left_depth, right_depth].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?

    left_dep = depth(tree_node.left)
    right_dep = depth(tree_node.right)

    if (left_dep - right_dep).abs > 1
      return false
    end

    left_bal = is_balanced?(tree_node.left)
    right_bal = is_balanced?(tree_node.right)

    if !left_bal && !right_bal
      return false
    end

    true
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
      node.parent.left = node.left
      node.parent = nil
    elsif !node.left && node.right
      node.parent.right = node.right
      node.parent = nil
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
