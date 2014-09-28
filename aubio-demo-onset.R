setwd("/Users/martin/Dev/aubio/aubio-r")
source("aubio.R")
library(seewave)
library(tuneR)

fileBeatbox <- "data/beatbox.wav";

waveBeatbox <- readWave(fileBeatbox)
#play(a)

# -------------------------
# BEATS ON BEATBOX
beats = aubiotrack(fileBeatbox, "");
beatPoints <- cbind(beats, c(1:length(beats))*0)

# -------------------------
# ONSETS ON BEATBOX
onsets <- aubioonset(fileBeatbox, "-O mkl -t 0.47")
onsetPoints <- cbind(onsets, c(1:length(onsets))*0)

# show onsets with points on AMPLITUDE
oscillo(waveBeatbox)#, type="p", cex=0.1)
points(onsetPoints, col="red", cex=0.3)
points(beatPoints, col="yellow", cex=0.3)
