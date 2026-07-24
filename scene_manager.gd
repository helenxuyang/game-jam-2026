extends Node

func show_ability_selection():
	player.process_mode = Node.PROCESS_MODE_DISABLED
	player.hide()
	get_tree().change_scene_to_file("res://features/abilities/ability_selection.tscn")
	
func show_combat_scene():
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.show()
	get_tree().change_scene_to_file("res://combat.tscn")
