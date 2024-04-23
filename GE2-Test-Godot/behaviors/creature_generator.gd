@tool
extends Node3D

@export var length:int = 10
@export var frequency:float = 1
@export var start_angle:float = 0.0
@export var base_size:float = 1.0
@export var multiplier:float = 1.0

var head_scene = preload("res://head_scene.tscn")
var body_scene = preload("res://body_scene.tscn")

func _process(_delta):
	if Engine.is_editor_hint():
		draw_gizmo()

func draw_gizmo():
	var angle = start_angle
	for i in range(length):
		var size = base_size + sin(angle) * multiplier
		var position = Vector3(i * size, 0, 0)
		draw_cube(position, Vector3(size, size, size))
		angle += 2 * PI * frequency / length

func draw_cube(position, size):
	var cube = MeshInstance3D.new()
	cube.mesh = BoxMesh.new()
	cube.mesh.size = size
	cube.transform.origin = position
	add_child(cube)
	print("Drawing cube at: ", position, " with size ", size)

func _ready():
	if not Engine.is_editor_hint():
		print("Creating creature...")
		create_creature()
	
func create_creature():
	var angle = start_angle
	var previous_segment = self
	for i in range(length):
		var size = base_size + sin(angle) * multiplier
		var position = Vector3(i * size, 0, 0)
		var segment
		if i == 0:
			segment = head_scene.instantiate()
			segment.get_node("CSGBox3D").size = Vector3(size, size, size)
		else:
			segment = body_scene.instantiate()
			segment.size = Vector3(size, size, size)
		previous_segment.add_child(segment)
		segment.transform.origin = position
		previous_segment = segment
		angle += 2 * PI * frequency / length
		print("Segment added at: ", position, " with size ", size)
