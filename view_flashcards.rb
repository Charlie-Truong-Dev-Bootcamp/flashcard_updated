class CardView
  def display_definition(card)
    puts definition(card)
  end

  def definition(card)
    <<-STRING


#{card.definition}


Answer:
    STRING
  end

end
