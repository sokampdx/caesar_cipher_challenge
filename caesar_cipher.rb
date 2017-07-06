class Cipher
  def load_dict
    list = File.readlines('./words') 
    list.map { |word| word.chomp.downcase if word.length > 5 }
  end

  def encrypt(message, rotation)
    message = message.downcase
    return message if rotation % 26 == 0

    result = ''
    (0...message.length).each do |i|
      current = message[i].ord
      if current >= 'a'.ord && current <= 'z'.ord
        value = message[i].ord + rotation
        value -= 26 if value > 'z'.ord
        result << value.chr
      else
        result << current
      end
    end
    result
  end

  def decrypt(message, rotation)
    encrypt(message, 26 - rotation)
  end

  def find_rotation(message)
    scores = Array.new(26, 0)
    dict = load_dict

    (0..25).each do |i|
      decrypted = decrypt(message, i)
      word_list = Hash.new(1)
      decrypted.split.each { |word| word_list[word] += 1 }
      score = 0

      dict.each do |word|
        word_list.keys.each do |key|
          score += 1 if key == word
        end
      end
      scores[i] = score
    end

    scores.rindex(scores.max)
  end

  def break(message)
    decrypt(message, find_rotation(message))
  end
end
