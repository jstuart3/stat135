

data <- c(31, 29, 19, 18, 31, 28, 34, 27, 34, 30, 16, 18,
          26, 27, 27, 18, 24, 22, 28, 24, 21, 17, 24)

normal_data <- rnorm(length(data), mean(data), sqrt(mean(data)/length(data)))

require(graphics)
dnorm(length(data), mean(data), sqrt(mean(data)/length(data)))

hx <- dnorm(data, mean = 24.9, sd = 1.04)


plot(data, hx, type = "p")


data = c()