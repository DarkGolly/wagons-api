require 'rubygems'
require 'httparty'
require 'multi_json'
require 'pry'

class MicrourbRest
  include HTTParty
  base_uri 'http://45.89.225.49:9999/api/stations/v1.0'

  def wagons (i)
    self.class.get("/#{i}/wagons") #47
  end
end


wg = MicrourbRest.new.wagons(119) #это хеш который содержит два элемента один из которых хеш и содержит в себе массив в котором хеш, и один из элементов
                                  #тоже хеш и этот хеш является хешом состояния вагонов
fileHtml = File.new("fred.html", "w+")
fileHtml.puts "<HTML><BODY>"


wg["data"].each do |station_id, stations|# перебераем хеш элемента "data"
  #binding.pry
  stations.each do |station|
    items = []
    station["wagons"].sort.each do |wagon_id, value|
      #binding.pry
      puts wagon_id + ':' + value

      color = if value == "low"
        "#34C759"
      elsif value == "medium"
        "#FFCC00"
      elsif value == "mediumHigh"
        "#FF9500"
      elsif value == "high"
        "#FF3B30"
      else
        "#6D7885"
      end

      path_tag = if wagon_id == "1"
       "<path fill=\"#{color}\" fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M35.5349 0H3.907L2.28882e-05 9.11628V11.7209H35.5349V0ZM6.18607 1.95349V7.48837H1.95351L4.23258 1.95349H6.18607ZM35.5349 12.6978H0V14.0001H35.5349V12.6978ZM7.99999 2H13V5H7.99999V2ZM20 2H15V5H20V2ZM22 2H27V5H22V2ZM34 2H29V5H34V2Z\"/>"
      else
        "<path fill=\"#{color}\" fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M35.5349 0H2.28882e-05V9.11628V11.7209H35.5349V0ZM0 12.6978H35.5349V14.0001H0V12.6978ZM13 2H7.99999V5H13V2ZM15 2H20V5H15V2ZM27 2H22V5H27V2ZM29 2H34V5H29V2ZM5.99999 2H0.999992V5H5.99999V2Z\"/>"
      end
        items << "<svg width=\"36\" height=\"14\" viewBox=\"0 0 36 14\" xmlns=\"http://www.w3.org/2000/svg\">#{path_tag}</svg>"
    end
    puts "\n"
    wagon_html = items.join("\n") + "<br>"
    fileHtml.puts wagon_html
    puts items
    puts "\n"
  end
end
fileHtml.puts "</BODY></HTML>"
fileHtml.close()
