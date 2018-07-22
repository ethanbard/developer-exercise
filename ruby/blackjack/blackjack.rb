class Card
  attr_accessor :suit, :name, :value

  def initialize(suit, name, value)
    @suit, @name, @value = suit, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITS = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITS.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end
end

deck = Deck.new
player = Hand.new
dealer = Hand.new

player_stands = false
puts "Welcome to Blackjack"

player.cards.push(deck.deal_card)
player.cards.push(deck.deal_card)

dealer.cards.push(deck.deal_card)
dealer.cards.push(deck.deal_card)

puts "Dealer's hand:"
puts "[#{dealer.cards[0].name} of #{dealer.cards[0].suit}]"
puts "[#{dealer.cards[1].name} of #{dealer.cards[1].suit}]"

player_score = 0

until player_stands
  #Display the current hands for both the player and the dealer
  puts "Your current hand:"
  
  i = 0
  player_score = 0
  while i < player.cards.length
    puts "[#{player.cards[i].name} of #{player.cards[i].suit}]"
    player_score += player.cards[i].value
    i += 1
  end

  puts ""
  #if the player busts on hit
  if player_score > 21
    player_stands = true
  else
    #Ask if the player wants to hit or stand
    puts "Do you want to Hit (H) or Stand (S)?"
    option = gets.chop
    
    if option == "H" || option == "h"
      player.cards.push(deck.deal_card)
    else
      player_stands = true
    end
  end
end

#The Dealer now plays
dealer_score = 0
dealer_stands = false
until dealer_stands
  
  i = 0
  dealer_score = 0
  while i < dealer.cards.length
    dealer_score += dealer.cards[i].value
    i += 1
  end

  if dealer_score < 17
    dealer.cards.push(deck.deal_card)
  else
    dealer_stands = true
  end
end

#Display the dealer's cards
puts "Dealer's hand:"

i = 0
while i < dealer.cards.length
  puts "[#{dealer.cards[i].name} of #{dealer.cards[i].suit}]"
  i += 1
end

puts ""
#Check the score
if player.cards[0].name == "ace" && player.cards[1].value == 10
  puts "Player Blackjacks"
elsif player_score > 21
  puts "Player Busts"
elsif dealer_score > 21
  puts "Dealer Busts"
elsif player_score > dealer_score && dealer_score >= 17
  puts "Player Wins"
elsif player_score < dealer_score && dealer_score >= 17
  puts "Dealer Wins"
end

puts "Thank you for playing!"

require 'test/unit'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end
  
  def test_card_suit_is_correct
    assert_equal @card.suit, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end
  
  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end
  
  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    assert(@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end