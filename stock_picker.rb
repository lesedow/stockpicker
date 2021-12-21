def stock_picker(stock_prices)
  last_profit = 0
  smallest = [stock_prices[0], 0]
  index = 0 

  stock_prices.reduce([0, 0]) do |days, price|
    if price < smallest[0]
      smallest = [price, index]
    end

    if price - smallest[0] > last_profit
      last_profit = price - smallest[0]
      days = [smallest[1], index]
    end

    index += 1
    days
  end
end

p stock_picker([25, 100, 125, 30, 260, 400])