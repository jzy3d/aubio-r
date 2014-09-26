setwd("/Users/martin/Dev/aubio/aubio-r")
source("aubio.R")
library(seewave)
library(tuneR)


fileSinramp <- "data/sin-ramp.wav";
fileBeatbox <- "data/beatbox.wav";
fileDoremi <- "data/doremi.wav";

#waveBeatbox <- readWave(fileBeatbox)
#waveDoremi <- readWave(fileDoremi)
#waveSinramp <- readWave(fileSinramp)
#play(a)

# ----------------------
# PITCH ON DOREMI

# -p pitch detection algorithm
# -s silence threshold [default=-70]
pitch <- aubiopitch(fileSinramp, paste("-p", aubio.pitch.p[4]))#, "-s", -30)) # 4 mcomb 6 yinfft
plot(pitch, type='p')#'p'

# ignore freq out of range
freqRangeHz = c(note.C0, note.C4)
freqRangeKHz = freqRangeHz/1000
timeRangeS = c(0,1)

pitchFilter = filterFreqRange(pitch, freqRangeHz)
pitchFilter = filterTimeRange(pitchFilter, timeRangeS)
plot(pitchFilter, type='l')#'p'

# compare all algorithms
# par(mfcol=c(length(aubio.pitch.p),1))
# for(i in aubio.pitch.p){
#   print(i)
#   pitch <- aubioPitch(fileDoremi, paste("-p",i))
#   print(pitch)
#   plot(pitch, type='p')#'p'
# }

wave = waveDoremi
input<-inputw(wave=wave,f=f) ; wave<-input$w ; f<-input$f ; rm(input)

from = NULL
to = NULL
if(is.null(from) && is.null(to)) {a<-0; b<-length(wave); from<-0; to<-length(wave)/f}
if(is.null(from) && !is.null(to)) {a<-1; b<-round(to*f); from<-0}
if(!is.null(from) && is.null(to)) {a<-round(from*f); b<-length(wave); to<-length(wave)/f}
if(!is.null(from) && !is.null(to))
{
  if(from>to) stop("'from' cannot be superior to 'to'")
  if(from==0) {a<-1} else {a<-round(from*f)}
  b<-round(to*f)
}
wave<-as.matrix(wave[a:b,])
n<-nrow(wave)
amplitude <- abs(wave)

# subsample ampltude to ensure no more events than nsamples
nsamples = 10000
selection = seq(from=1, to=length(amplitude), by=length(amplitude)/nsamples)
amplitudeSummary = amplitude[selection]
elapsed = selection / 44100
amplitudeOut = cbind(elapsed, amplitudeSummary)

ao = data.frame(amplitudeOut)
ao[,1] <- format(ao[,1], scientific = FALSE)
write.csv(ao, file = "data/doremi-amplitude.csv", quote = FALSE, row.names=FALSE)


plot(amplitudeSummary, type='l')
oscillo(waveDoremi)

# ----------------
## Seewave : Dominant frequency  
spectro(waveDoremi, ovlp=75, zp=8, palette=rev.gray.colors.1, scale=FALSE, flim=freqRangeKHz)
par(new=TRUE)
#dfreq(waveDoremi, ovlp=50, threshold=6, type="l", col="red", lwd=2)

## Seewave : Instantaneous frequency
ifreq(waveDoremi, threshold=6, col="darkviolet", main="Instantaneous frequency with Hilbert transform")

## Seewave : Spectrogram
spectro(waveDoremi, ovlp=50, zp=16, collevels=seq(-40,0,0.5), flim=freqRangeKHZ)
