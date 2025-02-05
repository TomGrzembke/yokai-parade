shader_type canvas_item;

uniform vec4 color_exchange_black : source_color;
uniform vec4 color_exchange_white : source_color;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114));  

    vec4 finalColor = mix(color_exchange_black, color_exchange_white, brightness); 
    
    COLOR = mix(finalColor, color, brightness);
}