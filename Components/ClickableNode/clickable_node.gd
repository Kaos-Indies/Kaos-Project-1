extends Area2D

# OnReady Variables
@export var next_node:Area2D = null
@onready var start_timer = $StartDelay
@onready var time_to_click = $TimeToClick

# Local Variables
var is_mouse_in = false
var clickable = false
var node_index:int

# Signals
signal clicked(index:int)
signal final_node()
signal click_timed_out(index:int)

# Local Functions
func activate():
	print("Node ",self.node_index," activated")
	start_timer.start()

func deactivate():
	print("Node ",self.node_index," deactivated")
	clickable = false
	visible = false

func define(location:Vector2, index:int):
	self.position = location
	self.node_index = index

func set_clickable():
	clickable = true
	visible = true

func setPosition(location:Vector2):
	self.position = location

func on_click():
	print("Node ",self.node_index," clicked")
	self.time_to_click.stop()
	self.clickable = false
	clicked.emit(node_index)

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
	click_timed_out.emit(node_index)
