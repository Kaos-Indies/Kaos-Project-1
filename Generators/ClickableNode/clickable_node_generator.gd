extends Node

# OnReady Variables

# Local Variables
@export var num_of_nodes = 3

const clickable_node_scene = preload("res://Components/ClickableNode/clickable_node.tscn")

var first_node:Area2D = null

# Signals


# Local Functions

# Override Functions
func _ready():
	var node
	for i in num_of_nodes:
		var new_node = clickable_node_scene.instantiate()
		add_child(new_node)
		new_node.connect("trigger_next", _on_node_trigger_next)
		new_node.connect("final_node", _on_node_final_node)
		new_node.connect("click_timed_out", _on_node_click_timed_out)
		# TODO: Fix positions
		new_node.set_position(Vector2((i*60)+20, (i*60)+20))
		if i == 0:
			self.first_node = new_node
			node = new_node
			continue
		node.next_node = new_node
		node = new_node
	
	first_node.activate()

# Signal Callbacks
func _on_node_trigger_next(next_node:Area2D):
	next_node.activate()
	
func _on_node_final_node():
	print("Win state")

func _on_node_click_timed_out(node:Area2D):
	print("Fail state")
	print(node)
