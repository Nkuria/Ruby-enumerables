require '../main.rb'

describe Enumerable do
  
  describe "#my_each" do 
    it "returns an enumerator if no block is given" do
      expect([1,2,3,4].my_each).to be_a Enumerator
    end

    it "iterates through a sequence and yields the block" do
      expect([1,2,3,4].my_each {|x| x}).to eql([1, 2, 3, 4])
    end
  end

  describe "#my_each_with_index" do 
    it "returns an enumerator if no block is given" do
      expect([1,2,3,4].my_each_with_index).to be_a Enumerator
    end

    it "iterates through a sequence and yields the block" do
      hash = Hash.new
      expect([1,2,3,4].each_with_index { |item, index| hash[item] = index}).to eql([1,2,3,4])
    end
  end

  describe "#my_each_with_index" do 
    it "returns an enumerator if no block is given" do
      expect([1,2,3,4].my_each_with_index).to be_a Enumerator
    end

    it "iterates through a sequence and yields the block" do
      hash = Hash.new
      expect([1,2,3,4].each_with_index { |item, index| hash[item] = index}).to eql([1,2,3,4])
    end
  end


end
