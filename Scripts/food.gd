extends Node2D

@onready var progress_bar = $ProgressBar

#var increase_progress: bool = false
var bacterial_count: int = 0

func set_progress_bar(value):
	progress_bar.value += value

func _process(delta):
	#if increase_progress:
		#set_progress_bar(10 * delta)
	if bacterial_count > 0:
		set_progress_bar(bacterial_count * 10 * delta)
		if not $EatAudio.playing:
			$EatAudio.play()
	else:
		$EatAudio.stop()

func _on_progress_bar_value_changed(value):
	if value >= progress_bar.max_value:
		Events.food_eaten.emit()
		queue_free()


func _on_area_entered(area):
	bacterial_count += 1
	#increase_progress = true


func _on_area_exited(area):
	bacterial_count -= 1
	#increase_progress = false
