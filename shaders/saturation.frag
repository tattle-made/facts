#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;
uniform float saturation;

// Values from "Graphics Shaders: Theory and Practice" by Bailey and Cunningham
const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;
    vec4 color = texture(u_tex0, st).rgba;

    lowp float luminance = dot(color.rgb, luminanceWeighting);
    lowp vec3 greyScaleColor = vec3(luminance);

    fragColor = vec4(mix(greyScaleColor, color.rgb, saturation), color.a);
}

