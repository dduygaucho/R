library(dslabs)
library(tidyverse)
library(dplyr)

# Programming basics
  ## Conditional
    ## If-else statement
a <- 0
if (a < 0){
  print("a is less than 0")
} else{
  print("Otherwise")
}

    ## ifelse statement, returns a value ; true, left, else right
ifelse(a>0, a, "hello")
    ## can be used to run on a vector to return a vector
data("na_example")
no_nas <- ifelse(is.na(na_example), 0, na_example)
no_nas
    ## any(x) and all(x): any returns true if at least 1 is true, all if all true



  ## Functions
x <- 1:100
avg <- function(x){
  sum <- sum(x)
  len <- length(x)
  return(sum/len)
}
avg(x)


  ## For loops
s_n <- vector("numeric", 25)

# write a for-loop to store the results in s_n
for (i in 1:25){
  s_n[i] =  compute_s_n(i)
}