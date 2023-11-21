/*
  Example for Project First Contact by Douwe van Twillert
*/

// ============ State variables ============

// all state are constants to prevent programming errors
// states get a name, even same names differ so be careful
final String  RIVER_SCENE =  "River Scene";
final String   LAWN_SCENE =   "Lawn Scene";
final String  TABLE_SCENE =  "Table Scene";
final String FOREST_SCENE = "Forest Scene";

String  currentState = RIVER_SCENE;
String previousState = "";


// ============ variables ============
boolean isAppleTaken = false;


void setup(){
  size( 800, 800 );
}

void draw(){
    // check if the currentState was changed so we can end the  
    // (now) previousState and start the currentState
    if ( currentState != previousState ) {
    
        println( "end of " + previousState );
              if ( previousState ==  RIVER_SCENE ) { endRiverScene();  }
         else if ( previousState ==   LAWN_SCENE ) { endLawnScene();   }
         else if ( previousState ==  TABLE_SCENE ) { endTableScene();  }  
         else if ( previousState == FOREST_SCENE ) { endForestScene(); }  
            
        println( "beginning " + currentState );
             if ( currentState ==  RIVER_SCENE ) { beginRiverScene();  }
        else if ( currentState ==   LAWN_SCENE ) { beginLawnScene();   }
        else if ( currentState ==  TABLE_SCENE ) { beginTableScene();  }   
        else if ( currentState == FOREST_SCENE ) { beginForestScene(); }  
            
        // remember the currentState in the previousState
        // we use this to detect if currentState changes later again.
        previousState = currentState;
    }
   
    // handle the current state, do a singe step each draw
         if ( currentState ==  RIVER_SCENE ) { doStepWhileInRiverScene();  }
    else if ( currentState ==   LAWN_SCENE ) { doStepWhileInLawnScene();   }
    else if ( currentState ==  TABLE_SCENE ) { doStepWhileInTableScene();  }    
    else if ( currentState == FOREST_SCENE ) { doStepWhileInForestScene(); }   
}
