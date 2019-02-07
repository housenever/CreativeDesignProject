#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){

  ofSetFrameRate(60);

  int camW = 1280;
  int camH = 720;

  //fern.setup("model.bmp", camW, camH);
  //fern2.setup("corn.jpeg", camW, camH);

  //ferns[0].setup("model.bmp", camW, camH);
  ferns[0].setup("corn.jpeg", camW, camH);
  ferns[1].setup("fish.jpeg", camW, camH);
  //ferns[3].setup("meat.jpeg", camW, camH);
  //ferns[4].setup("rice.jpeg", camW, camH);
  //ferns[5].setup("seeds.jpeg", camW, camH);

  grabber.initGrabber(camW, camH);

  colorImg.allocate(camW, camH);
  img.allocate(camW, camH);

  showTracker = false;

  sender.setup("127.0.0.1", 12000);
}

//--------------------------------------------------------------
void testApp::update(){

  grabber.update();
  //kinect.update();
  if(grabber.isFrameNew()){
    colorImg = grabber.getPixels();
    img = colorImg;
    for (int i = 0; i < ferns.size(); ++i) {
      ferns[i].update(img);
      if (ferns[i].trackedMarker.tracked) {
        ofxOscMessage message;
        message.addIntArg(i);
        message.addFloatArg(ferns[i].trackedMarker.points[0].x);
        message.addFloatArg(ferns[i].trackedMarker.points[0].y);

        message.addFloatArg(ferns[i].trackedMarker.points[1].x);
        message.addFloatArg(ferns[i].trackedMarker.points[1].y);

        message.addFloatArg(ferns[i].trackedMarker.points[2].x);
        message.addFloatArg(ferns[i].trackedMarker.points[2].y);

        message.addFloatArg(ferns[i].trackedMarker.points[3].x);
        message.addFloatArg(ferns[i].trackedMarker.points[3].y);

        sender.sendMessage(message);
      }
    }
  }
}

//--------------------------------------------------------------
void testApp::draw(){

  ofSetColor(255);

  ofSetHexColor(0xFF0000);
  ofNoFill();
  for (auto& fern : ferns) {
    if (fern.trackedMarker.tracked) {
      fern.trackedMarker.draw();
    }
  }
}


//--------------------------------------------------------------
void testApp::keyPressed  (int key){

  switch(key){

    case 'd':
      showTracker = !showTracker;
      break;

    case 't':
      //fern.resetTracker();
      break;

    case 'k':
      //fern.showKeypoints(!fern.getShowKeypoints());
      break;

    case 'l':
      //fern.showLocations(!fern.getShowLocations());
      break;
  }
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){
}
