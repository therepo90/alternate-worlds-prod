#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUV;
uniform sampler2D iChannel0;
uniform vec2 mouse;
uniform vec2 iResolution;
uniform float iTime; // seconds
uniform float dragging;
uniform float diffX;
uniform float diffY;

void mainImage(out vec4 f, in vec2 w)
{
        vec2 u = w/iResolution.xy; // left-bottom is (0,0)
        vec2 alteredU = u;
        alteredU.x*=iResolution.x / iResolution.y; // use perfect circle from bg shader
        vec2 alteredMouse = mouse;
        // adapt diff from where user clicked to the moon
        alteredMouse.x -= diffX;
        alteredMouse.y += diffY;
        alteredMouse.x *= iResolution.x / iResolution.y;

          // Calculate distance from the center of the spotlight
          float dist = distance(alteredU, alteredMouse);

          // Define spotlight parameters
          float spotlightRadius = 0.12;
         // float opaqueRadius = 0.05;

          // Create a spotlight effect using a radial gradient
          float spotlight = 1.0 - smoothstep(0.0, spotlightRadius, dist);
          //spotlight*=step(opaqueRadius, dist);

        //float distFactor = 1.0;
        //vec4 black = vec4(0, 0, 0, 0.0);
        vec4 lettersTextureColor = texture2D(iChannel0, u);
        vec4 transparency = vec4(0,0,0,0);
        //vec4 lettersResult=mix(lettersTextureColor, transparency, spotlight);
        //lettersResult.a = lettersTextureColor.a * spotliht;// - dist * distFactor;
        /* if(dist > 0.15) {
            lettersResult.a = 0.0;
        } */
        //lettersResult.a *= noktoFactor;
        vec4 lightColor = vec4(1.0, 1.0, 1.0, 1.0);
        vec4 finalColor = lightColor * spotlight + lettersTextureColor * spotlight;
        //finalColor.a = lettersTextureColor.a * spotlight;
        //vec4 wallText = texture2D(iChannel1, u);
        //finalColor=mix(finalColor, wallText, wallText.a * spotlight);
        //finalColor = wallText;
       // f = finalColor;
        //f = lettersTextureColor;
        //f = lightColor * spotlight;
       //  f=vec4(dragging, 0.0, 0.0, 1.0);
         //f=vec4(1.0, 0.0, 0.0, 1.0);
         if(dragging > 0.0){
          f = finalColor;
          //f=vec4(0.0, 0.0, 0.0, 0.5);
        } else{
          f=vec4(0.0, 0.0, 0.0, 0.0);
        }
}

void main()
{
    mainImage(gl_FragColor, vUV * iResolution.xy);
}
