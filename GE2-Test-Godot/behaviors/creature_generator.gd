@tool
extends Node3D

@export var length:int = 10
@export var frequency:int = 1
@export var start_angle:float = 0.0
@export var base_size:float = 1.0
@export var multiplier:float = 1.0

#var head_scene = preload("res://addons")
#var body_scene = preload("res://addons")

func _process(delta):
	if Engine.is_editor_hint():
		pass

# func draw_gizmo():
#     var angle = start_angle
#     for i in range(length):
#         var size = base_size + sin(angle) * multiplier
#         var position = Vector3(i, 0, 0)
#         draw_cube()
#         angle += 2 * PI * frequency / length

func draw_cube(position, size):
	var cube = MeshInstance3D.new()
	cube.mesh = BoxMesh.new()
	cube.mesh.size = size
	cube.transform.origin = position
	add_child(cube)

func _ready():
	if not Engine.is_editor_hint():
		pass
		# create_creature()
	

