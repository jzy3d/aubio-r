setwd("/Users/martin/Dev/aubio/aubio-r")
source("aubio.R")

fileBeatbox <- "data/beatbox.wav";
fileDoremi <- "data/doremi.wav";

waveBeatbox <- readWave(fileBeatbox)
waveDoremi <- readWave(fileDoremi)
#play(a)

# ----------------------
# PITCH ON DOREMI

# -p pitch detection algorithm
# -s silence threshold [default=-70]
pitch <- aubioPitch(fileDoremi, paste("-p", aubio.pitch.p[6]))#, "-s", -30)) # 4mcomb yinfft
plot(pitch, type='p')#'p'

# ignore freq out of range
freqRangeHz = c(note.C0, note.C4)
freqRangeKHz = freqRangeHz/1000
timeRangeS = c(0,1)

pitchFilter = filterFreqRange(pitch, freqRangeHz)
pitchFilter = filterTimeRange(pitchFilter, timeRangeS)
plot(pitchFilter, type='l')#'p'


par(mfcol=c(length(aubio.pitch.p),1))
for(i in aubio.pitch.p){
  print(i)
  pitch <- aubioPitch(fileDoremi, paste("-p",i))
  print(pitch)
  plot(pitch, type='p')#'p'
}

# ----------------
## Seewave : Dominant frequency  
spectro(waveDoremi, ovlp=75, zp=8, palette=rev.gray.colors.1, scale=FALSE)
par(new=TRUE)
dfreq(waveDoremi, ovlp=50, threshold=6, type="l", col="red", lwd=2)

## Seewave : Instantaneous frequency
ifreq(waveDoremi, threshold=6, col="darkviolet", main="Instantaneous frequency with Hilbert transform")

## Seewave : Spectrogram
spectro(waveDoremi, ovlp=50, zp=16, collevels=seq(-40,0,0.5), flim=freqRangeKHZ)
