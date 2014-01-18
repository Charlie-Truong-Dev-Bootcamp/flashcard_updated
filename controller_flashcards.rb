require_relative 'view_flashcards'
require_relative 'model_flashcards'

class Controller
  
  def initialize(filename)
    @user = User.new
    @deck = Deck.from_file(filename)
    @current_card = nil  
  end

  def play    
    display_initial_card
    input = String.new 

    while input != "quit" && current_card != nil
      input = STDIN.gets.chomp
      case current_card.correct_answer?(input)
      when true
        user.update_total_correct
        UserView.display_miss_count(user)
        deck.add_failed_card(current_card, user.misses_on_current)
        user.reset_missed_on_current
        display_new_card
      when false
        user.update_missed_on_current
        display_same_card if input != "quit"
      end
    end
  
    display_win if input != "quit"
    UserView.display_correct_count(user)
    FailedDeckView.display_failed_cards(deck)
    display_goodbye
  end

  def draw_random_card
    self.current_card = deck.retrieve_random_card
  end

  def display_initial_card
    draw_random_card
    CardView.display_definition(current_card)
  end

  def display_new_card
    display_correct
    draw_random_card
    CardView.display_definition(current_card) if current_card != nil
  end

  def display_same_card
    display_try_again
    CardView.display_definition(current_card)
  end

  private
  attr_reader :deck, :user
  attr_accessor :current_card

  def display_try_again
    puts "\n\nTry again!\n"
  end

  def display_correct
    puts "\n\nCorrect!\n"
  end

  def display_goodbye
    puts "\n\nThanks for playing SCJJ's Fantastic Flashcards Fiasco! Goodbye!"
  end

  def display_win
    puts "\n\nYou are a rock star!"
  end
end

ARGV.any? ? c = Controller.new(ARGV[0]) : c = Controller.new("flashcard_samples.txt")
c.play

