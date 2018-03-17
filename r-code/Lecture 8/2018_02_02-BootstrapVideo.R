bootStrap = function(mySample, popSize = NULL, B = 1000, repl = FALSE){
  if (repl) {
    # Bootstrap should be done the same way as original sample, usually without rep
    return(replicate(B, mean(sample(mySample, length(mySample), TRUE))))
  } else {
    vals = sort(unique(mySample))
    counts = table(mySample)
    # makes the bootstrap pop as rounded version of sample, not quite right
    bootPop = rep(vals, round(counts * popSize / length(mySample)))
    return(list(bootPop, 
                bootSamps = replicate(B,mean(sample(bootPop, length(mySample), FALSE))))
           )
  }
}

load(("/Users/hankibser/Dropbox/0Teaching/0S135/Code/videogame.rda"))

#Video Game data from 1994, sample of 91 out of class of 314
videoSample =video$time
videoSample
length(videoSample)
hist(videoSample, breaks = 30)
mean(videoSample)

# Our class bootstrap averages
videohours=c(0,0,1,0,0,3,5,0,1,5,1)
mean(videohours)
bootSampAvgs = bootStrap(videohours, popSize = 210)
length(bootSampAvgs[[2]])
head(bootSampAvgs[[2]])
mean(bootSampAvgs[[2]])
hist(bootSampAvgs[[2]], breaks = 50)
plot(density(bootSampAvgs[[2]],adjust=0.5))
qqnorm(bootSampAvgs[[2]])
qqline(bootSampAvgs[[2]])

bootResults = bootStrap(videoSample, popSize = 314,B=10000)
# bootstrap pop
table(bootResults[[1]])
table(videoSample)
mean(bootResults[[1]])
hist(bootResults[[1]], breaks = 50)

# sample averages
length(bootResults[[2]])
head(bootResults[[2]])
mean(bootResults[[2]])
hist(bootResults[[2]], breaks = 50)
plot(density(bootResults[[2]],adjust=0.5))
qqnorm(bootResults[[2]])
qqline(bootResults[[2]])
