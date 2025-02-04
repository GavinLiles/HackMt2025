extends Line2D

 #Define colors for each player
var player_colors = {
	1: Color(1, 0, 0),  # Red for Player 1
	2: Color(0, 1, 0),  # Green for Player 2
	3: Color(0, 0, 1),  # Blue for Player 3
	4: Color(1, 1, 0)   # Yellow for Player 4
}

func change_player(player_id):
	if player_id in player_colors:
		default_color = player_colors[player_id]  # Change arrow color
	else:
		default_color = Color(1, 1, 1)  # Default to white if undefined
