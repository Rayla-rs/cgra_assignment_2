extends AspectRatioContainer

@export var bunny: MeshInstance3D
@export var light: Light3D
@export var cam: Camera3D

func _process(delta: float):
	bunny.set_instance_shader_parameter("base_color", $VBoxContainer/BaseColorBox/ColorPickerButton.color)
	bunny.set_instance_shader_parameter("specular_color", $VBoxContainer/SpecColorBox/ColorPickerButton.color)
	bunny.set_instance_shader_parameter("ambient", $VBoxContainer/AmbientBox/HSlider.value)
	bunny.set_instance_shader_parameter("diffuse_scale", $VBoxContainer/DiffuseBox/HSlider.value)
	bunny.set_instance_shader_parameter("shininess", $VBoxContainer/ShininessBox/HSlider.value)
	bunny.set_instance_shader_parameter("noise_strength", $VBoxContainer/NoiseBox/HSlider.value)
	bunny.set_instance_shader_parameter("distortion_color", $VBoxContainer/NoiseColorBox/ColorPickerButton.color)

	var speed = 50.0
	var x_axis = Input.get_axis("down", "up")
	var y_axis = Input.get_axis("left", "right")

	if Input.is_action_pressed("light_mode"):
		light.rotation.x += deg_to_rad(x_axis * speed * delta)
		light.rotation.y += deg_to_rad(y_axis * speed * delta)
	else:
		speed = 5
		var rotation = (Quaternion(Vector3(1, 0, 0), x_axis * speed * delta) * Quaternion(Vector3(0, 1, 0), y_axis * speed * delta))
		cam.global_position *= rotation
		cam.look_at(Vector3(0,1,0))
		
