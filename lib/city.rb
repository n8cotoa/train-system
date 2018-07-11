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

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def ==(other_city)
    self.name.==(other_city.name)
  end

  def update(attr)
    @name = attr[:name]
    @id = self.id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id};")
  end

  def self.find(id)
    return_object = DB.exec("SELECT * FROM cities WHERE id = #{id};")
    id = return_object.first["id"].to_i
    name = return_object.first["name"]
    city = City.new({:name => name, :id => id})
  end
end
