class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)

  end

  # Rearranges the array into 2 parts
  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx = start

    barrier = start
    (start + 1).upto(start + length - 1) do |i|
      if prc.call(array[start], array[i]) > 0

        if barrier > start
          array[i], array[barrier + 1] = array[barrier + 1], array[i]
        end

        barrier += 1
      end
    end

    array[pivot_idx], array[barrier] = array[barrier], array[pivot_idx]

    barrier
  end
end
