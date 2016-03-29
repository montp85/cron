module Shapeshift

 #https://shapeshift.io/affiliate.html
 PAIRS = {eth_dash: true, xmr_dash: true, eth_maid: true, eth_fct: true}

 require "net/http"
 require "uri"
 require "json"

  def correction
  end

  def ss_ticker pair
    tocall = "https://shapeshift.io/rate/#{pair}"
    puts "Pair: #{pair}"
    return tocall
  end#ticker
  def ss_response tocall

    puts tocall

    uri = URI.parse( tocall )
    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body)

    date =  ( Time.now.to_i ) * 1000
    puts "Date: #{date}"

    fresh = Array.new

    data.each do |k,v|
      unless k == "pair"
        #puts "For FUCKS sake!!!!!!!!! #{v}"
        fresh.push( date )
        fresh.push( ( v ).to_f )
      end
    end

    all = fresh.to_s

    puts "Cur vallue: #{fresh[1]}"

    if fresh[1].to_f > 0.0

          if tocall.include? "eth_dash"
             file = File.open( "ethdash.json", "r")
              content = file.read
               file.close
                  if content.include? "]]"
                   content.sub! ']]', "],#{all}]"
                   puts "Updated content: #{content}"
                  else
                    puts "File has no JSON."
                  end
              file = File.open( "ethdash.json", "w+")
               file.write(content)
                file.close

  

             elsif tocall.include? "eth_fct"
               file = File.open( "ethfct.json", "r")
                content = file.read
                 file.close
                    if content.include? "]]"
                     content.sub! ']]', "],#{all}]"
                     puts "Updated content: #{content}"
                    else
                      puts "File has no JSON."
                    end
                file = File.open( "ethfct.json", "w+")
                 file.write(content)
                  file.close

                elsif tocall.include? "xmr_dash"
                  file = File.open( "xmrdash.json", "r")
                   content = file.read
                    file.close
                       if content.include? "]]"
                        content.sub! ']]', "],#{all}]"
                        puts "Updated content: #{content}"
                       else
                         puts "File has no JSON."
                       end
                   file = File.open( "xmrdash.json", "w+")
                    file.write(content)
                     file.close
          end#inner if
      else
        puts "Value is bogus."
      end#outer if
  end#response
end#shapeshift module
