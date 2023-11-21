ImageButton tableAppleButton = new ImageButton( "apple.png"    , 325, 366 );
ImageButton  tableDownButton = new ImageButton( "arrowDown.png", 320, 700 );

PImage tableBackground;

void beginTableScene() {
    // Load the background if it is not loaded yet
    if ( tableBackground == null ) {
        tableBackground = loadImage( "table_with_apples.png" );
    }
}


void doStepWhileInTableScene() {
    // Show the background
    image( tableBackground, 0, 0, width, height );
    tableDownButton.display();
    if ( ! isAppleTaken ) {
        tableAppleButton.display();
    }
    
    if ( mousePressed ) {
        if ( ! isAppleTaken && tableAppleButton.isPointInside( mouseX , mouseY ) ) {
            isAppleTaken = true;
        }
        if ( tableDownButton.isPointInside( mouseX , mouseY ) ) {
            currentState = LAWN_SCENE;
        }
    }
}


void endTableScene() {
    // reset not necessary in this scene
}
