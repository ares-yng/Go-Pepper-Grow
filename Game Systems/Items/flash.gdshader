shader_type canvas_item;

uniform float flashModifier : hint_range(0.0, 1.0) = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//vec4 mask = texture(TEXTURE, UV);
	//mask.r += 0.3;
	//COLOR = mask;

	//COLOR.a = 1.0;
	//vec3 mask = vec3(step(0.3, length(vec2(.2, .2))));
	//COLOR.rgb = mask;

	//vec4 white = vec4(1, 1, 1, 1);
	//if (COLOR.a < 0.1) {
	//	COLOR = white;
	//}
	vec3 white = vec3(1,1,1);
	vec4 color = COLOR;
	color.rgb = mix(color.rgb, white, flashModifier);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
