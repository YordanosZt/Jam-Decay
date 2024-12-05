extends CanvasLayer


func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
