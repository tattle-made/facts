#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform vec2 cursor;
uniform sampler2D u_tex0;


void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;
    vec2 mn = cursor/u_resolution;

    vec3 color = texture(u_tex0, st).rgb;

    fragColor = vec4(pow(color.r,20.0*mn.y), pow(color.g,20.0*mn.x), color.b, 1.0);
}

