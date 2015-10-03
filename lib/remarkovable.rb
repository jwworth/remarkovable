class Remarkovable
  attr_accessor :markov_model

  def initialize(string, prefix_length = 2)
    @markov_model = Hash.new { |hash, key| hash[key] = [] }

    words = string.split(/([.!?])|\s+/)

    words.each_with_index do |word, i|
      pair = [word]
      (prefix_length - 1).times do |n|
        next_word = i + n + 1
        pair << words[next_word]
      end
      pair = pair.join(' ')
      match = words[i + prefix_length]
      add_triad(pair, match) if i < words.size - prefix_length
    end
  end

  def speak
    pair = @markov_model.keys.sample
    output = [] << pair.capitalize.split(' ')

    until (output & %w(. ! ?)).any?
      match = @markov_model[pair].sample
      if match.nil?
        pair = @markov_model.keys.sample
        next
      end
      output << match
      output.flatten!
      pair = [output[-2], output[-1]].join(' ')
    end

    output.join(' ').gsub(/\s+([,.!?])/, '\1')
  end

  private

  def add_triad(pair, match)
    @markov_model[pair] = {} unless @markov_model[pair]
    @markov_model[pair] += [match]
  end
end
