require_relative '../main'

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

  describe '#my_any' do
    it 'returns true if no block is given and atleast one of the collection member is not false' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'returns true if f the block ever returns a value other than false or nil' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it 'returns true if the pattern matches any of the element in the collection' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end
  end

  describe '#my_none' do
    it 'If the block is not given, will return true only if none of the collection members is true.' do
      expect([nil, false, true].my_none?).to eql(false)
    end

    it 'returns true if the block never returns true for all elements' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'returns true if the pattern matches none of the element in the collection' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end
  end

  describe '#my_count' do
    it 'will return the length of the collection if no block is given' do
      expect([1, 2, 4, 2].my_count).to eql(4)
    end

    it 'returns the number of items in enum through enumeration' do
      expect([1, 2, 4, 2].my_count { |x| x < 4 }).to eql(3)
    end

    it 'If an argument is given, the number of items in enum that are equal to item are counted' do
      expect([1, 2, 4, 2].my_count(2)).to eql(2)
    end
  end
end
