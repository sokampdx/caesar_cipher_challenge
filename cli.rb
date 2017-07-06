#!/usr/bin/env ruby
require 'optparse'
require './caesar_cipher.rb'

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"
  
  opts.on("-m", "--message MESSAGE", "Message to encrypt, decrypt, or break") do |v|
    options[:message] = v
  end

  opts.on("-e", "--encrypt N", Integer, "Rotation") do |v|
    options[:rotation] = v
    options[:encrypt] = true
  end

  opts.on("-d", "--decrypt [N]", Integer, "Rotation") do |v|
    if v.nil?
      options[:break] = true
    else
      options[:rotation] = v
      options[:decrypt] = true
    end
  end

end.parse!

cipher = Cipher.new

result =
  if options[:encrypt]
    cipher.encrypt(options[:message], options[:rotation])
  elsif options[:decrypt]
    cipher.encrypt(options[:message], options[:rotation])
  elsif options[:break]
    cipher.break(options[:message])
  else
    'see help'
  end

p result
