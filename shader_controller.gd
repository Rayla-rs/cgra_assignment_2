extends AspectRatioContainer

@export var bunny: MeshInstance3D
@export var light: Light3D

func _process(_delta: float):
	bunny.set_instance_shader_parameter("base_color", $VBoxContainer/BaseColorBox/ColorPickerButton.color)
	bunny.set_instance_shader_parameter("specular_color", $VBoxContainer/SpecColorBox/ColorPickerButton.color)
	bunny.set_instance_shader_parameter("ambient", $VBoxContainer/AmbientBox/HSlider.value)
	bunny.set_instance_shader_parameter("diffuse_scale", $VBoxContainer/DiffuseBox/HSlider.value)
	bunny.set_instance_shader_parameter("shininess", $VBoxContainer/ShininessBox/HSlider.value)
	bunny.set_instance_shader_parameter("noise_strength", $VBoxContainer/NoiseBox/HSlider.value)
	bunny.set_instance_shader_parameter("distortion_color", $VBoxContainer/NoiseColorBox/ColorPickerButton.color)
