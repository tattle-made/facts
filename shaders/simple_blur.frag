#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;
uniform float xs,ys;
uniform float r;
uniform float axis;


void main() {
    vec2 fragCoord = FlutterFragCoord();
    vec2 st = FlutterFragCoord().xy / u_resolution;
//    vec4 color = texture(u_tex0, st);

    float x,y,rr=r*r,d,w,w0;
    vec2 p=0.5*(vec2(1.0,1.0)+st);
    vec4 col=vec4(0.0,0.0,0.0,0.0);
    w0=0.5135/pow(r,0.96);
    if (axis==0) for (d=1.0/xs,x=-r,p.x+=x*d;x<=r;x++,p.x+=d){ w=w0*exp((-x*x)/(2.0*rr)); col+=texture(u_tex0,st)*w; }
    if (axis==1) for (d=1.0/ys,y=-r,p.y+=y*d;y<=r;y++,p.y+=d){ w=w0*exp((-y*y)/(2.0*rr)); col+=texture(u_tex0,st)*w; }

    fragColor = col;
}

