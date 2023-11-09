#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;
uniform float hazeDistance;
uniform float slope;
uniform float colorU;

void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;


    vec4 color = vec4(colorU);

    highp float  d = st.y * slope  +  hazeDistance;
    vec4 c = texture(u_tex0, st);
    c = (c - d*color)/(1.0 - d);

    fragColor = c;
}

