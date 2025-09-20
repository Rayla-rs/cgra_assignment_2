shader_type spatial;
render_mode unshaded;

instance uniform vec3 base_color : source_color = vec3(1,1,1);
instance uniform float ambient = 0.44;
instance uniform float diffuse_scale = 1.5;
instance uniform float shininess = 1.6;
instance uniform vec3 specular_color : source_color;

uniform vec3 light_color: source_color;
uniform float light_intensity;

// Noise
uniform float noise_speed;
instance uniform float noise_strength;
instance uniform vec3 distortion_color: source_color;

// For script
instance uniform vec3 light_pos;
instance uniform vec3 light_dir;

// varying
varying vec3 normal;
varying vec3 dir_to_cam;

vec3 vec4_to_vec3(vec4 input) {
	return vec3(input.x, input.y, input.z);
}

float offset(vec3 from) {
	return cos(from.x * TIME * noise_speed) *
		sin(from.z * TIME * noise_speed) *
		noise_strength;
}

void vertex() {
	// Horizontal noise
	VERTEX.y += offset(VERTEX);

	// Distance from light
	vec3 off = normalize(VERTEX - light_pos);
	float offset_factor = 1./pow(E, distance(VERTEX, light_pos) * 5.);
	VERTEX += off * offset_factor;
}

void fragment() {
	//mat3(transpose(inverse(MODEL_MATRIX))) * NORMAL
	vec3 frag_pos = vec4_to_vec3(FRAGCOORD);

	// Ambient
	vec3 ambient_final = ambient * light_color;

	// Difuse
	float diff = max(dot(NORMAL, light_dir), 0.0);
	vec3 diffuse = diffuse_scale * diff * light_color;

	// Specular
	vec3 view_pos = CAMERA_POSITION_WORLD;
	vec3 view_dir = normalize(view_pos - frag_pos);
	vec3 reflect_dir = reflect(-light_dir, NORMAL);

	float spec_strength = 0.5;
	float spec = pow(max(dot(view_dir, reflect_dir), 0.0), shininess);
	vec3 specular = spec_strength * spec * light_color * specular_color;

	// Distortion color
	float factor = dot(NORMAL, normalize(frag_pos + vec3(0,offset(frag_pos),0)));

	vec3 col = mix(base_color, distortion_color, factor * noise_strength*10.);
	// Finally
	ALBEDO = (ambient_final + diffuse + specular) * col;

}
