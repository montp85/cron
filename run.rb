require './poloniex.rb'
include Poloniex
PAIRS.each do |pair, value|
  if value == true 
    tocall = poloniex_parser( pair )
    poloniex_response( tocall )
#    puts "Done #{ pair }"
  end
end
puts "End."
