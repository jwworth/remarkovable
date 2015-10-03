class Remarkovable
  attr_accessor :markov_model

  def initialize(string)
    @markov_model = Hash.new { |hash, key| hash[key] = [] }
    word_list = string.split(/([.!?])|\s+/)

    word_list.each_with_index do |word, index|
      pair = [word, word_list[index + 1]].join(' ')
      match = word_list[index + 2]
      add_triad(pair, match) if index < word_list.size - 2
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
