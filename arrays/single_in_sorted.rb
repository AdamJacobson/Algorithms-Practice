# given a sorted array consisting of only integers where
# every element appears twice except for one element.
# Find that one element in O(logn) time and O(1) space

# [1,1,3,3,4,5,5]
# [1,3,3,4,4,5,5]
# [1,1,3,3,4,4,5]

# [1,1,3,3,4,5,5]

# [1,1,3,3,7,7,8,9,9]
# if right matched mid: search right
# else search left

def single_in_sorted(arr)
  mid = arr.length / 2
  if arr[mid] != arr[mid - 1] && arr[mid] != arr[mid + 1]
    return arr[mid]
  elsif arr[mid] == arr[mid + 1]
    return single_in_sorted(arr.drop(mid + 1))
  else
    return single_in_sorted(arr.take(mid))

  end


end
