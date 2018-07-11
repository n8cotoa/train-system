class Train
  attr_reader(:id, :name)

  def initialize(attr)
    @id = attr[:id]
    @name = attr[:name]
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

end
