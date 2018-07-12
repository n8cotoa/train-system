class City
  attr_reader(:id, :name, :time)

  def initialize (attr)
    @id = attr[:id]
    @name = attr[:name]
    @time = attr.fetch(:time, "")
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
    @name = attr.fetch(:name, @name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id};")

    attr.fetch(:train_ids, []).each do |train_id|
      DB.exec("INSERT INTO stops (city_id, train_id, time) VALUES (#{self.id}, #{train_id});")
    end
  end

  def trains
    city_trains = []
    results = DB.exec("SELECT * FROM stops WHERE city_id = #{self.id};")
    results.each do |result|
      train_id = result.fetch("train_id").to_i
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first.fetch("name")
      time = train.first.fetch("time")
      city_trains.push(Train.new({:name => name, :id => train_id, :time => time}))
    end
    city_trains
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id};")

    DB.exec("DELETE FROM stops WHERE city_id = #{self.id};")
  end

  def self.find(id)
    return_object = DB.exec("SELECT * FROM cities WHERE id = #{id};")
    id = return_object.first["id"].to_i
    name = return_object.first["name"]
    city = City.new({:name => name, :id => id})
  end
end
