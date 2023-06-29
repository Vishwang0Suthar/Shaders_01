#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 pallete(float t){
    vec3 a = vec3(0.538,0.098,0.500);
    vec3 b = vec3(-0.302,-0.622,0.500);
    vec3 c = vec3(1.000,1.000,-0.882);
    vec3 d = vec3(0.000,-2.712,-1.242);

    return a + b*cos( 5.28318*(c*t+d) );
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = (fragCoord * 2.0 - u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    for(float i = 0.0; i < 2.0; i++) {
        uv = fract(uv * 1.5) - 0.5;
        float d = length(uv) * exp(-length(uv0));

        vec3 col = pallete(length(uv0) + i * 0.5 + u_time * 1.0);
        d = cos(d * 8.5 + u_time * 1.3) / 7.0;
        d = abs(d);
        d = 0.01 / d;

        finalColor += col * d;
    }

    fragColor = vec4(finalColor, 1.0);
}

void main() {
    vec4 fragColor;
    mainImage(fragColor, gl_FragCoord.xy);
    gl_FragColor = fragColor;
}
