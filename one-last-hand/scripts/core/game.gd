class_name Game
extends RefCounted

var deck: Deck
var trump_card: Card          # the face-up card at the bottom of the deck
var trump_suit: Card.Suit
var player_count: int = 2
var hands: Array = []         # hands[seat] is an Array of Card
var scores: Array[int] = []   # points won by each seat
var table: Array = []         # cards played in the current trick
var table_seats: Array[int] = []
var current: int = 0          # whose turn it is
var last_trick_winner: int = -1

func setup(num_players: int = 2) -> void:
	player_count = num_players
	deck = Deck.new()
	deck.shuffle()
	hands.clear()
	scores.clear()
	table.clear()
	table_seats.clear()
	for i in num_players:
		hands.append([])
		scores.append(0)
	# The bottom card is shown as trump. It stays in the deck and is
	# drawn last, which matches the real game.
	trump_card = deck.cards[0]
	trump_suit = trump_card.suit
	for _round in 3:
		for seat in num_players:
			hands[seat].append(deck.draw())
	current = 0

func play_card(seat: int, hand_index: int) -> void:
	assert(seat == current, "Not this seat's turn")
	var hand: Array = hands[seat]
	var card: Card = hand.pop_at(hand_index)
	table.append(card)
	table_seats.append(seat)
	if table.size() == player_count:
		_resolve_trick()
	else:
		current = (current + 1) % player_count

func _resolve_trick() -> void:
	var win_i: int = Rules.winning_index(table, trump_suit)
	var winner: int = table_seats[win_i]
	var pts: int = 0
	for c in table:
		pts += c.points()
	scores[winner] += pts
	last_trick_winner = winner
	table.clear()
	table_seats.clear()
	# The winner draws first, then the others in seat order.
	if not deck.cards.is_empty():
		for k in player_count:
			var seat: int = (winner + k) % player_count
			hands[seat].append(deck.draw())
	current = winner

func is_over() -> bool:
	if not deck.cards.is_empty() or not table.is_empty():
		return false
	for h in hands:
		if not h.is_empty():
			return false
	return true
