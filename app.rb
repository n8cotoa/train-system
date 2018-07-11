require('sinatra')
require("sinatra/reloader")
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname => "train_system_test"})

get('/') do
  erb(:index)
end

get('/operator') do
  @trains = Train.all
  @cities = City.all
  erb(:operator)
end

post('/operator/new_train') do
  name = params["train_name"]
  new_train = Train.new({:id => nil, :name => name})
  new_train.save()
  redirect back
end
post('/operator/new_city') do
  name = params["city_name"]
  new_city = City.new({:id => nil, :name => name})
  new_city.save()
  redirect back
end

get('/operator/train/:id') do
  Train.all()
  id = params[:id].to_i
  results = DB.exec("SELECT * FROM trains WHERE id = #{id};")
  @train = results.first()
  binding.pry
  erb(:trains)
end
