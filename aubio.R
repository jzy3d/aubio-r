# --------------------------------------------------
# ----------------   AUBIO API  --------------------
# --------------------------------------------------

library(seewave)
library(tuneR)


note.C0 = 16.35
note.A0 = 27.50
note.C4 = 261.63
note.A4 = 440.00
note.A5 = 880
note.C8 = 4186.0
note.B8 = 7902

filterFreqRange <- function(pitch, freqRangeHz){
  pitchFilter = pitch
  pitchFilter[pitch$frequency < freqRangeHz[1], 2] = NaN
  pitchFilter[pitch$frequency > freqRangeHz[2], 2] = NaN
  return(pitchFilter)
}

filterTimeRange <- function(pitch, timeRange){
  outOfRange <- (pitch[,1] < timeRange[1]) | (pitch[,1] > timeRange[2])
  return(pitch[!outOfRange,])
}

# AUBIO PITCH
aubio.pitch.p = c('default', 'schmitt', 'fcomb', 'mcomb', 'specacf', 'yinfft')
aubioPitch <- function(file, args){
  out = paste(file, ".txt", sep='')
  cmd = paste("aubiopitch", args, inout(file, out))
  print(cmd)
  pitch = cmdRun(cmd, out)
  names(pitch)[1] = "time"
  names(pitch)[2] = "frequency"
  return(pitch)  
}


## AUBIO ONSET
# http://aubio.org/manpages/latest/aubioonset.1.html
aubio.onset.O = c('default', 'energy', 'hfc', 'complex', 'phase', 'specdiff', 'kl', 'mkl', 'specflux')
aubioOnset <- function(file, args){
  out = paste(file, ".txt", sep='')
  cmd = paste("aubioonset", args, inout(file, out))
  print(cmd)
  onsets <- cmdRun(cmd, out)
  return(onsets)  
}

inout <- function(file, out){
  return(paste("-i", file, ">",  out))
}

cmdRun <- function(cmd, out){
  system(cmd)
  aubioOut <- read.table(out)
  return(aubioOut)
}