extends GridContainer


var player_list_with_pos = []
@onready var line_edit: LineEdit = $MarginContainer/LeaderboardPanelContainer/LeaderboardGridContainer/VBoxContainer/ScoreSubmit/LineEdit
@onready var grid_container: GridContainer = $MarginContainer/LeaderboardPanelContainer/LeaderboardGridContainer/VBoxContainer/PlayersScores/GridContainer


func _ready() -> void:
	self.visible = false;
	
	var sw_result:Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	add_player_to_grid(player_list_with_pos)


func add_player_to_grid(player_list):
	if player_list.size() == 0:
		return
	
	for child in grid_container.get_children():
		child.queue_free()
	
	var players:Array[Player]
	for player in player_list:
		var my_data = Player.new()
		my_data.name = str(player["player_name"])
		my_data.position = str(player["position"])
		my_data.score = str(player["score"])
		my_data.minutes = player.metadata.minutes
		my_data.seconds = player.metadata.seconds
		my_data.time = str(player.metadata.time)
		players.append(my_data)

	# Per ordinare l'array:
	players.sort_custom(sort_players)
	
	var position = 1
	for player in players:
		player.position = position
		position += 1
	
	
	var pos_vbox = VBoxContainer.new()
	var name_vbox = VBoxContainer.new()
	var score_vbox = VBoxContainer.new()
	var time_vbox = VBoxContainer.new()
	

	for player in players:
		var pos_label = Label.new()
		pos_label.text = str(player.position)
		pos_label.show()
		pos_vbox.add_child(pos_label)
		pos_vbox.size_flags_horizontal =Control.SIZE_EXPAND + Control.SIZE_SHRINK_CENTER
	grid_container.add_child(pos_vbox)
		
	for player in players:
		var name_label = Label.new()
		name_label.text = player.name
		name_label.show()
		name_vbox.add_child(name_label)
		name_vbox.size_flags_horizontal =Control.SIZE_EXPAND + Control.SIZE_SHRINK_CENTER
	grid_container.add_child(name_vbox)
		
	for player in players:
		var score_label = Label.new()
		score_label.text = player.score
		score_label.show()
		score_vbox.add_child(score_label)
		score_vbox.size_flags_horizontal = Control.SIZE_EXPAND + Control.SIZE_SHRINK_CENTER
	grid_container.add_child(score_vbox)
		
	for player in players:
		var time_label = Label.new()
		time_label.text = player.time
		time_label.show()
		time_vbox.add_child(time_label)
		time_vbox.size_flags_horizontal =Control.SIZE_EXPAND + Control.SIZE_SHRINK_CENTER
	grid_container.add_child(time_vbox)


func sort_players_and_add_position(player_list):
	var position = 1
	for player in player_list:
		player["position"] = position
		position += 1
	return player_list

# Funzione di confronto personalizzata
func sort_players(a: Player, b: Player) -> bool:
	# Prima: ordina per score (maggiore prima)
	# Converte le stringhe in int per il confronto
	var score_a = int(a.score)
	var score_b = int(b.score)
	
	if score_a != score_b:
		return score_a > score_b  # Score maggiore viene prima
	
	# Se gli score sono uguali, ordina per minutes (minore prima)
	if a.minutes != b.minutes:
		return a.minutes < b.minutes
	
	# Se anche i minutes sono uguali, ordina per seconds (minore prima)
	return a.seconds < b.seconds



func _on_submit_score_pressed() -> void:
	Globals.player_name = line_edit.text
	print(Globals.player_name)
	print(Globals.score)
	print(Globals.time)
	
	var metadata = {
		"time": Globals.time,
		"minutes": Globals.minutes,
		"seconds": Globals.seconds
	}
	Engine.time_scale = 1.0
	var sw_result:Dictionary = await SilentWolf.Scores.save_score(Globals.player_name, Globals.score, "main", metadata).sw_save_score_complete
	print("Score persisted successfully: " + str(sw_result.score_id))
	
	sw_result = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	add_player_to_grid(player_list_with_pos)
	Engine.time_scale = 0


func _on_close_button_pressed() -> void:
	self.visible = false
	Engine.time_scale = 1.0
