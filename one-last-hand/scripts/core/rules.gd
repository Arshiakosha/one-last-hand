class_name Rules
extends RefCounted

# Given the cards played this trick in order (first card = the lead),
# returns the index of the winning card.
static func winning_index(played: Array, trump: Card.Suit) -> int:
	var best: int = 0
	for i in range(1, played.size()):
		var c: Card = played[i]
		var b: Card = played[best]
		if c.suit == b.suit:
			if c.rank > b.rank:
				best = i
		elif c.suit == trump:
			best = i
	return best
