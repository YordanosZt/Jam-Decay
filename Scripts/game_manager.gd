extends Node2D

@export var game_over_panel: Node
@export var game_won_panel: Node

func _ready():
	Engine.time_scale = 1
	Events.game_over.connect(_on_game_over)
	Events.game_won.connect(_on_game_won)

func _on_game_over():
	game_over_panel.visible = true
	Engine.time_scale = 0

func _on_game_won():
	game_won_panel.visible = true
	Engine.time_scale = 0
