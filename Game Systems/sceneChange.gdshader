shader_type canvas_item;

uniform vec4 sceneChangeColor = vec4(0,0,0,1);
uniform float sceneChangeModifier : hint_range(0.0, 1.0) = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = COLOR;
	color = mix(color, sceneChangeColor, sceneChangeModifier);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
