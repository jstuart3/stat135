
plot(cars, xlab = "Speed (mph)", ylab = "Stopping distance (ft)"
     ,las = 1,pch=16,cex=0.6)
carfit=lm(cars$dist~cars$speed)
abline(carfit$coef,col="green")
title(main = "cars data")

carfit
summary(carfit)
plot(carfit)

