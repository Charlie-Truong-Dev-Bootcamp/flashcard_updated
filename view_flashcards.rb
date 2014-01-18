class CardView
  def self.display_definition(card)
    puts definition(card)
  end

  def self.definition(card)
    <<-STRING


#{card.definition}


Answer:
    STRING
  end
end

class UserView
  def self.display_miss_count(user)
    puts "\nYou missed #{user.misses_on_current} times on that question."
  end

  def self.display_correct_count(user)
    puts "\nYou got #{user.total_correct} questions right!"
  end
end

class FailedDeckView
  def self.display_failed_cards(deck)
    puts "\nYou missed the below questions several times."
    puts "It would serve you well to review these concepts:"
    puts self.create_list(deck)
  end

  def self.create_list(deck)
    str = String.new
    deck.failed_cards.each do |card|
      str << "-#{card.answer}\n"
    end
    str
  end
end