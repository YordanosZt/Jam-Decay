extends Node2D

@export var bacteria: PackedScene

@export var move_speed = 150

var move_dir: Vector2
var food: Area2D

@onready var bacteria_container = $BacteriaContainer
@onready var crosshair = $Crosshair
@onready var bacteria_count_label = $CanvasLayer/BacteriaCountLabel

func _ready():
	Events.food_eaten.connect(_on_food_eaten)

func _process(delta):
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	move_dir = Vector2(horizontal, vertical).normalized()
	
	if not $MoveAudio.playing:
		$MoveAudio.play()
	
	if vertical == 0 and horizontal == 0:
		$MoveAudio.stop()
	
	if Input.is_action_just_pressed("fire") and bacteria_container.get_child_count() > 1:
		fire()
		$ShootAudio.play()
		
	var mouse_pos = get_global_mouse_position()
	crosshair.global_position = mouse_pos
	
	if bacteria_container.get_child_count() == 0:
		Events.game_over.emit()
		bacteria_count_label.text = ''
	elif bacteria_container.get_child_count() >= 100:
		Events.game_won.emit()
	else:
		bacteria_count_label.text = str(bacteria_container.get_child_count())

func _physics_process(delta):
	global_position += move_dir * move_speed * delta

func fire():
	var random_bacteria = bacteria_container.get_child(randf_range(0, bacteria_container.get_child_count()))
	var shoot_direction = random_bacteria.global_position.direction_to(get_global_mouse_position())
	random_bacteria.set_is_shot(true)
	random_bacteria.set_direction(shoot_direction)
	random_bacteria.reparent(get_node('/root/Game'))

func _on_food_eaten():
	spawn_bacteria()
	spawn_bacteria()

func spawn_bacteria():
	var _bac = bacteria.instantiate()
	_bac.position = bacteria_container.position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
	bacteria_container.add_child(_bac)











