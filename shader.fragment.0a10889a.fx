#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUV;

uniform sampler2D textureSampler;
uniform vec2 mouse;

void main(void) {
    vec2 uv=vUV;
    float dist = distance(uv, mouse);
    float distFactor = 10.0;
    vec4 black = vec4(0,0,0,1.0);
    vec4 textureColor = texture2D(textureSampler, vUV);
    gl_FragColor=mix(textureColor, black, dist * distFactor);
    gl_FragColor.a = 0.0;
}