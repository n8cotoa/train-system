require 'spec_helper'
require 'rspec'
require 'pry'
require 'train'
require 'pg'

describe(Train) do
  describe(".all") do
    it("will list all instances of Train class") do
      expect(Train.all).to(eq([]))
    end
  end
  describe("#save") do
    it("save instance of train") do
      test_train = Train.new({:id => nil, :name => "A-Train"})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end
  describe("#==") do
    it("will properly compare two identical objects") do
      test_train1 = Train.new({:id => nil, :name => "A-Train"})
      test_train2 = Train.new({:id => nil, :name => "A-Train"})
      test_train1.save()
      test_train2.save()
      expect(test_train1).to(eq(test_train2))
    end
  end
  describe('#update') do
    it('will update item in the database with new info') do
      test_train = Train.new({:id => nil, :name => "A-Train"})
      test_train.save()
      test_train.update({:name => "Soul-Train"})
      expect(test_train.name).to(eq("Soul-Train"))
    end
    it('let user add a city to a train') do
      test_city = City.new({:id => nil, :name => 'Portland'})
      test_city.save()
      test_train = Train.new({:id => nil, :name => "A-Train"})
      test_train.save()
      test_train.update({:city_ids => [test_city.id]})
      expect(test_train.cities).to(eq([test_city]))
    end
  end
  describe('#cities') do
    it('return all cities a particular train goes to') do
      test_city1 = City.new({:id => nil, :name => 'Portland'})
      test_city1.save()
      test_city2 = City.new({:id => nil, :name => 'Beaverton'})
      test_city2.save()
      test_train = Train.new({:id => nil, :name => "A-Train"})
      test_train.save()
      test_train.update({:city_ids => [test_city1.id, test_city2.id]})
      expect(test_train.cities).to(eq([test_city1, test_city2]))
    end
  end
  describe('#delete') do
    it('will delete item in the database') do
      test_train1 = Train.new({:id => nil, :name => "A-Train"})
      test_train2 = Train.new({:id => nil, :name => "B-Train"})
      test_train1.save()
      test_train2.save()
      test_train2.delete()
      expect(Train.all()).to(eq([test_train1]))
    end
  end
  describe('.find') do
    it 'will find an onject by id' do
      test_train = Train.new({:id => nil, :name => "Blue Line"})
      test_train.save
      expect(Train.find(test_train.id)).to(eq(test_train))
    end
  end
end
