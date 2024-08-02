# Shader Code Overview

## Introduction

This code is a fragment shader written in GLSL (OpenGL Shading Language). It defines a colorful animation using procedural generation techniques and uniform variables for dynamic control. The shader calculates the color at each pixel based on a time-varying palette and the pixel's position on the screen.

### You can play around with the code yourself keeping in mind the following key points.
## Key Components

### Precision Specification
```glsl
#ifdef GL_ES
precision mediump float;
#endif
```
Specifies the precision for floating-point operations in the shader.

### Uniform Variables
```glsl
uniform vec2 u_resolution;
uniform float u_time;
```
- `u_resolution`: The resolution of the output screen.
- `u_time`: The current time, used to animate the shader.

### Palette Function
```glsl
vec3 pallete(float t) {
    vec3 a = vec3(0.538, 0.098, 0.500);
    vec3 b = vec3(-0.302, -0.622, 0.500);
    vec3 c = vec3(1.000, 1.000, -0.882);
    vec3 d = vec3(0.000, -2.712, -1.242);
    return a + b * cos(5.28318 * (c * t + d));
}
```
The `pallete` function generates a dynamic color based on the input `t`. It combines several vectors with cosine functions to create smooth transitions in color.

### Main Image Function
```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord * 2.0 - u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    for (float i = 0.0; i < 2.0; i++) {
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
```
The `mainImage` function calculates the final color for each pixel. It iterates to create fractal-like patterns and adjusts the color based on distance and time.

### Main Function
```glsl
void main() {
    vec4 fragColor;
    mainImage(fragColor, gl_FragCoord.xy);
    gl_FragColor = fragColor;
}
```
The `main` function serves as the entry point, calling `mainImage` to compute the fragment color and output it to the screen.

## PREVIEW
![Screenshot 2023-green](https://github.com/user-attachments/assets/e0e282d4-dcbc-45b3-9d56-273c1e3476dd)
###
###
![Picsart_24-08-02_19-42-34-541](https://github.com/user-attachments/assets/dc7498ca-b86f-497c-b7de-e5769ff68d5d)
