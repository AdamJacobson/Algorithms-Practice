require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top << vertex
    end
  end

  until top.empty?
    vertex = top.shift
    sorted << vertex
    neighbors = vertex.out_edges.map(&:to_vertex)

    vertex.disconnect!

    neighbors.each do |neighbor|
      if neighbor.in_edges.empty?
        top << neighbor
      end
    end
  end

  return sorted if sorted.length == vertices.length

  []
end

def topological_sort2(vertices)

end
