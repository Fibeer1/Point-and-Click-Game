ImageButton    riverUpButton = new ImageButton(    "arrowUp.png", 190, 490 );
ImageButton riverRightButton = new ImageButton( "arrowRight.png", 700, 485 );
HintButton   riverHintButton = new  HintButton( "hint.png", "Find the apple", 50, 690 );

PImage riverBackground;

void beginRiverScene() {
    // Load the background if it is not loaded yet
    if ( riverBackground == null ) {
        riverBackground = loadImage( "river.png" );
    }
}


void doStepWhileInRiverScene() {
    // Show the background
    image( riverBackground, 0, 0, width, height );
    riverRightButton.display();
    if ( isAppleTaken ) {
        riverUpButton.display();
    } else {
        riverHintButton.display();
    }
    
    if ( mousePressed ) {
        if ( riverRightButton.isPointInside( mouseX , mouseY ) ) {
            currentState = LAWN_SCENE;
        }
        if ( isAppleTaken && riverUpButton.isPointInside( mouseX , mouseY ) ) {
            currentState = FOREST_SCENE;
        }
    }
}


void endRiverScene() {
    // reset not necessary in this scene
}
