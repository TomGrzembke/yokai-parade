shader_type canvas_item;

//uniform sampler2D pattern_texture;
uniform float mix_amount : hint_range(0.0, 1.0); 
uniform vec4 color_a : source_color;
uniform vec4 color_b : source_color;

void fragment() {
	
	vec4 texture_color = texture(TEXTURE, UV);
	
	vec4 first_color = mix(texture_color, -color_a, -texture_color.a);
	
	vec4 second_color = mix(texture_color, 1.0 -color_b, -texture_color.a);
	
	vec4 final_mix = mix(first_color, second_color, mix_amount);
	COLOR = final_mix;
}
