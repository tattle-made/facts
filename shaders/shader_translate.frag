#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform float offset;
uniform sampler2D u_tex0;


void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;

    float norm = offset/u_resolution.x;

    vec3 color = texture(u_tex0, st).rgb;

    fragColor = vec4(color.r, color.g, norm, 1.0);
}

