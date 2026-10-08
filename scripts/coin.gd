extends Area2D
@onready var game_manager = %"Game manager"
@onready var animation_player = $pickup2
func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	animation_player.play("pickup")
	
	
