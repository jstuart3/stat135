#Week 5
###2/12/18 - 2/16/18
##Topics: Parameter Estimation
##Readings: Nolan.4, Rice.8
##Due: Lab1, HW3 (postponed)

- This course has 4 main parts. 
	1. Sampling
	2. Estimation
	3. Testing
	4. Regression

#Parameter Estimation
###Lecture 11 - 
- we recognize that data are realizations of Random Variables
- parameter estimation is about taking a bunch of observed data, knowing or intuiting the type of distribution it was generated from, and then estimating the parameters of that distriburtion. For example, given a bunch of data, we might guess that the generating distribution were $exponential (\lambda)$, $binomial (n, p)$, or $Poisson (\lambda)$; we are then discussing how to estimate the parameters $\lambda$ or $p$. 
- we can consider some joint distribution of $X_i$ that depends upon some unknown $\theta$, where the $X_i$ are independent and identically distributed random variables with probability density fuctions $f(x\ |\ \theta)$, where $\theta$ can be a vector of parameters. 
- we can estimate $\theta$ as $\hat{\theta}$, with $\theta$ a function of the $X_i$.
- based on the *sampling distribution*, we can assess the variability of our estimate $\hat{\theta}$, and thereby determine the accuracy of the estimate.

###Lecture 12 - 2/12/18
- If you have data that you believe was generated in some way (i.e. $X_i$ ~ some distribution), we then have a way to infer the parameters of the corresponding distribution.
- We recognize that data are realizations of $X_i$, and that the joint distribution of the $X_i$ depends on $\theta$, a parameter or some vector of parameters.
- If the $X_i$ are independent, then the density of the joint distribution is the product of the marginal (?) densities. **Review joint distributions and the associated vocabulary**.
- We take $\hat{\theta}$ to be an estimate of $\theta$, and observe that $\hat{\theta}$ may be a biased or unbiased estimate of $\theta$.
- Since $\hat\theta$ is a function of the data, it is itself a random variable, and so $\mathbb{E} (\hat{\theta}) = \theta$ would mean that $\hat{\theta}$ is an unbiased estimate of ${\theta}$.  

####Method of Moments
