require 'spec_helper'
require 'rspec'
require 'pry'
require 'city'
require 'pg'

describe(City) do
  describe('#all') do
    it "will display all values of city class" do
      expect(City.all).to(eq([]))
    end
  end

  describe("#save") do
    it "will save objects to the database" do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save
      expect(City.all).to(eq([test_city]))
    end
  end

  describe("#==") do
    it "will compare two matching objects and make them equal" do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city2 = City.new({:id => nil, :name => "Portland"})
      test_city.save
      test_city2.save
      expect(test_city).to(eq(test_city2))
    end
  end

  describe("#update") do
    it "will update the name of the city" do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save
      test_city.update({:name => "Vancouver"})
      expect(test_city.name).to(eq("Vancouver"))
    end
    it('lets you add train to a city') do
      city = City.new({:id => nil, :name => 'Portland'})
      city.save()
      train1 = Train.new({:id => nil, :name => 'Blue Line'})
      train1.save()
      train2 = Train.new({:id => nil, :name => 'Red Line'})
      train2.save()
      city.update({:train_ids => [train1.id, train2.id]})
      expect(city.trains).to(eq([train1, train2]))
    end
  end
  describe('#trains') do
    it('returns all trains in a particular city') do
      city = City.new({:id => nil, :name => 'Portland'})
      city.save()
      train1 = Train.new({:id => nil, :name => 'Blue Line'})
      train1.save()
      train2 = Train.new({:id => nil, :name => 'Red Line'})
      train2.save()
      city.update({:train_ids => [train1.id, train2.id]})
      expect(city.trains).to(eq([train1, train2]))
    end
  end
  describe("#delete") do
    it "will delete a row from the cities table" do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city2 = City.new({:id => nil, :name => "Vancouver"})
      test_city.save
      test_city2.save
      test_city.delete
      expect(City.all).to(eq([test_city2]))
    end
  end
  describe('.find') do
    it 'will find an onject by id' do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save
      expect(City.find(test_city.id)).to(eq(test_city))
    end
  end
end
