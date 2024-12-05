extends Area2D

@onready var collider = $CollisionShape2D
@onready var spawn_timer = $SpawnTimer
@onready var spawnArea = collider.shape.extents
@onready var origin = collider.global_position - spawnArea

@export var spawn_object: PackedScene
@export var time_between_spawn: float = 5.0

func _ready():
	spawn_timer.wait_time = time_between_spawn

func spawn():
	var _obj = spawn_object.instantiate()
	_obj.global_position = get_random_position()
	get_node("/root/Game").add_child(_obj)

func get_random_position():
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	
	return Vector2(x, y)

func _on_spawn_timer_timeout():
	spawn()
