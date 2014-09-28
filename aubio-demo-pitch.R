setwd("/Users/martin/Dev/aubio/aubio-r")
source("aubio.R")
library(seewave)
library(tuneR)

fileSinramp <- "data/sin-ramp.wav";

# ----------------------
# PITCH

# -p pitch detection algorithm
# -s silence threshold [default=-70]
pitch <- aubiopitch(fileSinramp, paste("-p", aubio.pitch.p[4]))#, "-s", -30)) # 4 mcomb 6 yinfft
plot(pitch, type='p')

# ignore freq out of range and out of 1s time window
freqRangeHz = c(note.C0, note.C4)
freqRangeKHz = freqRangeHz/1000
timeRangeS = c(0,1)

pitchFilter = filterFreqRange(pitch, freqRangeHz)
pitchFilter = filterTimeRange(pitchFilter, timeRangeS)
plot(pitchFilter, type='l')#'p'
