class Vertex
  attr_reader :in_edges, :out_edges, :value

  def initialize(value)
    @in_edges = []
    @out_edges = []
    @value = value
  end
end

class Edge
  attr_reader :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @from_vertex.out_edges << self

    @to_vertex = to_vertex
    @to_vertex.in_edges << self

    @cost = cost
  end

  def destroy!
    @from_vertex.in_edges.delete(self)
    @from_vertex.out_edges.delete(self)

    @to_vertex.in_edges.delete(self)
    @to_vertex.out_edges.delete(self)

    @from_vertex = nil
    @to_vertex = nil
  end
end
