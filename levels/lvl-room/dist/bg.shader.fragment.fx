#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUV;
uniform sampler2D iChannel0;
uniform vec2 mouse;
uniform vec2 iResolution;

void mainImage(out vec4 f, in vec2 w)
{
    vec2 u = w / iResolution.xy; // left-bottom is (0,0)
    vec2 alteredU = u;
    alteredU.x *= iResolution.x / iResolution.y; // make perfect circle
    vec2 alteredMouse = mouse;
    alteredMouse.x *= iResolution.x / iResolution.y;

    // Calculate distance from the center of the spotlight
    float dist = distance(alteredU, alteredMouse);

    // Define spotlight parameters
    float spotlightRadius = 0.15;

    // Create a spotlight effect using a radial gradient
    float spotlight = 1.0 - smoothstep(0.0, spotlightRadius, dist);

    // Define the background color (yellow)
    vec3 backgroundColor = vec3(1.0, 1.0, 0.0);

    // Mix the background color and the texture color based on the spotlight effect
    vec4 textureColor = texture2D(iChannel0, u);
    vec3 finalColor = mix(textureColor.rgb * 0.6, textureColor.rgb + mix(backgroundColor, textureColor.rgb, 0.8) * 0.1, spotlight *5.0);

    // Set the alpha value from the texture
    f = vec4(finalColor, textureColor.a);
}

void main()
{
    mainImage(gl_FragColor, vUV * iResolution.xy);
}
