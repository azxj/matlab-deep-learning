rm(list=ls())

source("./DeepReLU.R")
source("./ReLU.R")
source("./Softmax.R")

X <- array(0, c(5, 5, 5))

X[, , 1] <- matrix(c(
  0, 1, 1, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 1, 0, 0,
  0, 1, 1, 1, 0
), nrow=5, ncol=5, byrow=TRUE)

X[, , 2] <- matrix(c(
  1, 1, 1, 1, 0,
  0, 0, 0, 0, 1,
  0, 1, 1, 1, 0,
  1, 0, 0, 0, 0,
  1, 1, 1, 1, 1
), nrow=5, ncol=5, byrow=TRUE)

X[, , 3] <- matrix(c(
  1, 1, 1, 1, 0,
  0, 0, 0, 0, 1,
  0, 1, 1, 1, 0,
  0, 0, 0, 0, 1,
  1, 1, 1, 1, 0
), nrow=5, ncol=5, byrow=TRUE)

X[, , 4] <- matrix(c(
  0, 0, 0, 1, 0,
  0, 0, 1, 1, 0,
  0, 1, 0, 1, 0,
  1, 1, 1, 1, 1,
  0, 0, 0, 1, 0
), nrow=5, ncol=5, byrow=TRUE)

X[, , 5] <- matrix(c(
  1, 1, 1, 1, 1,
  1, 0, 0, 0, 0,
  1, 1, 1, 1, 0,
  0, 0, 0, 0, 1,
  1, 1, 1, 1, 0
), nrow=5, ncol=5, byrow=TRUE)

D <- matrix(c(
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0,
  0, 0, 0, 0, 1
), nrow=5, ncol=5, byrow=TRUE)

W1 <- array(runif(500, min=-1, max=1), c(20, 25))
W2 <- array(runif(400, min=-1, max=1), c(20, 20))
W3 <- array(runif(400, min=-1, max=1), c(20, 20))
W4 <- array(runif(100, min=-1, max=1), c(5, 20))

for (epoch in 1:10000) { # train
  Ws <- DeepReLU(W1, W2, W3, W4, X, D)
  W1 <- Ws$W1
  W2 <- Ws$W2
  W3 <- Ws$W3
  W4 <- Ws$W4
}

N <- 5 # inference
for (k in 1:N) {
  x <- as.vector(X[, , k])
  v1 <- W1 %*% x
  y1 <- ReLU(v1)

  v2 <- W2 %*% y1
  y2 <- ReLU(v2)

  v3 <- W3 %*% y2
  y3 <- ReLU(v3)

  v <- W4 %*% y3
  y <- Softmax(v)
  print(y)
}
