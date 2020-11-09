require_relative '../main.rb'

describe Enumerable do
  describe '#my_each' do
    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3, 4].my_each).to be_a Enumerator
    end

    it 'iterates through a sequence and yields the block' do
      expect([1, 2, 3, 4].my_each { |x| x }).to eql([1, 2, 3, 4])
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3, 4].my_each_with_index).to be_a Enumerator
    end

    it 'iterates through a sequence and yields the block' do
      hash = {}
      expect([1, 2, 3, 4].my_each_with_index { |item, index| hash[item] = index }).to eql([1, 2, 3, 4])
    end
  end

  describe '#my_select' do
    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3, 4].my_select).to be_a Enumerator
    end

    it 'iterates through a sequence and yields the block if block is true' do
      expect([1, 2, 3, 4].my_select { |x| x < 3 }).to eql([1, 2])
    end
  end

  describe '#my_all' do
    it 'if no block is given returns true if all elements of the sequence are true' do
      expect([true, true, 99].my_all?).to eql(true)
    end
    it 'if no block is given returns false if any elements of the sequence are false' do
      expect([true, false, 99].my_all?).to eql(false)
    end
    it 'returns true if block never returns false or nil' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'If a pattern is supplied returns whether the pattern matches for every collection member' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end
end
