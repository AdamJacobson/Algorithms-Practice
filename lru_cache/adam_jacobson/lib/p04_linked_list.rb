require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    pr = self.prev
    nx = self.next
    pr.next = nx
    nx.prev = pr
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new(:HEAD)
    @tail = Node.new(:TAIL)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next == @tail ? nil : @head.next
  end

  def last
    @tail.prev == @head ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)
    self.any? { |node| node.key == key }
  end

  def append(key, val)
    node = Node.new(key, val)

    node.prev = @tail.prev  # new node prev to old last
    @tail.prev.next = node  # old last next to new node
    @tail.prev = node       # tail prev to new node
    @tail.prev.next = @tail # new node next to tail

    node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.remove
        return
      end
    end
  end

  def each(&block)
    node = @head.next
    until node == @tail
      block.call(node)
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
