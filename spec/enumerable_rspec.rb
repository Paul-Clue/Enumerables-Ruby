require_relative '../lib/enumerables.rb'

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
    
    
  end
end