#Quincunx simulator
#function single_drop is taken directly from the quincunx function developed by Yihui Xie in the animations package
library(animation)
Systime_used <- Sys.time()
set.seed(as.numeric(Systime_used))
#set.seed(12345)
# 
# single_drop <- function (balls = 1, 
#                          layers = 15, 
#                          pch.layers = 2, 
#                          pch.balls = 19, 
#                          col.balls = sample(colors(),
#                          balls, TRUE), 
#                          cex.balls = 2, 
#                          offset=12.5,
#                          meter=30) 
# {
#   op = par(mar = c(1, 0.1, 0.1, 0.1), mfrow = c(2, 1))
#   on.exit(par(op))
#   # if (ani.options("nmax") != (balls + layers - 2)) 
#   #   warning("It's strongly recommended that ani.options(nmax = balls + layers -2)")
#   nmax = max(balls + layers - 2, ani.options("nmax"))
#   layerx = layery = NULL
#   for (i in 1:layers) {
#     layerx = c(layerx, seq(0.5 * (i + 1), layers - 0.5 * 
#                              (i - 1), 1))
#     layery = c(layery, rep(i, layers - i + 1))
#   }
#   ballx = bally = matrix(nrow = balls, ncol = nmax)
#   finalx = numeric(balls)
#   for (i in 1:balls) {
#     ballx[i, i] = (1 + layers)/2
#     if (layers > 2) {
#       tmp = rbinom(layers - 2, 1, 0.5) * 2 - 1
#       ballx[i, i + 1:(layers - 2)] = cumsum(tmp) * 0.5 + 
#         (1 + layers)/2
#     }
#     bally[i, (i - 1) + 1:(layers - 1)] = (layers - 1):1
#     finalx[i] = ballx[i, i + layers - 2]
#   }
#   finalx = finalx + offset+meter
#   return(finalx)
# }

#this function will generate values centered at np=5 + 13 + 30 = 48
single_drop1 <- function(layers=10,offset=13,meter=30){
  tmp <- rbinom(1,layers,0.5)
  finalx <- tmp + offset + meter
}

# #set up the 
# random21 <- rbinom(1,1,.5)
# random41 <- rbinom(1,1,.5)


df1 <- data.frame(index1=integer(),value=integer(),meter_setting=integer())

