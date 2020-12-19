
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUV;
uniform sampler2D iChannel0;
uniform vec2 mouse;
uniform vec2 iResolution;
uniform float noktoFactor;

void mainImage(out vec4 f, in vec2 w)
{
    vec2 u = w/iResolution.xy; // left-bottom is (0,0)
    float dist = distance(u, mouse);
    float distFactor = 10.0;
    vec4 black = vec4(0,0,0,1.0);
    vec4 textureColor = texture2D(iChannel0, u);
    f=mix(textureColor, black, dist * distFactor);
    f.a = textureColor.a;
    f.a*=noktoFactor;

    f = textureColor;
    //f.r=1.0;
    //f.g = f.b = 0.0;
    //f.a = 0.0;
}

void main()
{
    mainImage(gl_FragColor, vUV * iResolution.xy);
}
