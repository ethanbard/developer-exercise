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
#******************************************
#************MY BLACKJACK CLASS************
#******************************************
class Blackjack
  def initialize
    @deck = Deck.new
    @player = Hand.new
    @dealer = Hand.new

    @player_score = 0
    @dealer_score = 0
  end

  def display_player_hand
    #Display the current hand for player
    puts "Your current hand:"
    
    i = 0
    while i < @player.cards.length
      puts "[#{@player.cards[i].name} of #{@player.cards[i].suit}]"
      i += 1
    end
  end

  def display_dealer_hand
    #Display the dealer's cards
    puts "Dealer's hand:"

    i = 0
    while i < @dealer.cards.length
      puts "[#{@dealer.cards[i].name} of #{@dealer.cards[i].suit}]"
      i += 1
    end
  end

  def deal_cards
    #The player gets two cards and the dealer gets one
    @player.cards.push(@deck.deal_card)
    @player.cards.push(@deck.deal_card)

    @dealer.cards.push(@deck.deal_card)
  end

  def player_score
    i = 0
    score = 0
    while i < @player.cards.length
      score += @player.cards[i].value
      i += 1
    end
    score
  end

  def dealer_score
    i = 0
    score = 0
    while i < @dealer.cards.length
      score += @dealer.cards[i].value
      i += 1
    end
    score
  end

  def start_game
    player_stands = false
    deal_cards

    puts "Welcome to Blackjack"
    puts ""
    
    display_dealer_hand
    puts ""
    #The player gets blackjack if dealt an ace and a 10-point-card
    if (@player.cards[0].name == :ace && @player.cards[1].value == 10) || (@player.cards[0].value == 10 && @player.cards[1].name == :ace)
      puts "Player Blackjacks"
    else
      until player_stands
        #Display the current hand for player
        display_player_hand
        puts ""

        #If the player busts on hit
        if player_score > 21
          player_stands = true
        else
          #Ask if the player wants to hit or stand
          puts "Do you want to Hit (H) or Stand (S)?"
          option = gets.chop
        
          if option == "H" || option == "h"
            @player.cards.push(@deck.deal_card)
          else
            player_stands = true
          end
        end
      end
    end
    
    #The Dealer now plays
    dealer_stands = false
    until dealer_stands
      if dealer_score < 17
        @dealer.cards.push(@deck.deal_card)
      else
        dealer_stands = true
      end
    end
    
    #Display the dealer's cards
    display_dealer_hand
    puts ""

    check_score
  end

  def check_score
    #Calculate the scores
    @player_score = player_score
    @dealer_score = dealer_score

    #Check the score
    if (@dealer.cards[0].name == :ace && @dealer.cards[1].value == 10) || (@dealer.cards[0].value == 10 && @dealer.cards[1].name == :ace)
      puts "Dealer Blackjacks"
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
  end
end

#Create a new instance of the Blackjack class and start the game
new_game = Blackjack.new
new_game.start_game

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