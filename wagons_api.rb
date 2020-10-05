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
wg["data"].each do |station_id, stations|# перебераем хеш элемента "data"
  #binding.pry
  stations.each do |station|
    station["wagons"].sort.each do |wagon_id, value|
      binding.pry
      puts wagon_id + ':' + value
    end
    puts "\n"
  end
end
MultiJson.load(wg.body)
