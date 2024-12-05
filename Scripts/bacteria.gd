extends Area2D

var is_shot: bool = false
var direction: Vector2
var shoot_speed: float = 450.0
var move_speed: float = 5.0

var bacteria_group := []

func _process(delta):
	if get_parent() != null and not is_shot:
		#var movement = Vector2()
		#movement += avoid_overlap() * delta
		#movement += position.direction_to(get_parent().position) * delta
		#position += movement * move_speed * delta
		position = lerp(position, get_parent().position, move_speed * delta)
		position += avoid_overlap() * 10.0
	
	if not is_shot: return
	
	shoot(delta)

func shoot(delta):
	global_position += direction * shoot_speed * delta

func set_direction(dxn: Vector2):
	direction = dxn

func set_is_shot(shot: bool):
	is_shot = shot

func avoid_overlap():
	var separation_radius = 20
	var separation_force = Vector2()
	
	for other_bacteria in bacteria_group:
		if other_bacteria != self and not other_bacteria.is_shot:
			var distance = position.distance_to(other_bacteria.position)
			if distance < separation_radius:
				var push_force = (position - other_bacteria.position).normalized()
				separation_force += push_force / distance

	return separation_force

func die():
	$DeathAudio.play()
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	await get_tree().create_timer(0.7).timeout
	queue_free()

func _on_bacteria_detector_area_entered(area):
	if not bacteria_group.has(area):
		bacteria_group.append(area)


func _on_bacteria_detector_area_exited(area):
	if bacteria_group.has(area):
		bacteria_group.erase(area)
