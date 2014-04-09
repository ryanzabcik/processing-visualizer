import ddf.minim.*;
import ddf.minim.analysis.*;

Minim m;
AudioSource src; 
FFT fft;
int averages = 20;
boolean useFile = true;
boolean useMic  = !useFile;

void setup() {
  background(0x0);
  stroke(255,255,255);
  size(640, 480);
  m = new Minim(this);
  
  if (useFile){
    src = m.loadFile("/Users/ryan/Music/Google Music/17_Xylox/1-05 Lovesong.mp3");
    ((AudioPlayer)src).play();
  }
  else if (useMic){
    src = m.getLineIn();
  } 
  
  fft = new FFT(src.bufferSize(), src.sampleRate());
  fft.linAverages(averages);
}

void draw() {
  fill(0,0,0,20);
  rect(-1,-1,width+1,height+1);

  fft.forward(src.mix.toArray());  
  for (int i = 1; i < averages; i++)  {
    int bandHeight = (int)(fft.getAvg(i) * 4);
    fill(255*sin((float)(Math.PI*bandHeight*4/height)),125,125);
    rect(averages * 4 * (i-1) + width / averages / 2, height - bandHeight * 4, width / averages, bandHeight * 4);
  }
}
