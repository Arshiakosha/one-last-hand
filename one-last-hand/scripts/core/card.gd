class_name Card
extends RefCounted

enum Suit { COINS, CUPS, SWORDS, CLUBS }
# Weakest to strongest, so a higher number beats a lower one.
enum Rank { TWO, FOUR, FIVE, SIX, SEVEN, JACK, KNIGHT, KING, THREE, ACE }

const POINTS := {
	Rank.ACE: 11, Rank.THREE: 10, Rank.KING: 4,
	Rank.KNIGHT: 3, Rank.JACK: 2,
}

var suit: Suit
var rank: Rank

func _init(s: Suit, r: Rank) -> void:
	suit = s
	rank = r

func points() -> int:
	return POINTS.get(rank, 0)

func _to_string() -> String:
	return "%s of %s" % [Rank.keys()[rank], Suit.keys()[suit]]
