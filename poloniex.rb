module Poloniex

 PAIRS = {BTC_XMR: true, BTC_ETH: true, BTC_BTS: true, BTC_MAID: true, BTC_FCT: true, BTC_DASH: true, BTC_SYS: true, BTC_XCP: true, BTC_PPC: true, BTC_NMC: true}

 require "net/http"
 require "uri"
 require "json"

 def poloniex_parser( pair )
  #pair = "BTC_XMR"
  till = Time.now.to_i
  fro = Time.now.to_i - 1209600
  period = "900"

  till = till.to_s
  fro = fro.to_s
  pair = pair.to_s

  tocall = "https://poloniex.com/public?command=returnChartData&currencyPair=" + pair + "&start=" + fro + "&end=" + till + "&period=" + period

  return tocall
 end

 def poloniex_response( tocall )

  puts "Calling #{ tocall }"

  uri = URI.parse( tocall )
  response = Net::HTTP.get_response(uri)
  data = JSON.parse(response.body)

  outer = Array.new

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

  if tocall.include? "XMR"
   File.open( "xmrbtc.json", "w+") do |f|
    f.puts(all)
   end
  end

  if tocall.include? "ETH"
   File.open( "ethbtc.json", "w+") do |f|
    f.puts(all)
   end
  end

  if tocall.include? "BTS"
   File.open( "btsbtc.json", "w+") do |f|
    f.puts(all)
   end
  end

    if tocall.include? "MAID"
     File.open( "maidbtc.json", "w+") do |f|
      f.puts(all)
     end
    end

      if tocall.include? "FCT"
       File.open( "fctbtc.json", "w+") do |f|
        f.puts(all)
       end
      end

        if tocall.include? "DASH"
         File.open( "dashbtc.json", "w+") do |f|
          f.puts(all)
         end
        end

          if tocall.include? "SYS"
           File.open( "sysbtc.json", "w+") do |f|
            f.puts(all)
           end
          end


            if tocall.include? "XCP"
             File.open( "xcpbtc.json", "w+") do |f|
              f.puts(all)
             end
            end

              if tocall.include? "PPC"
               File.open( "ppcbtc.json", "w+") do |f|
                f.puts(all)
               end
              end

                if tocall.include? "NMC"
                 File.open( "nmcbtc.json", "w+") do |f|
                  f.puts(all)
                 end
                end

 end
end
