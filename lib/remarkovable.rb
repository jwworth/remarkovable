class Remarkovable
  attr_accessor :markov_model

  def initialize(string, prefix_length = 2)
    return if string.nil?
    @markov_model = Hash.new { |hash, key| hash[key] = [] }

    words = string.split(/([.!?])|\s+/)

    words.each_with_index do |word, i|
      key = [word]

      (prefix_length - 1).times do |n|
        next_word = i + n + 1
        key << words[next_word]
      end

      key = key.join(' ')
      match = words[i + prefix_length]
      add_triad(key, match) if i < words.size - prefix_length
    end
  end

  def speak(custom_key = nil)
    return if @markov_model.nil?
    key = if !custom_key.nil? && @markov_model[custom_key].any?
      custom_key
    else
      @markov_model.keys.sample
    end
    output = [] << key.capitalize.split(' ')

    until (output & %w(. ! ?)).any?
      match = @markov_model[key].sample
      if match.nil?
        key = @markov_model.keys.sample
        next
      end
      output << match
      output.flatten!
      key = [output[-2], output[-1]].join(' ')
    end

    output.join(' ').gsub(/\s+([,.!?])/, '\1')
  end

  private

  def add_triad(pair, match)
    @markov_model[pair] = {} unless @markov_model[pair]
    @markov_model[pair] += [match]
  end
end
