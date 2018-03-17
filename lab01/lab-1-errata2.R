#loading the data
load("data/KaiserBabies.rda")

#population: 1236 of all pregnancies that occurred between 1960 and 1967 among women 
#in the Kaiser Foundation Health Plan in Oakland, CA.

#sample: the 10 women chosen randomly
population_size <- 1236
sample_size <- 10

#taking a simple random sample
set.seed(7)
my_sample = sample(na.omit(infants$wt),10)

#finding sample average
x_bar <- mean(my_sample)

#calculating standard error with a built in function - variance of estimate or estimated variance?
#this is correctly finding s, but s is not the number we want
standard_deviation <- sd(my_sample)

#calculating standard error "by hand"
#do fpcf
s <- sqrt((sum((my_sample - x_bar) ^ 2)) / (sample_size - 1))
standard_error <- s / sqrt(10) #

#constucting a confidence interval
lower_limit <- x_bar - 1.96 * standard_error
upper_limit <- x_bar + 1.96 * standard_error

cat("Our 95% confidence interval for average weight of mothers is [", lower_limit, ",", upper_limit, "]")


my_samples <- matrix(nrow = 1000, ncol = 10)
x_bars <- 0
x_bars
standard_error_values <- 0 #sd(my_sample) / sqrt(10)
standard_error_values
confidence_intervals <- matrix(nrow = 1000, ncol = 2)
confidence_intervals
confidence_intverval_accuracy <- matrix(nrow = 1000, ncol = 1)
confidence_intverval_accuracy
true_average <- mean(na.omit(infants$wt))
true_average

for (i in 1:1000) {
  my_samples[i, ] = sample(na.omit(infants$wt),10)
  x_bars[i] <- mean(my_samples[i, ])
  standard_error_values[i] <- sd(my_samples[i, 1:10]) / sqrt(10)
  confidence_intervals[i, 1] <- x_bars[i] - 1.96 * standard_error_values[i]
  confidence_intervals[i, 2] <- x_bars[i] + 1.96 * standard_error_values[i]
  #ci_accuracy[i] <- x_bars[i] <= confidence_intervals[i, 2] & x_bars[i] >= confidence_intervals[i, 1]
  ci_accuracy[i] <- (true_average <= confidence_intervals[i, 2] & true_average >= confidence_intervals[i, 1])
}

table(ci_accuracy)

#sample size is small, so it shouldn't be surprising that normal theory doesn't exactly

#Based on the definition of confidence intervals, we would expect 950 of them to cover the true average

standard_deviation_values <- 0
#se_values <- 0

for (i in 1:1000) {
  standard_deviation_values[i] <- sd(my_samples[i, ])
  #se_values[i] <- sqrt((sum((my_samples[i, ] - x_bars[i]) ^ 2)) / sqrt(10)#(sample_size - 1))
}

differences <- standard_deviation_values - standard_error_values

hist(standard_deviation_values)
hist(standard_error_values)

#SD of means
sd_means <- sd(x_bars)
sd_means

hist(x_bars)

bootStrap = function(my_sample, popSize = NULL, B = 1000, repl = FALSE){
  if (repl) {
    # Bootstrap should be done the same way as original sample, usually without rep
    return(replicate(B, mean(sample(my_sample, length(my_sample), TRUE))))
  } else {
    vals = sort(unique(my_sample))
    counts = table(my_sample)
    # makes the bootstrap pop as rounded version of sample, not quite right
    bootPop = rep(vals, round(counts * popSize / length(my_sample)))
    return(list(bootPop, 
                bootSamps = replicate(B,mean(sample(bootPop, length(my_sample), FALSE))))
    )
  }
}

#constructing the bootstrap population
vals = sort(unique(my_sample))
counts = table(my_sample)
popSize = na.omit(infants$wt) #or just 1236
# makes the bootstrap pop as rounded version of sample, not quite right
boot_pop <- rep(vals, round(counts * 1236 / length(my_sample)))

#sampling from the bootstrap population
boot_pop_sample <- replicate(1000, sample(boot_pop, length(my_sample), TRUE)) 
#sample(my_sample, length(my_sample))

cat("boot_pop is now a vector of ", length(boot_pop), 
    ", the number of members in the bootstrap population.", sep = "")

cat("boot_pop_sample is now a matrix of ", length(boot_pop_sample[ , 1]), 
    " rows (the number of members per sample), and ", 
    length(boot_pop_sample[1, ]), " columns (the total number of samples).", 
    sep = "")

#this is doing nothing
#boot <- bootStrap(my_sample, popSize = 1236, B = 1000, repl = TRUE)

#calculating the sample averages of the bootstrap samples
boot_x_bars <- 0
for (i in 1:1000) {
  boot_x_bars[i] <- mean(boot_pop_sample[ , i])
}

mean(boot_pop)
hist(boot)
mean(boot)

#contructing boot pop
vals = sort(unique(my_sample))
counts = table(my_sample)
popSize = na.omit(infants$wt) #or just 1236
# makes the bootstrap pop as rounded version of sample, not quite right
bootPop = rep(vals, round(counts * 1236 / length(my_sample)))

boot_pop_mean <- mean(boot_pop)

hist(boot_x_bars)
abline(v=boot_pop_mean,col="red")

#calculating the sd of the sample averages
sd(boot_x_bars)
#yes! it is pretty close!!

#getting the quantlies of the bootstrap sample averages
bootstrap_quantile <- quantile(boot_x_bars, probs = seq(0, 1, .025))

#constructing the bootstrap confidence intervals
bootstrap_confidence_intervals <- matrix(nrow = 1000, ncol = 2)
for (i in 1:1000) {
  #my_samples[i, ] = sample(na.omit(infants$wt),10)
  #x_bars[i] <- mean(my_samples[i, ])
  #standard_error_values[i] <- sd(my_samples[i, 1:10]) / sqrt(10)
  bootstrap_confidence_intervals[i, 1] <- boot_x_bars[i] - 1.96 * standard_error_values[i]
  bootstrap_confidence_intervals[i, 2] <- boot_x_bars[i] + 1.96 * standard_error_values[i]
  #ci_accuracy[i] <- x_bars[i] <= confidence_intervals[i, 2] & x_bars[i] >= confidence_intervals[i, 1]
  ci_accuracy[i] <- (true_average <= confidence_intervals[i, 2] & true_average >= confidence_intervals[i, 1])
}


cat("The 95% confidence interval for the bootstrap population is [", 
    unname(bootstrap_quantile[2]), ", ", unname(bootstrap_quantile[40]), "]")   


