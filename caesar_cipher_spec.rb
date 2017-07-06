require 'rspec'
require './caesar_cipher'

describe Cipher do
  let(:cipher) { Cipher.new }
  let(:message) { 'In cryptography, a Caesar cipher, also known as Caesar\'s cipher, the shift cipher, Caesar\'s code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be replaced by A, E would become B, and so on. The method is named after Julius Caesar, who used it in his private correspondence.' }

  context '.encrypt' do
    it 'return same string with 0 rotation' do
      message = 'abcxyz'
      expect(cipher.encrypt(message, 0)).to eq(message)
    end

    it 'return correct string with rotation' do
      expect(cipher.encrypt('a', 1)).to eq('b')
      expect(cipher.encrypt('z', 1)).to eq('a')
      expect(cipher.encrypt('a', 27)).to eq('b')
      expect(cipher.encrypt('a', 13)).to eq('n')
    end

    it 'return lower case before encrypting' do
      expect(cipher.encrypt('Hello World', 0)).to eq('hello world')
    end

    it 'preserves non-alphbet' do
      expect(cipher.encrypt('Hell0 World!', 0)).to eq('hell0 world!')
    end
  end 

  context '.decrypt' do
    it 'return the original string with 0 rotation' do
      message = 'abcxyz'
      expect(cipher.decrypt(message, 0)).to eq(message)
    end

    it 'return the original string with rotation' do
      expect(cipher.decrypt('a', 1)).to eq('z')
      expect(cipher.decrypt('n', 13)).to eq('a')
    end

    it 'returns original message when descrypt the encrypted' do
      expect(cipher.decrypt(cipher.encrypt(message, 13), 13)).to eq(message.downcase)
    end
  end

  context '.find_rotation' do 
    let(:rotation) { 21 }
    let(:encrypted) { cipher.encrypt(message, rotation) }

    it 'returns max match roataion' do
      allow(cipher).to receive(:load_dict).and_return(message.downcase.split.uniq)
      expect(cipher.find_rotation(encrypted)).to eq(rotation)
    end
  end


  context '.break' do
    let(:rotation) { 13 }
    let(:encrypted) { cipher.encrypt(message, rotation) }

    it 'returns the decrpyted message' do
      allow(cipher).to receive(:find_rotation).and_return(rotation)
      expect(cipher.break(encrypted)).to eq(message.downcase)

      allow(cipher).to receive(:find_rotation).and_return(0)
      expect(cipher.break(message)).to eq(message.downcase)
    end
  end
end
