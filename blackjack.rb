# Create a deck of cards
#Create method that allows you to deal cards
#Create card hand method for player and dealer
#Create a method to add up cards in hand
#Sort cards into an array containing their true values in order to add them up.
#Create a method to determine the winner
    #if player goes over 21 : busts- player loses!
  #elsif if player = 21 : blackjack
    #if player and comp = blackjack : tie
      #else player wins
  #elsif comp = blackjack and player not = bust comp wins!
require 'pry'

def initialize_deck
  cards = ['Ace',"2","3","4","5","6","7","8","9","10","Jack","Queen","King"]
  suits = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  deck = cards.product(suits)
  deck.shuffle
end

def values(players_cards)
  card_value = []
  players_cards.reject {|cards| card_value << cards[0]}
  card_value
end

def card_total(values)
  values.inject(0) do |sum,v|
    if v == "Ace"
      v = 11
    elsif v.to_i == 0
      v = 10
    else
      v = v.to_i
    end
  sum= sum.to_i + v.to_i
  end
end

def display_totals(dealer_total,player_total)
  puts "Player's Total = #{player_total}"
  puts "Dealer's Total = #{dealer_total}"
end

def deal(deck)
  card = deck.pop
end

def display_dealer(dealer)
  puts "Dealers Hand"
  puts "=========================="    
    dealer.each do |card|
      puts   "#{card[0]} of #{card[1]}"
    end
  puts "=========================="     
  puts ''                   
  puts ''                                  
end    

def display_player(player,name)  
  puts "#{name}'s Hand"
  puts "=========================="    
    player.each do |card|
      puts "#{card[0]} of #{card[1]}"
  end
  puts "==========================" 
  puts ''    
  puts ''                                  
end  

def ace?(dealer_player)
  values(dealer_player).include?('Ace')
end 

def ace_count(player)
  ace = values(player).select {|value| value == 'Ace'}.count 
end

def winner(dealer_total, player_total, dealer,player,name)
  if (player_total > 21 || dealer_total > 21) && (ace?(player) || ace?(dealer))
    player_ace = ace_count(player)
    dealer_ace = ace_count(dealer)

    until player_ace == 0 || player_total <=21 
      player_total -= 10
      player_ace -=1
    end

    until dealer_ace == 0 || dealer_total <= 21
      dealer_total -= 10
      dealer_ace -=1
    end
  end

  display_totals(dealer_total,player_total)

  if player_total > 21 
    puts "#{name} Busted"
    puts "#{name} Loses!"
  end
  if player_total <=21 && dealer_total <= 21
    if player_total == 21 
      if player_total == 21 && dealer_total == 21
        puts "It's a tie!"
      else
        puts "Blackjack!"
        puts "#{name} Wins!"
      end
    
  elsif player_total == dealer_total
    puts "It's a Tie!"
  elsif player_total > dealer_total
    puts "#{name} Win!"
  elsif dealer_total > player_total
    puts "#{name} Loses!"
    puts "Better luck next time!"
  end
end
  if player_total <= 21 && dealer_total > 21
    puts "Dealer Busted!"
    puts "#{name} Wins!"
  end
end  

deck = initialize_deck
play_again = 'Y'
name = ''
while name == ''
  puts "What's your name?"
  name = gets.chomp
  
  while play_again == 'Y'
    puts "Lets play BlackJack #{name}!"
    player = []
    dealer = []
    deck = initialize_deck
  #DEAL INITIAL HAND 
    player << deal(deck)
    dealer << deal(deck)
    player << deal(deck)
    dealer << deal(deck)

  #DISPLAYS INITIAL HAND
    display_dealer(dealer) 
    display_player(player,name)
    
    choice = ''
    #PLAYER's TURN

    until choice == 'S'
      puts "Would you like to hit or stay?(H/S)"
      choice = gets.chomp.upcase
      system "cls"
      if choice == 'H'
        player << deal(deck)
        display_player(player,name)
        display_dealer(dealer)
      end
      player_total = card_total(values(player))
    end
    
    #DEALER's TURN   
    until card_total(values(dealer)) >=17
      dealer << deal(deck)
      display_player(player,name)
      display_dealer(dealer)
      dealer_total = card_total(values(dealer))
    end

    # CALCULATES TOTAL AND DISPLAYS WINNER
    dealer_total = card_total(values(dealer))
    winner(dealer_total,player_total,dealer,player,name)
    #OPTION TO PLAY AGAIN
    puts "play again?"
    play_again = gets.chomp.upcase
    
    if play_again == 'N'
        break
      end
  end
end
 






