@tool extends MeshInstance3D

@export var light: Light3D;

func _process(_delta: float):
	self.set_instance_shader_parameter("light_pos", light.position)
	self.set_instance_shader_parameter("light_dir", light.rotation)
