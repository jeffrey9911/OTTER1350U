#version 440

// Include our common vertex shader attributes and uniforms
#include "../fragments/vs_common.glsl"

layout(location = 5) out float specPower;

//uniform vec3 u_WindDirection;
//uniform float u_WindStrength;
//uniform float u_VerticalScale;
//uniform float u_WindSpeed;
uniform sampler2D myTextureSampler;
uniform float timeMultiplier = 2.0;

void main() {
	// Pass our UV coords to the fragment shader
	outUV = inUV;
	outColor = inColor;
	// Normals
	outNormal = mat3(u_NormalMatrix) * inNormal;


    // Determine the offset based on our simple wind calcualtion
    //vec3 windFactor = normalize(u_WindDirection) * sin(u_Time * u_WindSpeed) * cos(inPosition.z * u_VerticalScale) * u_WindStrength;
	// Calculate the output world position
	outWorldPos = (u_Model * vec4(inPosition, 1.0)).xyz;

	vec3 vertPos = inPosition;
	vertPos.z = texture(myTextureSampler, outUV).r;
	vertPos.z = sin(vertPos.z * 5.0 + (u_Time * timeMultiplier)) * 0.3;
	outWorldPos = (u_Model * vec4(vertPos, 1.0)).xyz;
	//outWorldPos.z = texture(myTextureSampler, inUV).r;
    // Project the world position to determine the screenspace position
	gl_Position = u_ViewProjection * vec4(outWorldPos, 1);

	specPower = vertPos.z;
	
}

