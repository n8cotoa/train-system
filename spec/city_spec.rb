require 'rspec'
require 'pry'
require 'city'
require 'spec_helper'
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

end
