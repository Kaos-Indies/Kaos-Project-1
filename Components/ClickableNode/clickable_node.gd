extends Area2D

# OnReady Variables
@export var next_node:Area2D = null
@onready var start_timer = $StartDelay
@onready var time_to_click = $TimeToClick

# Local Variables
var is_mouse_in = false
var clickable = false

# Signals
signal trigger_next(next_node:Area2D)
signal final_node()
signal click_timed_out(node:Area2D)

# Local Functions
func activate():
	start_timer.start()

func set_clickable():
	clickable = true
	visible = true

func setPosition(location:Vector2):
	self.position = location

func on_click():
	self.time_to_click.stop()

	if next_node == null:
		final_node.emit()
		return

	trigger_next.emit(next_node)

# Override Functions
func _input(event):
	# Check if triggered event is a mouse click
	if event is InputEventMouseButton:
		# If Mouse not in Object, return
		if not is_mouse_in:
			return
		# If Object is not in Clickable State, return
		if not clickable:
			return
		# If Left Click and just happened, trigger clicked handler
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			on_click()

# Signal Callbacks
func _on_mouse_entered():
	is_mouse_in = true

func _on_mouse_exited():
	is_mouse_in = false

func _on_timer_timeout():
	set_clickable()
	time_to_click.start()

func _on_time_to_click_timeout():
	self.time_to_click.stop()
	click_timed_out.emit(self)
