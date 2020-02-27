// A simple linear regression with a single predictor and a slope and intercept coefficient, 
// and normally distributed noise.
// This model has improper priors for the two regression coefficients.
// The constraint lower=0 in the declaration of sigma constrains 
// the value to be greater than or equal to 0. With no prior in 
// the model block, the effect is an improper prior on non-negative real numbers. 

data {
  int<lower=0> N;   // N observations
  vector[N] x;      // each with predictor x[N]
  vector[N] y;      // outcome y[N]
}
parameters {
  real alpha;   // the intercept
  real beta;   // the slope
  real<lower=0> sigma;   // a normally distributed noise term with scale sigma. 
}
model {
  y ~ normal(alpha + beta * x, sigma);
}
