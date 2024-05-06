extends Area2D

var is_mouse_in = false
var clickable = false

@export var next_node:Area2D = null
@onready var timer = $Timer
	
func set_clickable():
	clickable = not clickable
	if clickable:
		$Sprite2D.visible = true
	else:
		$Sprite2D.visible = false

func _input(event):
	if event is InputEventMouseButton and is_mouse_in and clickable:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print(next_node)
			next_node.timer.start()
			self.timer.stop()

func _on_mouse_entered():
	is_mouse_in = true


func _on_mouse_exited():
	is_mouse_in = false


func _on_timer_timeout():
	set_clickable()
