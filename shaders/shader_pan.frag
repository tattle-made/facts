#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
//uniform vec2 u_resolution;
//uniform vec2 pixelSize;
//uniform sampler2D u_tex0;



void main() {
//    vec2 fragCoord = FlutterFragCoord();
//    vec2 st = FlutterFragCoord().xy / u_resolution;
//    vec2 mn = pixelSize/u_resolution;
//
//    float OFFSET=0.7; // from 0.0 to 1.0
//    vec3 color = texture(u_tex0, (vec2(4.0*(OFFSET),0.0)+st)/5.0).rgb;

    fragColor = vec4(0.0,1.0,0.0, 1.0);
}

