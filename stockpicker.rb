def get_minmax (days)
  min, max = days.minmax
  min_index = days.index(min)
  max_index = days.index(max)
  minmax = {
    min: {
      index: min_index,
      value: min
    },
    max: {
      index: max_index,
      value: max
    }
  }
end

def stockpicker (days)
  days_pairs = []
  days_clone = days.clone
  
  # Get the smallest and the biggest number in the array
  minmax = get_minmax(days_clone)


  #If the biggest number is at the index 0
  # or the smallest is at the end then slice them off
  if minmax[:min][:index] == days_clone.length - 1
    days_clone.delete_at(minmax[:min][:index])
    minmax = get_minmax(days_clone)
  elsif minmax[:max][:index] == 0
    days_clone.delete_at(minmax[:max][:index])
    minmax = get_minmax(days_clone)
  end

  # If the smallest number has an index bigger than the biggst number
  # then slice the array in half: the first half ranges from the
  # second smallest number to the biggest number, and the second half
  # ranges from the smallest number to the second biggest number

  # Get the minmax of both halves and push them into the days pairs array
  # and sort them by profit 

  # If the smallest doesnt have an index bigger than the biggest number
  # then just get the min max and put it in the days pairs array

  # Lastly return the index of the smallest and the biggest number
  if minmax[:min][:index] > minmax[:max][:index]
    first_half = days_clone.slice(0, minmax[:max][:index] + 1)
    second_half = days_clone.slice(minmax[:min][:index]..)
    
    days_pairs << first_half.minmax
    days_pairs << second_half.minmax
    days_pairs.sort! do |a, b|
      first_profit = a[1] - a[0]
      second_profit = b[1] - b[0]
  
      if first_profit > second_profit
        -1
      else
        1
      end
    end
  
  else
    days_pairs << days_clone.minmax
  end

  [days.index(days_pairs[0][0]), days.index(days_pairs[0][1])]

end

days = [5, 2, 3, 24, 3, 1, 19, 20]
p stockpicker(days) # [1, 3] -> 24 - 2 = 22$ 
