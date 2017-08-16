require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new # Each element of the map maps to an element of the linked list
    @store = LinkedList.new # Stores the actual data
    @max = max
    @prc = prc # represents database lookup function
  end

  def count
    @map.count
  end

  def get(key)
    node = @map.get(key)

    if node
      node = update_node!(node)
    else
      node = calc!(key)
    end

    # In hash map, set value pointing to node in linked list
    @map.set(node.key, node)

    # Eject LRUs
    while @map.count > @max
      key = @store.first.key
      @store.remove(key)
      @map.delete(key)
    end

    node.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  # insert an (un-cached) key
  def calc!(key)
    @store.append(key, @prc.call(key))
  end

  # move a node to the end of the list
  def update_node!(node)
    node.remove
    @store.append(node.key, node.val)
  end

  def eject!
  end
end
