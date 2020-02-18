//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float seed;

float PHI = 1.61803398874989484820459 * 00000.1; // Golden Ratio   
float PI  = 3.14159265358979323846264 * 00000.1; // PI
float SQ2 = 1.41421356237309504880169 * 10000.0; // Square Root of Two


float rand(vec2 co,float seed){
    //return fract( sin(co.x*100.0 + co.y*6574.0)*5467.0);
    return fract(tan(distance(co*(seed+PHI), vec2(PHI, PI)))*SQ2);
}

void main()
{
    float r = rand(v_vTexcoord,seed);
    if (r>=0.5) {
        r = 1.0;
    } else {
        r = 0.0;
    };
    vec3 col = vec3(r);
    vec4 fnlclr = vec4(col,0.05);   //second value is intensity
    gl_FragColor = fnlclr * texture2D( gm_BaseTexture, v_vTexcoord );
}
