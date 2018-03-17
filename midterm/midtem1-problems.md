Stat 135: Midterm 1 Problems
================
Jonathan Stuart
3/5/2018

``` r
library(caTools)
```

\#1
---

``` r
population <- c(1, 2, 2, 4, 8)
mean(population)
```

    ## [1] 3.4

``` r
var(population)
```

    ## [1] 7.8

``` r
sampling_distr <- matrix(nrow = 25, ncol = 2)

#filling up the matrix for the sampling distribution of sample size 2
for(i in 21:25) {
  sampling_distr[i, 1] <- 8
}
```

``` r
samples <- combs(population, 2)
sample_means <- 0
for(i in 1:10) {
  sample_means[i] <- mean(samples[i, ])
}
```
