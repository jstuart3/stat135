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

#1a
#finding sample average
x_bar <- mean(my_sample)

#calculating standard error with a built in function
#this is correctly finding s, but s is not the number we want
standard_deviation <- sd(my_sample)

#calculating standard error "by hand"
s <- sqrt((sum((my_sample - x_bar) ^ 2)) / (sample_size - 1))

#calculating standard error 
standard_error <- (s / sqrt(10)) * 
  sqrt((population_size - sample_size) / (population_size - 1))

#constucting a confidence interval
lower_limit <- x_bar - 1.96 * standard_error
upper_limit <- x_bar + 1.96 * standard_error

cat("Our 95% confidence interval for average weight of mothers is [", lower_limit, ",", upper_limit, "]")


#1b 
my_samples <- matrix(nrow = 1000, ncol = 10)
x_bars <- 0
standard_error_values <- 0 
confidence_intervals <- matrix(nrow = 1000, ncol = 2)
confidence_intverval_accuracy <- matrix(nrow = 1000, ncol = 1)
ci_accuracy <- matrix(nrow = 1000, ncol = 1)
true_average <- mean(na.omit(infants$wt))

for (i in 1:1000) {
  my_samples[i, ] = sample(na.omit(infants$wt),10)
  x_bars[i] <- mean(my_samples[i, ])
  standard_error_values[i] <- sd(my_samples[i, 1:10]) / sqrt(10)
  confidence_intervals[i, 1] <- x_bars[i] - 1.96 * standard_error_values[i]
  confidence_intervals[i, 2] <- x_bars[i] + 1.96 * standard_error_values[i]
  ci_accuracy[i] <- (true_average <= confidence_intervals[i, 2] & true_average >= confidence_intervals[i, 1])
}

table(ci_accuracy)

#Based on the definition of confidence intervals, we would expect 950 of them to cover the true average
#sample size is small, so it shouldn't be surprising that normal theory doesn't exactly



#1c

#calculating the SD of means
sd_means <- sd(x_bars)
sd_means

#6.74 vs 4.89

#histogram of sample averages
hist(x_bars)
#yes, approx normal, skewed slightly left

#qqplot of x_bars
qqnorm(x_bars)


#2a

#constructing the bootstrap population
vals = sort(unique(my_sample))
counts = table(my_sample)
# makes the bootstrap pop as rounded version of sample, not quite right
boot_pop <- rep(vals, round(counts * population_size / length(my_sample)))
length(boot_pop)

#sampling from the bootstrap population
boot_pop_sample <- replicate(1000, sample(boot_pop, length(my_sample), FALSE)) 

cat("boot_pop is now a vector of ", length(boot_pop), 
    ", the number of members in the bootstrap population.", sep = "")

cat("boot_pop_sample is now a matrix of ", length(boot_pop_sample[ , 1]), 
    " rows (the number of members per sample), and ", 
    length(boot_pop_sample[1, ]), " columns (the total number of samples).", 
    sep = "")


#calculating the sample averages of the bootstrap samples
boot_x_bars <- 0
for (i in 1:1000) {
  boot_x_bars[i] <- mean(boot_pop_sample[ , i])
}

#histogram of smaple averages
hist(boot_x_bars)
boot_pop_mean <- mean(boot_pop)
abline(v=boot_pop_mean,col="red")

#calculating the sd of the sample averages
sd(boot_x_bars)
#yes! it is pretty close!!

#2b
#getting the quantlies of the bootstrap sample averages
bootstrap_quantile <- quantile(boot_x_bars, probs = seq(0, 1, .025))

#constructing the bootstrap confidence intervals
cat("The 95% confidence interval for the bootstrap population is [", 
    unname(bootstrap_quantile[2]), ", ", unname(bootstrap_quantile[40]), "]")   

#comparing the confidence intervals from the original and bootstrap samples 
cat("The 95% confidence interval for the bootstrap population is [", 
    unname(bootstrap_quantile[2]), ", ", unname(bootstrap_quantile[40]), "]")

cat("Our 95% confidence interval for average weight of mothers is [", lower_limit, ",", upper_limit, "]")