
ImageButton   lawnUpButton = new ImageButton( "arrowUp.png"  , 320, 550 );
ImageButton lawnDownButton = new ImageButton( "arrowDown.png", 320, 700 );

PImage lawnBackground;


void beginLawnScene() {
    // Load the background if it is not loaded yet
    if ( lawnBackground == null ) {
        lawnBackground = loadImage( "lawn.png" );
    }
}


void doStepWhileInLawnScene() {
    // Show the background
    image( lawnBackground, 0, 0, width, height );
    lawnUpButton.display();
    lawnDownButton.display();

    // handle mouse Pressed
    if ( mousePressed ) {
        if ( lawnUpButton.isPointInside( mouseX , mouseY ) ) {
            currentState = TABLE_SCENE;
        }
        if ( lawnDownButton.isPointInside( mouseX , mouseY ) ) {
            currentState = RIVER_SCENE;
        }
    }
}


void endLawnScene() {
    // reset not necessary in this scene
}
