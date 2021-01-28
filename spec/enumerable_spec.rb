# spec/enumerable_spec.rb

require_relative '../enumerables'

describe Enumerable do
  let(:array) { [2, 5, 6, 11, 70, 4, 22, 68, 31] }
  let(:hash) { { 'dog' => 'bark', 'cat' => 'meow', 'duck' => 'quack', 'pig' => 'oink' } }

  describe '#my_each' do
    it 'iterates through the array ' do
      i = 0
      array.my_each do |v|
        expect(v).to eq(array[i])
        i += 1
      end
    end

    it 'iterates through the hash ' do
      i = 0
      hash.my_each do |key, v|
        expect(v).to eq(hash[key])
        i += 1
      end
    end

    it 'Returns to Enumerator if no block is given' do
      expect(array.my_each.is_a?(Enumerator)).to be true
    end
    it 'Returns to Enumerator if no block is given' do
      expect(hash.my_each.is_a?(Enumerator)).to be true
    end
  end

  describe '#my_each_with_index' do
    it 'iterates through each value and index in an array' do
      i = 0
      array.my_each_with_index do |_value, index|
        expect(index).to eq(i)
        i += 1
      end
    end

    it 'Returns to Enumerator if no block is given' do
      expect(array.my_each_with_index.is_a?(Enumerator)).to be true
    end
  end

  describe '#my_select' do
    it 'selects odd numbers from the array' do
      expect(array.my_select(&:odd?)).to eq([5, 11, 31])
    end

    it 'Returns to Enumerator if no block is given' do
      expect(array.my_select.is_a?(Enumerator)).to be true
    end

    it 'select a key value pair from the hash' do
      expect(hash.my_select { |_key, value| value == 'bark' }).to eq([%w[dog bark]])
    end

    it 'Returns to Enumerator if no block is given' do
      expect(hash.my_select.is_a?(Enumerator)).to be true
    end
  end

  describe '#my_all' do
    it 'returns false if all elements are not odd' do
      expect(array.my_all?(&:odd?)).to eq(false)
    end

    it 'returns true if no block given and no element is false or nil' do
      expect(array.my_all?).to eq(true)
    end
  end

  describe '#my_any' do
    it 'returns true if any value returned by block is true' do
      expect(array.my_any? { |v| v == 5 }).to eq(true)
    end

    it 'check for false element' do
      expect(array.my_any? { |v| v == false }).to eq(false)
    end
  end

  describe '#my_none' do
    it 'returns true if all elements are false' do
      expect(array.my_none? { |v| v.instance_of?(String) }).to eq(true)
    end
  end

  describe '#my_count' do
    it 'counts the number of elements in an array' do
      expect(array.my_count).to eq(9)
    end

    it 'counts the number of even numbers in an array' do
      expect(array.my_count(&:even?)).to eq(6)
    end
  end

  describe '#my_map' do
    it 'Returns the double of each number in an array' do
      expect(array.my_map { |a| a * 2 }).to eql([4, 10, 12, 22, 140, 8, 44, 136, 62])
    end

    it 'it returns to an enumerator if no block is given' do
      expect(array.my_map.is_a?(Enumerator)).to be true
    end
  end

  describe '#my_inject' do
    it 'returns the sum of the numbers in an array' do
      expect(array.my_inject(0) { |sum, n| sum + n }).to eq(219)
    end

    it 'returns the product of the numbers in an array' do
      expect(array.my_inject(1) { |product, n| product * n }).to eq(8_570_284_800)
    end

    it 'returns the sum of the elements in an array' do
      expect(array.my_inject(:+)).to eq(array.inject(:+))
    end

    it 'returns the proper sum that includes the argument' do
      expect(array.my_inject(3, :+)).to eq(array.inject(3, :+))
    end
  end
end
