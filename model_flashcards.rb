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
  attr_reader :definition, :answer
  def initialize(data={})
    @definition = data[:definition]
    @answer = data[:answer]
  end

  def correct_answer?(input)
    @answer.downcase == input.downcase
  end
end


class Deck
  attr_reader :failed_cards
  def initialize(cards = [])
    @cards = cards
    @failed_cards = Array.new
  end

  def retrieve_random_card
    @cards.shuffle!.pop
  end

  def self.from_file(file)
    cards = Parser::parser(file)
    self.new(cards)
  end

  def add_failed_card(card, miss_count)
    @failed_cards.push(card) if miss_count >= 4
  end
end

class User
  attr_reader :misses_on_current, :total_correct
  def initialize
    @misses_on_current = 0
    @total_correct = 0
  end

  def update_missed_on_current
    @misses_on_current += 1
  end

  def reset_missed_on_current
    @misses_on_current = 0
  end

  def update_total_correct
    @total_correct += 1
  end
end