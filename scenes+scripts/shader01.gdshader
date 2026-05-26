// this is a 2D CanvasItem shader
shader_type canvas_item;

const float threshold = 0.2;

void fragment() {
	// color each fragment the Sprite covers black
	COLOR = vec4(0.0, 0.0, 1.0, 1.0);
	// declare the blob_centers as
	// a changing array of vec3s
	// with length 2 (2 elements)
	vec3 blob_centers[6];
	// define the blob centers
	// we start counting at 0
	blob_centers[0] = vec3(0.5, 0.7, 0.5);
	blob_centers[1] = vec3(0.3, 0.6, 0.3);
	blob_centers[2] = vec3(0.2, 0.3, 0.5);
	blob_centers[3] = vec3(0.1, 0.8, 0.3);
	blob_centers[4] = vec3(0.5, 0.4, 0.5);
	blob_centers[5] = vec3(0.2, 0.5, 0.3);
	// start counting influence at 0
	float influence = 0.0;
	// for each of the blobs, we add some influence based on how close
	// this point is to each blob
	for (int i = 0; i < blob_centers.length(); i++) {
		// TODO: explain each of these variables
		float distance_to_blob_center = distance(blob_centers[i].xy / TEXTURE_PIXEL_SIZE, UV / TEXTURE_PIXEL_SIZE);
		influence += blob_centers[i].z * (1.0 / distance_to_blob_center);
	}
	// if influence is larger than a certain threshold, set the color at this
	// point to white
	if (influence > threshold) {
		COLOR = vec4(1.0);
	}
	
}