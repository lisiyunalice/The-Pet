shader_type canvas_item;

uniform float glow_strength = 1.0;

void fragment() {
    COLOR = texture(TEXTURE, UV);
    if (COLOR.r > 0.8 && COLOR.g > 0.8) {
        COLOR.rgb += vec3(glow_strength * 0.2);
    }
}
