extends CanvasLayer



func _on_restart_btn_pressed():
	get_tree().reload_current_scene()


func _on_quit_btn_pressed():
	get_tree().quit()
