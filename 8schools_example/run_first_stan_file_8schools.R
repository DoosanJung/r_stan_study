# My first RStan run
getwd()
setwd('/Users/doosansmacbookpro/Documents/Projects/r_stan_study/8schools_example')

library("rstan")
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

# Prepare the data (which typically is a named list)
schools_dat <- list(J = 8, 
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))

# Fit
fit <- stan(
  file = "8schools.stan",  # Stan program
  data = schools_dat,    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 2,              # number of cores (could use one per chain)
  refresh = 0             # no progress shown
)

# Fit result
print(fit, pars=c("theta", "mu", "tau", "lp__"), probs=c(.1,.5,.9))
plot(fit)
traceplot(fit, pars = c("mu", "tau"), inc_warmup = TRUE, nrow = 2)
pairs(fit, pars = c("mu", "tau", "lp__"))

la <- extract(fit, permuted = TRUE) # return a list of arrays 
mu <- la$mu 

### return an array of three dimensions: iterations, chains, parameters 
a <- extract(fit, permuted = FALSE) 

### use S3 functions on stanfit objects
a2 <- as.array(fit)
m <- as.matrix(fit)
d <- as.data.frame(fit)
