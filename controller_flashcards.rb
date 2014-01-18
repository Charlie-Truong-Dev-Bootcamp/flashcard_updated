require_relative 'view_flashcards'
require_relative 'model_flashcards'

class Controller
  
  def initialize(filename)
    @deck = Deck.from_file(filename)
    @current_card = nil  
    @cardview = CardView.new
  end

  def play    
    display_initial_card
    input = String.new 

    while input != "quit" && @current_card != nil
      input = gets.chomp
      case current_card.correct_answer?(input)
      when true then display_new_card
      when false then display_same_card if input != "quit"
      end
    end
  
    display_win if input != "quit"
    display_goodbye
  end

  


  def draw_random_card
    self.current_card = deck.retrieve_random_card
  end

  def display_initial_card
    draw_random_card
    cardview.display_definition(@current_card)
  end

  def display_new_card
    display_correct
    draw_random_card
    cardview.display_definition(@current_card) if @current_card != nil
  end

  def display_same_card
    display_try_again
    cardview.display_definition(@current_card)
  end

  private
  attr_reader :cardview, :deck
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

c = Controller.new("alternative_deck.txt")
c.play


