#include "colors.inc"
#include "woods.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc" 
#include "shapes3.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

//-----------------------------------------------------------------------------
#version 3.7; // 3.6;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//-----------------------------------------------------------------------------
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <9.0 , 4.0 ,-10.0>//camera location          //8
                            //location  <5,6, -2.5>//temp
                            right     x*image_width/image_height
                            look_at   <4.0 , 0.5 , 0.0> //look at position
                            //look_at   <5,-1.12, -3.5>//temp
                            rotate<0,-30*(clock),0> 
                           //rotate <0,-50,0>//temp
                                                             }

camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source {< 2, 13, -10> color White } 
// sky ---------------------------------------------------------------------
light_source{ <-1000, 800, 3000> 
              color White
              looks_like{ sphere{ <0,0,0>, 200 
                                  texture{ pigment{ color White*0.9 }
                                           normal { bumps 1.5
                                                    scale 20    }
                                           finish { ambient 0.8   
                                                    diffuse 0.2
                                                    phong 1     }
                                                  
                                         } // end of texture
                                } // end of sphere
                        } //end of looks_like
            } //end of light_source

// sky ---------------------------
plane{<0,1,0>,1 hollow
       texture{
        pigment{ bozo turbulence 0.92
          color_map {
           [0.00 rgb <0.2, 0.3, 1>*0.5]
           [0.50 rgb <0.2, 0.3, 1>*0.8]
           [0.70 rgb <1,1,1>]
           [0.85 rgb <0.25,0.25,0.25>]
           [1.0 rgb <0.5,0.5,0.5>]}
          scale<1,1,1.5>*2.5
          translate<1.0,0,-1>
          }// end of pigment
        finish {ambient 1 diffuse 0}
        }// end of texture
        scale 10000
     }// end of plane
     
  // the clouds 
plane{ <0,1,0>,1 hollow  
       texture{pigment{ bozo turbulence 0.76
                        color_map { [0.5  rgbf<1.0,1.0,1.0,1.0> ]
                                    [0.6  rgb <1.0,1.0,1.0>     ]
                                    [0.65 rgb <1.5,1.5,1.5>     ]
                                    [1.0  rgb <0.5,0.5,0.5>     ] }
                       }
               finish { ambient 0.25 diffuse 0} 
              }      
       scale 500}

// fog ---------------------------------------------------------------------
fog{ fog_type   2
     distance   50
     color      White
     fog_offset 0.1
     fog_alt    2.0
     turbulence 0.8
   }

// sea ---------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ Polished_Chrome
                normal {waves 0.9 phase clock turbulence 2 } 
                finish { reflection 0.60}
              }
     }
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------  

/* Chess Board */
box{<0,0,0> <1,1,0.01> //<9.75,0.01,8.25> <-2.25,0.0,-3.75> 
                texture{
                        pigment{image_map{png "chessBoard2.png"}}
                       } 
                        //scale<1.5,0,1.5> translate<0.75,0,0.75>
                       rotate<90,0,0>
                       scale<12,10,12>    
                       translate<-2.25,0.1,-3.7>  
   }
 
/*  PAWNS */ 
#declare pawn_body =  union
{
    #declare R = 2;//radious of the circle 
    #declare r = 0.8;//radius of the rod that is coiled to form the helix
    #declare L = 1;//length of the helix (the vertical or y-distance between each pair of points);
    #declare P = 0.3;   
    
    #declare points = 13;
    #declare pt = 0;
    
    sphere_sweep
    {
        b_spline points +1
        <0,0,0>, 1
        #while(pt < points)
        <R*cos(pt*P)+5*R*cos(pt*P*0.1), pt*L, R*sin(pt*P)+5*R*sin(pt*P*0.1)>,r
        #declare r= r+ 0.2;
        #declare pt = pt + 1;
        #end
    }  
    scale 0.1 
    translate<0.1,0,0>   

}

#declare bottom = cylinder { <0,0,0>,<0,0.1,0>, 0.30 

           texture { pigment { color rgb<0,0,> }
                   //normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                     finish  { phong 0.5 reflection{ 0.00 metallic 0.00} } 
                   } // end of texture

           scale <2,1,2> rotate<0,0,0> translate<0.8,1.2,0.3>
         } // end of cylinder -------------------------------------


//from top to bottom
//2nd
#declare pawn_circle1 = torus { 0.035,0.035 
        texture {  
                  finish { phong 0.4 }
                } // end of texture
        scale <1,1,1> rotate<130,-75,10> translate<0.86,0.50,0.4>
      } // end of torus  -------------------------------

//3rd
#declare pawn_circle2 = torus { 0.04,0.04 
texture { 
          finish { phong 0.4 }
        } // end of texture
scale <1,1,1> rotate<130,-110,0> translate<0.75,0.7,0.3>
} // end of torus  -------------------------------   

//4th
#declare pawn_circle3 = torus { 0.04,0.04 
texture { 
          finish { phong 0.4 }
        } // end of texture
scale <1,1,1> rotate<110,-60,0> translate<0.7,0.8,0.5>
} // end of torus  -------------------------------    

//5th
#declare pawn_circle4 = torus { 0.04,0.04 
texture {  
          finish { phong 0.4 }
        } // end of texture
scale <1,1,1> rotate<105,-100,0> translate<0.57,0.95,0.3>
} // end of torus  ------------------------------- 

//1st
#declare pawn_circle5 = torus { 0.032,0.032 
texture {  
          finish { phong 0.4 }
        } // end of texture
        scale <1,1,1> 
        rotate<135,-85,0> 
        translate<1.02,0.35,0.3>
} // end of torus  -------------------------------                
    
                                                  
//pawn green
#declare pawn_green = union{ 
                        object{pawn_body}
                        object{bottom}
                        object {pawn_circle1  pigment{color  rgb <1, 1, 0>}}
                        object {pawn_circle2  pigment{color  rgb <1, 1, 0>}} 
                        object {pawn_circle3  pigment{color  rgb <1, 1, 0>}}
                        object {pawn_circle4  pigment{color  rgb <1, 1, 0>}}
                        object {pawn_circle5  pigment{color  rgb <1, 1, 0>}}
                        }

//pawn purple
#declare pawn_purple = union{ 
                        object{pawn_body}
                        object{bottom}
                        object {pawn_circle1  pigment{color  Green}}
                        object {pawn_circle2  pigment{color  Green}} 
                        object {pawn_circle3  pigment{color  Green}}
                        object {pawn_circle4  pigment{color  Green}}
                        object {pawn_circle5  pigment{color  Green}}
                        }
                        
                        
//tower ------------------------------------------------------//               
#declare tower_body =  //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder (<0,0,0>, <0,1.2,0>, 0.40, 0.10,0)  

// ---------------------------------------------------------
#declare tower_eye = sphere { <0,0,0>, 0.15   
         scale<1,0.55,1>
         rotate<90,0,0>  
         translate<0.8,2.1,-0.01>  
       }  // end of sphere --------------------------------------------------

// ---------------------------------------------------------
#declare tower_eye_inside = sphere { <0,0,0>, 0.11   
         scale<0.6,0.55,1>
         rotate<90,0,0>  
         translate<0.8,2.1,-0.04>  
       }  // end of sphere --------------------------------------------------
       
// ---------------------------------------------------------
#declare tower_hair = sphere_sweep {
    b_spline
    6,
    < -3, -3.0, 0>, 0.90,
    <-3.0, -1.0, 0>, 0.88,
    <-2.5, 0.0, 0>, 0.75,
    <-1, 0.0, 0>, 0.70,
    <1.0, 0.0, 0>, 0.40,
    < 4, 6.0, 0>, 0.30
    tolerance 0.1
    
    scale<0.15,0.15,0.15>     
   }  // end of sphere_sweep ----------------------------
   
// ---------------------------------------------------------
#declare tower_legs = sphere_sweep {
    b_spline
    4,
    < -3, -3.0, 0>, 0.04,
    <-3.0, -1.0, 0>, 0.3,
    <-2.5, 0.0, 0>, 0.5,
    <-1, 0.0, 0>, 0.65
    tolerance 0.1
    
   scale <0.25,0.25,0.25>   
   }  // end of sphere_sweep ---------------------------- 


                         
#declare tower_green = union{
                        object{bottom translate<0,0,0.1>}
                        object{tower_body translate<0.8,1.36,0.35>}
                        object{tower_eye  pigment{color rgb<1,1,1>}}
                        object{tower_eye_inside  pigment{color rgb<0,0,0>}}
                        object{tower_hair rotate<0,0,0> translate<1.46, 2.76, 0.35>}
                        object{tower_hair rotate<0,90,0> translate<0.78, 2.76, -0.26>}
                        object{tower_hair rotate<0,-90,0> translate<0.78, 2.76, 0.96>}
                        object{tower_hair rotate<0,180,0> translate<0.14, 2.76, 0.35>}
                        object{tower_legs translate <-0.15, 1.65, 0.8>  rotate <0,90,0>}
                        object{tower_legs translate <0.6, 1.63, -0.8>  rotate <0,-90,0> }
                        object{tower_legs translate <-0.6, 1.63, -0.5>  rotate <0,-180,0> }
                        object{tower_legs translate <1, 1.63, 0.5>  rotate <0, 0,0> }    
                        }   
                        

//knight ------------------------------------------------------//

#declare knight_body = sphere_sweep {
    b_spline
    4,
    < -3, -3.0, 0>, 0.75,
    <-3.0, -1.0, 0>, 0.75,
    <-2.5, 0.0, 0>, 0.65,
    <-0.5, 0.0, 0>, 0.50
    tolerance 0.1
    
   scale <0.70,0.70,0.70>   
   }  // end of sphere_sweep ----------------------------
   
#declare knight_eye_1 = sphere { <0,0,0>, 1.25  
         scale<0.08,0.02,0.08>
         rotate <45,90,0>
         
         texture { pigment{ color Black}
                 } // end of texture
       }  // end of sphere --------------------------------------------------

#declare knight_eye_2 = sphere { <0,0,0>, 1.25  
     scale<0.08,0.02,0.08>
     rotate <-45,90,0>
     
     texture { pigment{ color Black}
             } // end of texture
   }  // end of sphere --------------------------------------------------  

#declare knight_something1 = sphere_sweep {
    b_spline
    6,
    < -5.0, 0.2, 0>, 0.50,
    <-3.0, 0.3, 0>, 0.50,
    <-1.0, 0.4, 0>, 0.50,
    <1.0, 0.5, 0>, 0.45,
    <1.5, 2.0, 0>, 0.35,
    <1.8, 7.0, 0>, 0.15
    tolerance 0.1
    
    scale<0.17,0.17,0.17>
    
    rotate<75,65,90>    
   }  // end of sphere_sweep ----------------------------

#declare knight_something2 = sphere_sweep {
    b_spline
    6,
    < -5.0, 0.2, 0>, 0.50,
    <-3.0, 0.3, 0>, 0.50,
    <-1.0, 0.4, 0>, 0.50,
    <1.0, 0.5, 0>, 0.45,
    <1.5, 2.0, 0>, 0.35,
    <1.8, 7.0, 0>, 0.15
    tolerance 0.1
    
    scale<0.17,0.17,0.17>
    
    rotate<50,75,90>    
   }  // end of sphere_sweep ----------------------------

#declare knight_something3 = sphere_sweep {
    b_spline
    6,
    < -5.0, 0.2, 0>, 0.50,
    <-3.0, 0.3, 0>, 0.50,
    <-1.0, 0.4, 0>, 0.50,
    <1.0, 0.5, 0>, 0.45,
    <1.5, 2.0, 0>, 0.35,
    <1.8, 7.0, 0>, 0.15
    tolerance 0.1
    
    scale<0.17,0.17,0.17>
    
    rotate<120,75,90>    
   }  // end of sphere_sweep ----------------------------
   
#declare knight_something4 = sphere_sweep {
    b_spline
    6,
    < -5.0, 0.2, 0>, 0.50,
    <-3.0, 0.3, 0>, 0.50,
    <-1.0, 0.4, 0>, 0.50,
    <1.0, 0.5, 0>, 0.45,
    <1.5, 2.0, 0>, 0.35,
    <1.8, 7.0, 0>, 0.15
    tolerance 0.1
    
    scale<0.17,0.17,0.17>
    
    rotate<160,75,90>    
   }  // end of sphere_sweep ----------------------------
   
#declare knight_something5 = sphere_sweep {
    b_spline
    6,
    < -5.0, 0.2, 0>, 0.50,
    <-3.0, 0.3, 0>, 0.50,
    <-1.0, 0.4, 0>, 0.50,
    <1.0, 0.5, 0>, 0.45,
    <1.5, 2.0, 0>, 0.35,
    <1.8, 7.0, 0>, 0.15
    tolerance 0.1
    
    scale<0.17,0.17,0.17>
    
    rotate<45,75,90>    
   }  // end of sphere_sweep ----------------------------     
   

#declare spheree = sphere { <0,0,0>, 0.5 

        texture { pigment{ color Green}
                } // end of texture

          scale<1,1,1> 
       }  // end of sphere ----------------------------------- 

#declare knight_spehere1 = sphere { <0,0,0>, 1.25  
     scale<0.1, 0.055,0.13>
     rotate <-15,0,50>
   }  // end of sphere -------------------------------------------------- 
     
#declare knight_spehere2 = sphere { <0,0,0>, 1.25  
     scale<0.1, 0.055,0.13>
     rotate <-15,0,100>
   }  // end of sphere --------------------------------------------------
   
#declare knight_spehere3 = sphere { <0,0,0>, 1.25  
     scale<0.1, 0.055,0.13>
     rotate <-45,-25,100>
   }  // end of sphere --------------------------------------------------
   
   
   
#declare knight_spehere4 = sphere { <0,0,0>, 1.25  
     scale<0.1, 0.055,0.13>
     rotate <15,0,90>
   }  // end of sphere -------------------------------------------------- 
     
#declare knight_spehere5 = sphere { <0,0,0>, 1.25  
     scale<0.1, 0.055,0.13>
     rotate <45,0,100>
   }  // end of sphere --------------------------------------------------
   
#declare knight_spehere6 = sphere { <0,0,0>, 1.25  
     scale<0.1, 0.055,0.13>
     rotate <45,-25,60>
   }  // end of sphere --------------------------------------------------       


#declare knight_cut = difference{ 
                        object{knight_body translate<1.65,-0.1,-0.8> rotate <-180,90,0>}
                        object{spheree translate<0.8,0.1,-0.9>}
} 
                      
#declare knight_green = union{
                     object{knight_cut}
                     object{bottom translate<0,0,0.1>}
                    object{knight_eye_1 translate<0.5,-0.1,-0.1>}
                    object{knight_eye_2 translate<1.1,-0.1,-0.1>}
                    object{knight_something1 translate<0.8,0.2,-0.6>}
                    object{knight_something2 translate<0.72, 0.14,-0.6>}
                    object{knight_something3 translate<0.9, 0.14,-0.6>}
                    object{knight_something4 translate<0.8, 0.065,-0.6>} 
                    object{knight_something5 translate<0.77, 0.04,-0.6>}
                    object{knight_spehere1 translate<1.2, 0.1, 0.1> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere1 translate<1.2, 0.4, 0.1> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere1 translate<1.2, 0.7, 0.2> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere2 translate<1.3, 0.8, 0.4> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere3 translate<1.05, 0.4, 0.6> pigment{ color rgb <1, 1, 0>}}
                    
                    object{knight_spehere4 translate<0.4, 0.1, 0.1> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere4 translate<0.4, 0.4, 0.1> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere4 translate<0.4, 0.7, 0.2> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere5 translate<0.5, 0.8, 0.4> pigment{ color rgb <1, 1, 0>}}
                    object{knight_spehere6 translate<0.55, 0.5, 0.65> pigment{ color rgb <1, 1, 0>}}
                    
}

#declare knight_purple = union{
                     object{knight_cut}
                     object{bottom translate<0,0,0.1>}
                    object{knight_eye_1 translate<0.5,-0.1,-0.1>}
                    object{knight_eye_2 translate<1.1,-0.1,-0.1>}
                    object{knight_something1 translate<0.8,0.2,-0.6>}
                    object{knight_something2 translate<0.72, 0.14,-0.6>}
                    object{knight_something3 translate<0.9, 0.14,-0.6>}
                    object{knight_something4 translate<0.8, 0.065,-0.6>} 
                    object{knight_something5 translate<0.77, 0.04,-0.6>}
                    object{knight_spehere1 translate<1.2, 0.1, 0.1> pigment{ color Green}}
                    object{knight_spehere1 translate<1.2, 0.4, 0.1> pigment{ color Green}}
                    object{knight_spehere1 translate<1.2, 0.7, 0.2> pigment{ color Green}}
                    object{knight_spehere2 translate<1.3, 0.8, 0.4> pigment{ color Green}}
                    object{knight_spehere3 translate<1.05, 0.4, 0.6> pigment{ color Green}}
                    
                    object{knight_spehere4 translate<0.4, 0.1, 0.1> pigment{ color Green}}
                    object{knight_spehere4 translate<0.4, 0.4, 0.1> pigment{ color Green}}
                    object{knight_spehere4 translate<0.4, 0.7, 0.2> pigment{ color Green}}
                    object{knight_spehere5 translate<0.5, 0.8, 0.4> pigment{ color Green}}
                    object{knight_spehere6 translate<0.55, 0.5, 0.65> pigment{ color Green}}
                    
}
//-------------------------------------------------------------------------

//Bishop
#declare bishop_body = //-------------------------------------------------------------------------
ovus{ 1.00, 0.85 // base_radius, top_radius  with: top_radius< base_radius! 
      scale 0.35
      rotate<0,0,-20>
    } // ------------------------------------------------------------------ 
//-------------------------------------------------------------------------

#declare bishop_feet = sphere { <0,0,0>, 1.25  
         scale<0.23,0.08,0.14>
         rotate<0,0,0>
       }  // end of sphere -------------------------------------------------- 

#declare bishop_head = object{//Round_Cone3( point A, radius A, point B, radius B, merge on) 
         Round_Cone3( <0,0,0>,0.60,     <0,0.80,0>, 0.20 , 0 )  
         scale<0.3,0.3,0.3>  
         rotate<0,0,0>
       } // --------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
#declare bishop_head2 = sphere { <0,0,0>, 1.25  
         scale<0.13,0.08,0.13>
         rotate<0,0,0>
       }  // end of sphere --------------------------------------------------

#declare bishop_eye_1 = sphere { <0,0,0>, 1.2  
     scale<0.08,0.03,0.08>
     rotate <55,0,0>
     
     texture { pigment{ color Black}
             } // end of texture
   }  // end of sphere -------------------------------------------------- 
       
#declare bishop_eye_2 = sphere { <0,0,0>, 1.2  
     scale<0.08,0.03,0.08>
     rotate <133,0,0>
     
     texture { pigment{ color Black}
             } // end of texture
   }  // end of sphere --------------------------------------------------  

#declare bishop_hand = object{ Round_Conic_Prism( 0.85, // >0, vertical center distance of the upper and lower torii
                           0.90, // >0, upper radius up by <0,C_distance,0>
                           0.40, // >0,  lower radius on zero !!!
                           0.60, // >0, length in z-
                           0.30, // border radius, // max. = min(lower radius, upper radius)
                           0 // Merge_On
                         ) // ------------------------------------------------  
          scale<0.2,0.2,0.2>  
          rotate<0,0,180>  
       }  // end of object ---------------------------------------------------
//---------------------------------------------------------------------------- 

#declare bishop_nose = sphere_sweep {
    b_spline
    6,
    < -5.0, 0.0, 0>, 0.50,
    <-1.0, 0.12, 0>, 0.50,
    <0.0, 0.73, 0>, 0.50,
    <1.0, 1.0, 0>, 0.50,
    <2.0, 1.7, 0>, 0.45,
    <4.0, 3.1, 0>, 0.45
    tolerance 0.1
    
    scale<0.17,0.20,0.27>
    
    rotate<0, 180, 60>    
   }  // end of sphere_sweep ---------------------------- 
 
//----------------------------------------------------------------------------
 
#declare bishop_head_obj = union{
                            object{bishop_head  translate<0, 2 ,0>}
                            object{bishop_head2 translate <0,1.78,0>} 
} 
       
#declare bishop_green = union{
                    object{bottom}
                    object{bishop_body translate<0.85,1.7,0.3>}
                    object{bishop_feet translate<0.8, 1.4,0.10>}
                    object{bishop_feet translate<0.8, 1.4,0.5>}
                    object{bishop_head_obj rotate <0,0,-30> translate<0.3,0.7,0.3>}
                    object{bishop_eye_1 translate<0.95,2.18,0.55>}
                    object{bishop_eye_2 translate<0.95,2.18,0.05>}
                    object{bishop_hand translate<0.98,2.0, 0.01>}
                    object{bishop_hand translate<0.98,2.0, 0.71>}
                    object{bishop_nose translate<0.7, 1.9, 0.31>}
                        
}
//----------------------------------------------------------------------------
//king

#declare king_feet = sphere { <0,0,0>, 1.25  
         scale<0.4,0.13,0.25>
         rotate<0,0,0>
       }  // end of sphere --------------------------------------------------
       

#declare king_body =    object{// Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-1,-1,-1>,<1,1,1>, 0.55   , 0)  
        scale<0.45,0.45,0.45>  rotate<0, 0,0>
      } // ---------------------------------------------------------

#declare king_head = sphere { <0,0,0>, 0.53 


          scale<1,1,1>  rotate<0,0,0>
       }  // end of sphere ----------------------------------- 

#declare king_hands1 = object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<0,0,0>, <0,0.55,0>, 0.30 , 0.40,   0)  
                         scale<1.2,0.45,1.2>  
                         rotate<90, -15, 0>
       } // --------------------------------------------------------- 

#declare king_hands2 = object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<0,0,0>, <0,0.55,0>, 0.30 , 0.40,   0)  
                         scale<1.2,0.45,1.2>  
                         rotate<90, 15, 0>
       } // ---------------------------------------------------------

#declare king_eye_1 = sphere { <0,0,0>, 1.2  
     scale<0.085,0.03,0.085>
     rotate <110,130,0>
     
     texture { pigment{ color Black}
             } // end of texture
   }  // end of sphere -------------------------------------------------- 
       
#declare king_eye_2 = sphere { <0,0,0>, 1.2  
     scale<0.085,0.03,0.085>
     rotate <110,50,0>
     
     texture { pigment{ color Black}
             } // end of texture
   }  // end of sphere --------------------------------------------------  


// linear prism in x-direction: from ... to ..., number of points (first = last)
#declare king_face1 = prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        
       rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
       
       scale <0.02, 0.25, 0.07>
       rotate<180,0,-10>//use for rotation 
     } // end of prism --------------------------------------------------------
#declare king_face2 = prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        
       rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
       
       scale <0.02, 0.25, 0.07>
       rotate<190,-20,-10>//use for rotation 
     } // end of prism --------------------------------------------------------
#declare king_face3 = prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        
       rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
      
       scale <0.02, 0.25, 0.07>
       rotate<170,20,-10>//use for rotation 
     } // end of prism --------------------------------------------------------

#declare king_face = union{
                    object{king_face1 translate<-0.01, 0.00, 0.05> }
                    object{king_face1 translate<-0.01, 0.00, -0.05> }
                    object{king_face2 translate<0.013, 0.00, -0.15> }
                    object{king_face3 translate<0.013, 0.00,  0.15> }
}

#declare king_crown_base = cylinder { <0,0,0>,<0, 0.4, 0>, 0.30 open

           texture { pigment { color Yellow }
                   //normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                     finish  { phong 0.5 reflection{ 0.00 metallic 0.00} } 
                   } // end of texture

           scale <1,1,1>
            rotate<0,0,0> 
         } // end of cylinder -------------------------------------

#declare king_crown_cut1 = object{ Hexagon  
        texture{ pigment{ color Yellow }
                 finish { phong 1 }
               }
        scale <0.28,0.28,0.28>*1.00 
        rotate<0,0,90> 
        translate<0,0.5,0>
      } // end of object

//------------------------------------------------------------------------------------------ 


 
#declare king_crown = difference {
                                object{king_crown_base}
                                object{king_crown_cut1}                       
} 
                    
#declare king = union{
                    object{bottom  translate<0, -0.6 ,0> scale <1,2,1>}
                    object{king_feet translate<0.8, 1.45,0.10>}
                    object{king_feet translate<0.8, 1.45,0.5>}
                    object{king_body translate<0.8, 1.9 ,0.3>}
                    object{king_head translate<0.8, 2.65 ,0.3>}
                    object{king_hands1 translate<0.6, 1.92 ,0.65>}
                    object{king_hands2 translate<0.6, 1.92 ,-0.3>}
                    object{king_eye_1 translate<0.4, 2.9 ,0.55>}
                    object{king_eye_2 translate<0.4, 2.9 ,0.05>}
                    object{king_face translate<0.3, 2.65 ,0.30>}
                    object{king_crown translate<0.8, 3.1 ,0.3>}
}

#declare queen_crown = torus { 0.35,0.05 
        texture{ pigment{ color Yellow }
                 finish { phong 1 }
               }
        scale <1,1,1> rotate<0,0,0> translate<0,0.05,0>
      } // end of torus  -------------------------------              




#declare queen = union {
                    object{bottom  translate<0, -0.6 ,0> scale <1,2,1>}
                    object{king_feet translate<0.8, 1.45,0.10>}
                    object{king_feet translate<0.8, 1.45,0.5>}
                    object{king_body translate<0.8, 1.9 ,0.3>}
                    object{king_head translate<0.8, 2.65 ,0.3>}
                    object{king_hands1 translate<0.6, 1.92 ,0.65>}
                    object{king_hands2 translate<0.6, 1.92 ,-0.3>}
                    object{king_eye_1 translate<0.4, 2.9 ,0.55>}
                    object{king_eye_2 translate<0.4, 2.9 ,0.05>}
                    object{king_face translate<0.3, 2.65 ,0.30>}
                    object{queen_crown translate<0.8, 3.1 ,0.3>}
} 

   
/* Display Chess set */
/*Objects are moved by 1.5*/ 


//Green pawns
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35,-3.3>  pigment{color Green}finish { phong 1 }} 
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35,-0.3>  pigment{color Green}finish { phong 1 }} 
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35, 2.8>  pigment{color Green} finish { phong 1 }} 
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35, 5.8>  pigment{color Green} finish { phong 1 }}  

object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35,-1.8>  pigment{color Green}finish { phong 1 }} 
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35,1.4>  pigment{color Green}finish { phong 1 }} 
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35, 4.3>  pigment{color Green} finish { phong 1 }} 
object{pawn_green scale 1 rotate <180,180,0> translate <0.7,1.35, 7.3>  pigment{color Green} finish { phong 1 }}    
//purple pawns
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, -2.6> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 }}
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, 0.3> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 } }
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, 3.3> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 } }
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, 6.3> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 } }

object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, -1.2> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 }}
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, 1.8> pigment{color  rgb <1.53, 0, 1.53>} finish { phong 1 }}
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, 4.8> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 } }
object{pawn_purple scale 1 rotate <180,0,0> translate <6.7,1.35, 7.8> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 } }

//purple tower
object{tower_green translate <-8.4,-1.12, 8.6> rotate<0,90,0> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 }}
object{tower_green translate <2.1,-1.12, 8.6> rotate<0,90,0> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 }}
//green tower
object{tower_green translate <-3.8,-1.12, 1.2> rotate<0,-90,0> pigment{color  Green}finish { phong 1 }}
object{tower_green translate <6.7,-1.12, 1.2> rotate<0,-90,0> pigment{color  Green}finish { phong 1 }}

//knight green
object{knight_green rotate <180,90,0> translate <-1.2,1.35,6.8> pigment{color Green}finish { phong 1 }}
object{knight_green rotate <180,90,0> translate <-1.2,1.35,-0.65> pigment{color Green}finish { phong 1 }}
//knight purple
object{knight_purple rotate <180,-90,0> translate <8.6,1.35,5.3> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 }}
object{knight_purple rotate <180,-90,0> translate <8.6,1.35,-2.3> pigment{color  rgb <1.53, 0, 1.53>}finish { phong 1 }}
   
//bishop purple
object{bishop_green rotate<0,0,0> translate<8.2,-1.15,4.25>  pigment{color rgb <1.53, 0, 1.53>}finish { phong 1 }}
object{bishop_green rotate<0,0,0> translate<8.2,-1.15,-0.25>  pigment{color rgb <1.53, 0, 1.53>}finish { phong 1 }}
//bishop green
object{bishop_green rotate<0,180,0> translate<-0.75,-1.15,4.85>  pigment{color Green}finish { phong 1 }}
object{bishop_green rotate<0,180,0> translate<-0.75,-1.15, 0.35>  pigment{color Green}finish { phong 1 }}

//king purple
object {king rotate<0,0,0> translate<8.2,-1.2 ,2.7> pigment{color rgb <1.53, 0, 1.53>} finish { phong 1 }}
//king green
object {king rotate<0,180,0> translate<-0.75,-1.1,3.3> pigment{color Green} finish { phong 1 }}

//queen purple
object {queen rotate<0,0,0> translate<8.2,-1.2 ,1.25> pigment{color rgb <1.53, 0, 1.53>} finish { phong 1 }}
//queen green
object {queen rotate<0,180,0> translate<-0.75,-1.1,1.8> pigment{color Green} finish { phong 1 }}