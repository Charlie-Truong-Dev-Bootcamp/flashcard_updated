# Main file for 
require 'csv'
require 'debugger'
module Parser
  def self.parser(file)
    cards = Array.new
    
    # modified. It was looking for " ". Modified to ""
    raw_data = File.read(file).split("\n").delete_if{|word| word == ""}

    start = 0
    while start < raw_data.length
      definition = raw_data[start]
      answer = raw_data[start+1]
      cards.push(Card.new({definition: definition, answer: answer}))
      start += 2
    end
    cards
  end
end

class Card
  attr_reader :definition
  def initialize(data={})
    @definition = data[:definition]
    @answer = data[:answer]
  end

  def correct_answer?(input)
    @answer.downcase == input.downcase
  end
end


class Deck
  attr_reader
  def initialize(cards = [])
    @cards = cards
  end

  def retrieve_random_card
    @cards.shuffle!.pop
  end

  def self.from_file(file)
    cards = Parser::parser(file)
    self.new(cards)
  end
end

