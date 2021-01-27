#spec/enumerable_spec.rb

require_relative '../enumerables.rb'

describe Enumerable do
  let(:array) {[2, 5, 6, 11, 70, 4, 22, 68, 31]}
  let(:hash) {{'dog' => 'bark', 'cat'=> 'meow', 'duck'=> 'quack', 'pig' => 'oink'}}

  describe '#my_each' do
    it 'iterates through the array ' do
      i = 0
      array.my_each do |v|
      expect(v).to eq(array[i])
      i+=1
      end
    end 
    
    it 'iterates through the hash ' do
      i = 0
      hash.my_each do |key, v|
      expect(v).to eq(hash[key])
      i+=1
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
      i=0
      array.my_each_with_index do |value, index|
        expect(index).to eq(i)
      i+=1
      end  
    end  

    it 'Returns to Enumerator if no block is given' do
      expect(array.my_each_with_index.is_a?(Enumerator)).to be true
    end
  end

  describe '#my_select' do
    it 'selects odd numbers from the array' do
      expect(array.my_select(&:odd?)).to eq([5,11, 31])
    end

    it 'Returns to Enumerator if no block is given' do
      expect(array.my_select.is_a?(Enumerator)).to be true
    end

    it 'select a key value pair from the hash' do
      expect(hash.my_select { |key, value| value == 'bark' }).to eq([['dog', 'bark']])
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
      expect(array.my_any? {|v| v == 5}).to eq(true)
    end 
  end

  describe '#my_none' do
    it 'returns true if all elements are false' do
      expect(array.my_none? {|v| v.instance_of?(String)}).to eq(true)
    end   
  end
end
