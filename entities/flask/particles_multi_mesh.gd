extends MultiMeshInstance2D

@onready var sphere_mesh: Polygon2D = $Circle
@onready var corner_meshes: Array[MeshInstance2D] = [
	$Corner1,$Corner2,$Corner3,$Corner4,$Corner5,$Corner6,$Corner7,$Corner8
]

func set_corners(corners: int):
	for i in range(corner_meshes.size()):
		corner_meshes[i].visible = i < corners

func set_color(color: Color):
	sphere_mesh.modulate = color
	for mesh in corner_meshes:
		mesh.modulate = color
