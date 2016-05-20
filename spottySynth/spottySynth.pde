import beads.*;

AudioContext setUpPatch;
AudioContext filterPatch;
WavePlayer wp;
WavePlayer filterModulator;
Gain filterPatchGain;
Gain g;
Glide noteFrequency;
Glide modulatorFrequency;
Glide filterModulatorFrequency;
Envelope gainEnvelope;
Envelope filterGainEnvelope;
OnePoleFilter filter1;
boolean pen;
boolean patch1;
TapIn delayIn;
TapOut delayOut;
Gain delayGain;
TapIn delayInR;
TapOut delayOutR;
Gain delayGainR;

void makeCanvas() {
  background(#1fa5b1);
//KEYBOARD OUTLINE
//KEYBOARD is 405px w and 100px h
  stroke(0);
  rect(310, 490, 30, 100);
  stroke(0);
  rect(340, 490, 30, 100);
  stroke(0);
  rect(370, 490, 30, 100);
  stroke(0);
  rect(400, 490, 30, 100);
  stroke(0);
  rect(430, 490, 30, 100);
  stroke(0);
  rect(460, 490, 30, 100);
  stroke(0);
  rect(490, 490, 30, 100);
  stroke(0);
  rect(520, 490, 30, 100);
  stroke(0);
  rect(550, 490, 30, 100);
  stroke(0);
  rect(580, 490, 30, 100);
  stroke(0);
  rect(332, 490, 15, 60);
  stroke(0);
  rect(362, 490, 15, 60);
  stroke(0);
  rect(422, 490, 15, 60);
  stroke(0);
  rect(452, 490, 15, 60);
  stroke(0);
  rect(482, 490, 15, 60);
  stroke(0);
  rect(542, 490, 15, 60);
  stroke(0);
  rect(572, 490, 15, 60);
}

void setup() {
  size(920,615);
//SETS UP FOR THE SYNTHESIZER
  setUpPatch = new AudioContext();
  gainEnvelope = new Envelope(setUpPatch, 0.0);
  noteFrequency = new Glide(setUpPatch, 20, 10);
  WavePlayer wp = new WavePlayer(setUpPatch, noteFrequency, Buffer.SINE);
  g = new Gain(setUpPatch, 1, gainEnvelope);
  g.addInput(wp);
  setUpPatch.out.addInput(g);
//FILTER PATCH OSC
  filterGainEnvelope = new Envelope(setUpPatch, 0.0);
  filterModulatorFrequency = new Glide(setUpPatch, 20, 30);
  WavePlayer filterOsc1 = new WavePlayer(setUpPatch, noteFrequency, Buffer.SINE);
  filterModulator = new WavePlayer(setUpPatch, filterModulatorFrequency, Buffer.SAW);
  Function frequencyModulation = new Function(filterModulator) {
     public float calculate() {
     return (x[0] * 100.0) + (mouseY);
    }
  };
  filter1 = new OnePoleFilter(setUpPatch, frequencyModulation);
  filterPatchGain = new Gain(setUpPatch, 1, filterGainEnvelope);
  filter1.addInput(filterOsc1);
  filterPatchGain.addInput(filter1);
  setUpPatch.out.addInput(filterPatchGain);

//DELAY FOR FILTER OSCILLATOR
  delayIn = new TapIn(setUpPatch, 5000);
  delayIn.addInput(filterPatchGain);
  delayOut = new TapOut(setUpPatch, delayIn, filterModulatorFrequency);
  delayGain = new Gain(setUpPatch, 1, 0.30);
  delayGain.addInput(delayOut);
  delayIn.addInput(delayGain);
  setUpPatch.out.addInput(delayGain);
//START THE AUDIO CONTEXT
  setUpPatch.start();
  //SETS UP THE CANVAS WITH BACKGROUND AND KEYBOARD
  makeCanvas();
}



void draw() {
  if(patch1 == true) {
    float value = random(mouseX,10);
    translate(width/2,height/2);
    rotate(mouseX);
    fill(random(255),random(255),random(255));
    ellipse(mouseX-100,value,mouseY,value);
  }

  if (pen == true) {
    filterModulatorFrequency.setValue((mouseX + 100));
    float value = random(10,40);
    fill(random(255),random(255),random(255));
    ellipse(mouseX,mouseY,value,value);
  }
}

void mousePressed() {
  if (pen == false) {
    pen = true;
  }else {
    pen = false;
  }
}

//TURN ON AND OFF THE PSYCHEDELIC ELLIPSE TRIGGERED BY THE KEY '1'
void patch1() {
  if (patch1 == false){
    patch1 = true;
  } else {
    patch1 = false;
  }
}

void keyPressed() {
  if (key=='1') {
    patch1();
  }
//CLEAR THE SCREEN WITH A FRESH CANVAS
  if(key == 'q' || key == 'Q') {
    makeCanvas();
   }
//KEYPRESS NOTES FOR THE KEYBOARD AND OSCILLATOR FREQUENCY
  fill(255);
  if(key=='a' || key=='A'){
    noteFrequency.setValue(262);

    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(310, 490, 30, 100);

  fill(255);
  if (key=='s' || key=='S'){
    noteFrequency.setValue(294);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(340, 490, 30, 100);

  fill(255);
  if (key=='d' || key=='D'){
    noteFrequency.setValue(330);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(370, 490, 30, 100);

  fill(255);
  if (key=='f' || key=='F'){
    noteFrequency.setValue(349);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(400, 490, 30, 100);

  fill(255);
  if (key=='g' || key=='G'){
    noteFrequency.setValue(392);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(430, 490, 30, 100);

  fill(255);
  if (key=='h' || key=='H'){
    noteFrequency.setValue(440);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(460, 490, 30, 100);

  fill(255);
  if (key=='j' || key=='J'){
    noteFrequency.setValue(494);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
  fill(random(255),random(255),random(255));
  }
  rect(490, 490, 30, 100);

  fill(255);
  if (key=='k' || key=='K'){
    noteFrequency.setValue(523);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
  fill(random(255),random(255),random(255));
  }
  rect(520, 490, 30, 100);

  fill(255);
  if (key=='l' || key=='L'){
    noteFrequency.setValue(587);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(550, 490, 30, 100);

  fill(255);
  if (key==';' || key==':'){
    noteFrequency.setValue(659);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(580, 490, 30, 100);

  fill(255);
  if (key=='w' || key=='W'){
    noteFrequency.setValue(278);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(332, 490, 15, 60);

  fill(255);
  if (key=='e' || key=='E'){
    noteFrequency.setValue(311);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(362, 490, 15, 60);

  fill(255);
  if (key=='t' || key=='T'){
    noteFrequency.setValue(370);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(422, 490, 15, 60);

  fill(255);
  if (key=='y' || key=='Y'){
    noteFrequency.setValue(415);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
   }
  rect(452, 490, 15, 60);

  fill(255);
  if (key=='u' || key=='U'){
    noteFrequency.setValue(466);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(482, 490, 15, 60);

  fill(255);
  if (key=='o' || key=='O'){
    noteFrequency.setValue(554);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(542, 490, 15, 60);

  fill(255);
  if (key=='p' || key=='P'){
    noteFrequency.setValue(622);
    if (pen == false) {
      gainEnvelope.addSegment(0.2, 5);
    } else {
      filterGainEnvelope.addSegment(0.2, 5);
    }
    fill(random(255),random(255),random(255));
  }
  rect(572, 490, 15, 60);
}

void keyReleased() {
    filterGainEnvelope.addSegment(0.0, 100);
    gainEnvelope.addSegment(0.0, 100);
}