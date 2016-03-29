require "net/http"
require "uri"
require "json"

pair = "BTC_XMR"
till = Time.now.to_i
#6 hod = 21600
#24 hod = 86400
# week = 604800
fro = Time.now.to_i - 604800
period = "900"

till = till.to_s
fro = fro.to_s

tocall = "https://poloniex.com/public?command=returnChartData&currencyPair=" + pair + "&start=" + fro + "&end=" + till + "&period=" + period

puts tocall

uri = URI.parse( tocall )
response = Net::HTTP.get_response(uri)
data = JSON.parse(response.body)

#empty_table = Array.new(3) { Array.new(3) }
outer = Array.new

#puts data
data.each do |item|
 inner = Array.new
 inner.push(item['date'].to_i * 1000)
 inner.push(item['open'])
 inner.push(item['high'])
 inner.push(item['low'])
 inner.push(item['close'])
 outer.push(inner)
end

all = outer.to_json

File.open("polo.json", "w+") do |f|
  f.puts(all)
end
