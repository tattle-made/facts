#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
//uniform vec2 pixelSize;
uniform float offset;
uniform sampler2D u_tex0;



void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;

//    vec3 color = texture(u_tex0, st/5.0).rgb;
    vec3 color = texture(u_tex0, vec2((offset + st.x/5.0),st.y)).rgb;
    fragColor = vec4(color, 1.0);
}

