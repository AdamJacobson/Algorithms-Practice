require_relative 'p02_hashing'
require_relative 'p04_linked_list'

require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&block)
    @store.each do |bucket|
      bucket.each do |el|
        block.call([el.key, el.val])
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }

    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.key.hash % (num_buckets * 2)].append(el.key, el.val)
      end
    end

    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
