#loading the data
load("data/KaiserBabies.rda")

#population: 1236 of all pregnancies that occurred between 1960 and 1967 among women 
#in the Kaiser Foundation Health Plan in Oakland, CA.

#sample: the 10 women chosen randomly
population_size <- 1236
sample_size <- 10

#taking a simple random sample
set.seed(7)
mysample=sample(na.omit(infants$wt),10)

#finding sample average
x_bar <- mean(mysample)

#sample average as estimate of average weight of mothers
#mu <- x_bar
#this is not necessary

#calculating estimated standard error (Are we calculating one or two SE's?)

#calculating standard error with a built in function - variance of estimate or estimated variance?
#this is correctly finding s, but s is not the number we want
se <- sd(mysample)

#calculating standard error "by hand"
#do fpcf
#this is just s. divide by root n
sqrt((sum((mysample - x_bar) ^ 2)) / (sample_size - 1)) / sqrt(10)

#constucting a confidence interval
lower_limit <- x_bar - 1.96 * se
upper_limit <- x_bar + 1.96 * se

cat("Our 95% confidence interval for average weight of mothers is [", lower_limit, ",", upper_limit, "]")


mysamples <- matrix(nrow = 1000, ncol = 10)
x_bars <- 0
se_values <- sd(mysample) / sqrt(10)
confidence_intervals <- matrix(nrow = 1000, ncol = 2)
ci_accuracy <- matrix(nrow = 1000, ncol = 1)
true_average <- mean(na.omit(infants$wt))

for (i in 1:1000) {
  mysamples[i, ]=sample(na.omit(infants$wt),10)
  x_bars[i] <- mean(mysamples[i, ])
  se_values[i] <- sd(mysamples[i, 1:10]) / sqrt(10)
  confidence_intervals[i, 1] <- x_bars[i] - 1.96 * se_values[i]
  confidence_intervals[i, 2] <- x_bars[i] + 1.96 * se_values[i]
  #ci_accuracy[i] <- x_bars[i] <= confidence_intervals[i, 2] & x_bars[i] >= confidence_intervals[i, 1]
  ci_accuracy[i] <- (true_average <= confidence_intervals[i, 2] & true_average >= confidence_intervals[i, 1])
}

table(ci_accuracy)

#Based on the definition of confidence intervals, we would expect 950 of them to cover the true average

sd_values <- 0
#se_values <- 0

for (i in 1:1000) {
  sd_values[i] <- sd(mysamples[i, ])
  #se_values[i] <- sqrt((sum((mysamples[i, ] - x_bars[i]) ^ 2)) / sqrt(10)#(sample_size - 1))
}

differences <- sd_values - se_values

hist(sd_values)
hist(se_values)

#SD of means
sd_means <- sd(x_bars)
sd_means
