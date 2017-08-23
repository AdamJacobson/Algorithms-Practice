def install_order_2(arr)
  vertices = {}
  arr.each do |tuple|
    dependent = tupel[0]
    dependency = tuple[1]

    verticies[dependent] = Vertex.new(dependent) unless vertices[dependent]
    vertices[dependency] = Vertex.new(dependency) if dependency && !vertices[dependency]
    Edge.new(vertices[dependency], vertices[dependent]) if dependency
  end

  topological_sort(verices.values).map { |v| v.value }

end
