source("aubio.R")

fileBeatbox <- "data/beatbox.wav";
fileDoremi <- "data/doremi.wav";

waveBeatbox <- readWave(fileBeatbow)
waveDoremi <- readWave(fileDoremi)
#play(a)

# -------------------------
# ONSETS ON BEATBOX
onsets <- aubioOnset(fileBeatbox, "-O mkl -t 0.47")
onsetPoints <- cbind(onsets, c(1:length(onsets))*0)

# show onsets with points on AMPLITUDE
oscillo(beatbox)#, type="p", cex=0.1)
points(onsetPoints, col="red", cex=0.3)

# show onsets on STEREO plot
plot(beatbox)
points(onsetPoints, col="red", cex=0.3)