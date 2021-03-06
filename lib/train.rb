class Train
  attr_reader(:id, :name, :time)

  def initialize(attr)
    @id = attr[:id]
    @name = attr[:name]
    @time = attr.fetch(:time, "")
  end

  def self.all()
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each do |train|
      id = train["id"].to_i
      name = train["name"]
      trains.push(Train.new({:id => id, :name => name}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def ==(another_train)
    self.name.==(another_train.name)
  end

  def update(attr)
    @name = attr.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id};")

    times = attr.fetch(:times, [])
    index = 0
    attr.fetch(:city_ids, []).each do |city_id|
      DB.exec("INSERT INTO stops (city_id, train_id, time) VALUES (#{city_id}, #{self.id}, '#{times[index]}');")
      index += 1
    end
    index = 0
  end

  def cities
    train_cities = []
    results = DB.exec("SELECT * FROM stops WHERE train_id = #{self.id};")
    results.each do |result|
      city_id = result.fetch("city_id").to_i
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first.fetch("name")
      time = result.fetch("time")
      train_cities.push(City.new({:id => city_id, :name => name, :time => time}))
    end
    train_cities
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{self.id};")

    DB.exec("DELETE FROM stops WHERE train_id = #{self.id};")
  end

  def self.find(id)
    return_object = DB.exec("SELECT * FROM trains WHERE id = #{id};")
    id = return_object.first["id"].to_i
    name = return_object.first["name"]
    train = Train.new({:name => name, :id => id})
  end
end
