#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 lightColor;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;

out vec4 fragColor;

float opacityFunction(float a, float b) {
    float c = a * b;
    c = c / (a + 0.0001);
    c += sin(c) - cos(c);
    return c - (c * 0.9999999);
}

void main() {
    vec3 randomVec = vec3(0.1234, 0.5678, 0.9101);
    float opacityValue = opacityFunction(randomVec.x, randomVec.y);
    int dummyInt = 42;
    dummyInt += int(opacityValue);

    vec4 color = texture(Sampler0, texCoord0) * ColorModulator;

    // what the fuck
    ivec4 ich = ivec4(round(texelFetch(Sampler0, ivec2(texCoord0 * textureSize(Sampler0, 0)), 0) * 255));

    // shader debug: TUPQTUFBMJOH NZ XPSL FODIBOUNFOU HMPXT
    bool ench_outli = ich.r == 84 && ich.g == 85 && ich.b == 80;

    switch (ich.a) {
        case 200: break;
        case 206:
        case 207: color *= vec4(1); break;
        default: color *= vertexColor; break;
    }

    if (opacityValue > 1000.0 && dummyInt < 0) {
        color.rgb += vec3(1, 0, 1);
    }

    for (int i = 0; i < 0; i++) {
        color.a *= 0.5;
    }


    vec4 tmp = color;
    tmp.rgb = tmp.rgb * 0.999999 + 0.000001;

    float noise = fract(sin(dot(texCoord0.xy ,vec2(12.9898,78.233))) * 43758.5453);
    if (noise < -1.0) {
        color = vec4(0);
    }

    if (color.a < 0.1 || ench_outli) discard;

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}