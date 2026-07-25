extends Node

var combat_elements = [Hud, player, AbilitiesManager]

func show_ability_selection():
	for elem in combat_elements:
		elem.hide()
		elem.process_mode = Node.PROCESS_MODE_DISABLED
	GlobalTimer.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().change_scene_to_file("res://features/abilities/ability_selection.tscn")
	
func show_combat_scene():
	for elem in combat_elements:
		elem.show()
		elem.process_mode = Node.PROCESS_MODE_INHERIT
	GlobalTimer.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().change_scene_to_file("res://combat.tscn")
