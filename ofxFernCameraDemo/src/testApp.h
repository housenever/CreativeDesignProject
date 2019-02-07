#pragma once

#include "ofMain.h"

#include "ofxOpenCv.h"
#include "ofxFern.h"
#include "ofxOsc.h"

//#include "ofxKinectV2.h"

class testApp : public ofBaseApp{

  public:

    void setup();
    void update();
    void draw();

    void keyPressed  (int key);
    void mouseMoved(int x, int y );
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);

  ofVideoGrabber grabber;

  ofxCvColorImage colorImg;
  ofxCvGrayscaleImage img;
  std::vector<ofxFern> ferns{2};

    bool showTracker;

  ofxOscSender sender;

  //ofxKinectV2 kinect;
};
