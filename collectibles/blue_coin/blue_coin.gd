extends Node

@export var award_amount : int = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var label = $Label


func _ready():
	_label.hide()
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print(award_amount)
		animated_sprite_2d.hide()
		label.text = "%s" % award_amount
		CollectibleManager.give_pickup_amount(award_amount)
		
		label.show()
		
		var tween = get_tree().create_tween()
		tween.tween_property(label, "position", Vector2(label.position.x, lael.position.y + -10), 0.5).from_current()
		tween.tween_callback(queue_free())
