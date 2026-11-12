class_name Deck
extends RefCounted

var cards: Array[Card] = []

func _init() -> void:
	for s in Card.Suit.values():
		for r in Card.Rank.values():
			cards.append(Card.new(s, r))

func shuffle() -> void:
	cards.shuffle()

func draw() -> Card:
	if cards.is_empty():
		return null
	return cards.pop_back()
