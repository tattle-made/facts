#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;


void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;

    vec4 color = texture(u_tex0, st).rgba;

    fragColor = color;
}

