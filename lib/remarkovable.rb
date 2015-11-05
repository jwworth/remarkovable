class Remarkovable
  attr_accessor :markov_model

  def initialize(string:, prefix_length: 2)

    if string.nil?
      raise ArgumentError, message: 'String cannot be nil'
    elsif !string.rindex(/\.|!|\?/)
      raise ArgumentError, message: 'String must have a terminator'
    end

    build_markov_model(string, prefix_length)
  end

  def speak(custom_key: nil)
    return if @markov_model.nil?

    key = assign_key(custom_key)
    first_pair = key.split
    output = [first_pair.first.capitalize, first_pair.last]

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

  def build_markov_model(string, prefix_length)
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
      add_triad(key: key, match: match) if i < words.size - prefix_length
    end
  end

  def assign_key(custom_key)
    if !custom_key.nil? && @markov_model.include?(custom_key)
      custom_key
    else
      @markov_model.keys.sample
    end
  end

  def add_triad(key:, match:)
    @markov_model[key] = {} unless @markov_model[key]
    @markov_model[key] += [match]
  end
end
