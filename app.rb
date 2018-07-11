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

post('/operator/new_train') do
  name = params["train_name"]
  new_train = Train.new({:id => nil, :name => name})
  new_train.save()
  redirect back
end

get('/operator/manage_cities') do
  @cities = City.all
  erb(:manage_cities)
end

post('/operator/new_city') do
  name = params["city_name"]
  new_city = City.new({:id => nil, :name => name})
  new_city.save()
  redirect back
end

get('/operator/train/:id') do
  id = params[:id].to_i
  @train = Train.find(id)
  erb(:train)
end

patch('/operator/train/:id') do
  name = params["name"]
  @train = Train.find(params["id"].to_i)
  @train.update({:name => name})
  @trains = Train.all
  erb(:train)
end

delete('/operator/train/:id') do
  id = params[:id].to_i
  @train = Train.find(id)
  @train.delete
  @trains = Train.all
  erb(:manage_trains)
end

get('/operator/city/:id') do
  id = params[:id].to_i
  @city = City.find(id)
  erb(:city)
end

patch('/operator/city/:id') do
  name = params["name"]
  @city = City.find(params["id"].to_i)
  @city.update({:name => name})
  @cities = City.all
  erb(:city)
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
get('/view_trains') do
  @trains = Train.all
  erb(:view_trains)
end
