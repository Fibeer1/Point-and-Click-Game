
TextButton forestResetButton = new TextButton( 320, 400, "Reset" , 50 );

PImage forestBackground;


void beginForestScene() {
    // Load the background if it is not loaded yet
    if ( forestBackground == null ) {
        forestBackground = loadImage( "forest.png" );
    }
}


void doStepWhileInForestScene() {
    // Show the background
    image( forestBackground, 0, 0, width, height );
    forestResetButton.display();

    // handle mouse Pressed
    if ( mousePressed ) {
        if ( forestResetButton.isPointInside( mouseX , mouseY ) ) {
            currentState = RIVER_SCENE;
        }
    }
}


void endForestScene() {
    isAppleTaken = false;
}
