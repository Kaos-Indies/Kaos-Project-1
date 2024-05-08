extends Node

# OnReady Variables

# Local Variables
var node_vectors := [Vector2(200,200), Vector2(600,200), Vector2(400,500), Vector2(300, 500)]
var nodes: Array[Area2D]

const clickable_node_scene = preload("res://Components/ClickableNode/clickable_node.tscn")

# Signals


# Local Functions
func set_vectors(vectors:Array[Vector2]):
	self.node_vectors = vectors

# Override Functions
func _ready():
	for i in node_vectors.size():
		var node = clickable_node_scene.instantiate()
		nodes.insert(i, node)
		add_child(node)
		node.connect("clicked", _on_node_clicked)
		node.connect("final_node", _on_node_final_node)
		node.connect("click_timed_out", _on_node_click_timed_out)
		node.define(node_vectors[i], i)
	
	nodes[0].activate()

# Signal Callbacks
func _on_node_clicked(index:int):
	if (index == nodes.size()-1):
		print("win state")
		return
	nodes[index+1].activate()

func _on_node_final_node():
	print("Win state")

func _on_node_click_timed_out(index:int):
	nodes[index].deactivate()
	if (index == 0):
		print("Fail state")
		return
	nodes[index-1].activate()
