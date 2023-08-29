#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;

float circle(in vec2 _st, vec2 _mn, in float _radius){
    vec2 dist = _st-_mn;
    return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;

    vec3 color = texture(u_tex0, st).rgb;

    fragColor = vec4(color, 1.0);
}

