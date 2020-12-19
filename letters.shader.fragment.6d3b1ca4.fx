
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUV;
uniform sampler2D textureSampler;
uniform sampler2D iChannel0;
uniform vec2 mouse;
uniform vec2 iResolution;
uniform float noktoFactor;

void mainImage(out vec4 f, in vec2 w)
{
    vec2 u = w/iResolution.xy; // left-bottom is (0,0)
    vec2 alteredU = u;
    alteredU.x*=iResolution.x / iResolution.y; // use perfect circle from bg shader
    vec2 alteredMouse = mouse;
    alteredMouse.x *= iResolution.x / iResolution.y;
    float dist = distance(alteredU, alteredMouse);
    float distFactor = 8.0;
    //vec4 black = vec4(0, 0, 0, 0.0);
    vec4 lettersTextureColor = texture2D(iChannel0, u);
    vec4 bgTextureColor = texture2D(textureSampler, u);
    vec4 transparency = vec4(0,0,0,0);
    vec4 lettersResult=mix(lettersTextureColor, transparency, dist * distFactor);
    lettersResult.a = lettersTextureColor.a;// - dist * distFactor;
    if(dist > 0.15) {
        lettersResult.a = 0.0;
    }
    lettersResult.a *= noktoFactor;

    f = mix(bgTextureColor, lettersResult, lettersResult.a);
    //f = lettersResult;
}

void main()
{
    mainImage(gl_FragColor, vUV * iResolution.xy);
}
