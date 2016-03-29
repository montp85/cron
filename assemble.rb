require './shapeshift.rb'
include Shapeshift
PAIRS.each do |pair, value|
  if value == true
    tocall = ss_ticker( pair )
    ss_response( tocall )
  end
end
puts "End."
