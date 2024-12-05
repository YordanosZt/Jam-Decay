extends Area2D

var sworm: Node2D

var move_speed: float = 100
var move_dxn

func _ready():
	sworm = get_node("/root/Game/Sworm")

func _process(delta):
	move_dxn = global_position.direction_to(sworm.global_position)
	global_position += move_dxn * move_speed * delta


func _on_area_entered(area):
	area.die()
	
	if area.is_shot:
		queue_free()
