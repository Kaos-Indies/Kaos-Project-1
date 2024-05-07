extends Node2D

@export var first_node:Area2D

func _ready():
	trigger_node(first_node)
	

func _on_node_trigger_next(next_node:Area2D):
	trigger_node(next_node)
	
func _on_node_final_node():
	print("Win State")
	
func trigger_node(node:Area2D):
	node.activate()
