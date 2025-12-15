varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixelH;
uniform float pixelW;
uniform vec4 outlineColor; // ADD THIS LINE

void main()
{
    vec2 offx;
    offx.x = pixelW;
    vec2 offy;
    offy.y = pixelH;
    
    float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
    
    alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord+offx ).a);
    alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord+offy ).a);
    alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord-offx ).a);
    alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord-offy ).a);
    
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    // USE THE UNIFORM INSTEAD OF HARDCODED RED
    if (gl_FragColor.a==0.0) {
        gl_FragColor = outlineColor; // Use the uniform
        gl_FragColor.a = alpha; // Keep the calculated alpha
    } else {
        gl_FragColor.a = alpha;
    }
}