shader_type canvas_item;

uniform sampler2D existing_screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float overlay_alpha : hint_range(0.0, 1.0); 
uniform float tint_amount : hint_range(0.0, 1.0); 
uniform vec2 pattern_scale = vec2(1.0, 1.0); 
uniform vec2 tilemap_offset = vec2(0.0, 0.0); 
varying vec2 world_position;
uniform bool flip_alpha = true;

vec4 soft_light_blend(vec4 base, vec4 blend, float alpha){
	return mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend), 
	sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), 
	alpha);
}

vec4 overlay(vec4 base, vec4 blend){
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}

vec4 color_dodge(vec4 base, vec4 blend){
	return base / 1.0 + blend;
}

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec3 screen_color = texture(existing_screen_texture, SCREEN_UV, 0.0).rgb;
	screen_color = vec3(1.0) - screen_color;
	
	
	COLOR.rgb = screen_color;
}
