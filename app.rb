require('sinatra')
require("sinatra/reloader")
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('./lib/login')
require('pg')
require('pry')

DB = PG.connect({:dbname => "train_system_test"})

get('/') do
  erb(:index)
end

get('/operator_login') do
  erb(:operator_login)
end

get('/operator') do
  @trains = Train.all
  @cities = City.all
  erb(:operator)
end

post('/operator') do
  email = params["email"]
  pass = params["password"]
  user = Login.new({:email => email, :password => pass})
  if user.login?
    @trains = Train.all
    @cities = City.all
    erb(:operator)
  else
    erb(:operator_login)
  end
end

get('/operator/manage_trains') do
  @trains = Train.all
  erb(:manage_trains)
end

post('/operator/manage_trains') do
  name = params["train_name"]
  if name == ""
    @trains = Train.all
    erb(:manage_trains_fail)
  else
    new_train = Train.new({:id => nil, :name => name})
    new_train.save()
    @trains = Train.all
    erb(:manage_trains)
  end
end

get('/operator/manage_cities') do
  @cities = City.all
  erb(:manage_cities)
end

post('/operator/manage_cities') do
  name = params["city_name"]
  if name == ""
    @cities = City.all
    erb(:manage_cities_fail)
  else
    new_city = City.new({:id => nil, :name => name})
    new_city.save()
    @cities = City.all
    erb(:manage_cities)
  end
end

get('/operator/train/:id') do
  id = params[:id].to_i
  @train = Train.find(id)
  @cities = City.all
  erb(:train)
end

post('/operator/train/:id') do
  @train = Train.find(params["id"].to_i)
  city_ids = params["city_ids"]
  times = params["times"]
  if city_ids == []
    @cities = City.all
    erb(:train)
  else
    @train.update({:city_ids => city_ids, :times => times})
    @cities = City.all
    erb(:train)
  end
end

patch('/operator/train/:id') do
  name = params["name"]
  if name == ""
    @train = Train.find(params["id"].to_i)
    @cities = City.all
    erb(:train_fail)
  else
    @train = Train.find(params["id"].to_i)
    @train.update({:name => name})
    @cities = City.all
    erb(:train)
  end
end

delete('/operator/train/:id') do
  id = params[:id].to_i
  @train = Train.find(id)
  @train.delete
  @trains = Train.all
  @cities = City.all
  erb(:manage_trains)
end

get('/operator/city/:id') do
  id = params[:id].to_i
  @city = City.find(id)
  erb(:city)
end

patch('/operator/city/:id') do
  name = params["name"]
  if name == ""
    @city = City.find(params["id"].to_i)
    @cities = City.all
    erb(:city_fail)
  else
    @city = City.find(params["id"].to_i)
    @city.update({:name => name})
    @cities = City.all
    erb(:city)
  end
end

delete('/operator/city/:id') do
  id = params[:id].to_i
  @city = City.find(id)
  @city.delete
  @cities = City.all
  erb(:manage_cities)
end

get('/view_cities') do
  @cities = City.all
  erb(:view_cities)
end

get('/view_cities/:id') do
  id = params[:id].to_i
  @city = City.find(id)
  @cities = City.all
  erb(:view_city)
end

get('/view_trains') do
  @trains = Train.all
  erb(:view_trains)
end

get('/view_trains/:id') do
  id = params[:id].to_i
  @train = Train.find(id)
  @trains = Train.all
  erb(:view_train)
end
