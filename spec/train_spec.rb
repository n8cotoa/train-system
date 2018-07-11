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
end
