require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return if length <= 1

    mid_idx = QuickSort.partition(array, start, length, &prc)

    # puts "part 1: start #{start}, length: #{mid_idx - start}"
    # puts "mid_idx : #{mid_idx}"
    # puts "part 2: start #{mid_idx + 1}, length: #{length - mid_idx + 1}"
    #
    # puts "-------------"

    QuickSort.sort2!(array, start, mid_idx - start)
    QuickSort.sort2!(array, mid_idx + 1, length - mid_idx)
  end

  # Rearranges the array into 2 parts
  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # puts "before partitioning by start: #{start}, length: #{length}"
    # p array

    # debugger

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

    # puts "after partitioning"
    # p array
    # puts "------------------"

    barrier
  end
end
