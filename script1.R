#Quincunx management exercise simulator
#Kevin Little, Ph.D.  12 November 2016

Systime_used <- Sys.time()
set.seed(as.numeric(Systime_used))


#this function will generate values centered at 48 (expected value from binom: np=5, added to offset = 13 and meter set = 30)
single_drop1 <- function(layers=10,offset=13,meter=30){
  tmp <- rbinom(1,layers,0.5)
  finalx <- tmp + offset + meter
}


#Initialize the data frame to hold the data from the simulation
df1 <- data.frame(index1=integer(),value=integer(),meter_setting=integer())

