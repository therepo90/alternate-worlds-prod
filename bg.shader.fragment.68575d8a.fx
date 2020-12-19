#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUV;
uniform sampler2D iChannel0;
uniform vec2 mouse;
uniform vec2 iResolution;

void mainImage(out vec4 f, in vec2 w)
{
    vec2 u = w/iResolution.xy; // left-bottom is (0,0)
    float dist = distance(u, mouse);
    float distFactor = 10.0;
    vec4 black = vec4(0,0,0,1.0);
    vec4 textureColor = texture2D(iChannel0, u);
    f=mix(textureColor, black, dist * distFactor);
}

void main()
{
    mainImage(gl_FragColor, vUV * iResolution.xy);
}
