class BSTNode
  attr_accessor :value, :left, :right, :parent

  def initialize(val)
    @value = val
    @left = nil
    @right = nil
    @parent = nil
  end
end
