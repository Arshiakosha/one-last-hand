extends Node

func _ready() -> void:
	var bad_games := 0
	for n in 1000:
		var game := Game.new()
		game.setup(2)
		while not game.is_over():
			var seat: int = game.current
			var hand: Array = game.hands[seat]
			var idx: int = randi() % hand.size()
			game.play_card(seat, idx)
		var total: int = 0
		for s in game.scores:
			total += s
		if total != 120:
			bad_games += 1
		if n == 0:
			print("Sample game: ", game.scores, "  trump was ", game.trump_card)
	print("1000 games played. Games not totaling 120: ", bad_games)
