class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
  end

  # 1, 2, 6, 13
  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    ans = blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1) * 2) - 1
    @blair_cache[n] = ans
    ans
  end

  def build_blair_nums_cache(n)
    cache = { 1 => 1, 2 => 2 }
    (3..n).each do |i|
      cache[i] = cache[i - 1] + cache[i - 2] + ((i - 1) * 2) - 1
    end
    cache
  end

  def blair_nums_bu(n)
    cache = build_blair_nums_cache(n)
    cache[n]
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache
  end

  def frog_cache_builder(n)
    cache = [
      [], [[1]], [[1,1],[2]], [[1,1,1],[1,2],[2,1],[3]]
    ]
    return cache[n] if cache[n]

    # [[1]] -> [[1,3],[3,1]]
    # [[1,1],[2]] -> [[2,1,1],[1,2,1],[1,1,2],[2,2]]
    [[1,1],[2]].map {|x| x << 2}.map {|x| x.permutation.to_a}.flatten(1).uniq
    # [1,1,1,1], [1,1,2], [1,2,1], [2,1,1], [1,3], [3,1], [2,2]
    # [1,1,1,1], [1,1,2], [1,2,1], [1,3], [2,1,1], [2,2], [3,1]

    (4..n).each do |i|
      minusOne = cache[i - 1].map { |x| x << 1 }.map { |x| x.permutation.to_a.uniq }.flatten(1)
      minusTwo = cache[i - 2].map { |x| x << 2 }.map { |x| x.permutation.to_a.uniq }.flatten(1)
      minusThree = cache[i - 3].map { |x| x << 3 }.map { |x| x.permutation.to_a.uniq }.flatten(1)

      cache[i] = (minusOne + minusTwo + minusThree).uniq
      # cache[i] = cache[i - 1] + cache[i - 2] + cache[i - 3]
    end

    cache[n]
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
