require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
  result = BinaryMinHeap.new

  k.times do
    result.push(array.pop)
  end

  until array.empty?
    result.push(array.pop)
    result.extract
  end
  result.store

  # array.heap_sort!.drop(array.length - k)
end
