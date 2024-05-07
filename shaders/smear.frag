#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;
uniform sampler2D u_tex1;


void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;

    vec4 maskColor = texture(u_tex1, st).rgba;
    vec4 imageColor = texture(u_tex0, st.xy+(10.0*vec2(1.0 - maskColor.r))).rgba;

//    fragColor = (imageColor * 0.7) + (imageColor * maskColor * 0.3);
//    fragColor = vec4(maskColor.r, 0.0, 0.0, 1.0);
//    fragColor = imageColor*maskColor;
    fragColor = imageColor;
//    fragColor = maskColor;
}

