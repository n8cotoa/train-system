class City
  attr_reader(:id, :name)

  def initialize (attr)
    @id = attr[:id]
    @name = attr[:name]
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each do |city|
      id = city["id"].to_i
      name = city['name']
      cities.push(City.new({:id => id, :name => name}))
    end
    cities
  end

end
