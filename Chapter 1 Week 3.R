library(dslabs)
library(tidyverse)
data(murders)
# Week 3: Indexing, wrangling and plotting 
  # 3.1: Indexing
    ## Introduction
      ### In python we use df[(df[] > ) & (second condition) & ...]
murder_rate <- murders$total / murders$population * 100000
ind <- murder_rate < 0.71
murders$state[ind]
      ### to count with true false, we use sum not length
sum(ind)
murders$state[murder_rate < 0.71 & murders$region == "West"]
    ## Indexing functions
      ### which is to extract true values from a vector of bool values
      ### !which to find false values
ind <- which(murders$state == 'Massachusetts')
murders$state[ind]
# same result no need for which
murders$state[murders$state == 'Massachusetts']

      ### match is like which but for multiple eles
ind <- match(c("New York", "Florida", "Texas"), murders$state)
      ### %in% is like match but easier to use, most useful
which(murders$state %in% c("New York", "Florida", "Texas"))
  

  # 3.2: Basic data wrangling
library(dplyr)
    ## Introduction
      ### Mutation, adding a new column
murders <- mutate(murders, rate = total / population * 10^5)
head(murders)
      ### filter function, returns the whole data frame
filter(murders, rate <= 0.7)
      ### First argument is the data frame
new_table <- select(murders, state, region, rate)
filter(new_table, rate <= 0.71)
      ### Pipe operator, short-hand description of the operations 
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

    ## Creating df 
grades <- data.frame(names = c("John", "Huan", "Beth"),
                     exam_1 = c(90, 88, 92))
print(grades)
nrow(grades) # find the number of rows of a df
rank(-grades) # 1 is for largest, n is for smallest
class(grades$names) # no need to add stringsAsFactors argument
help("data.frame")

  # 3.3 Basic plotting
    ## Introduction
population_in_millions <- murders$population / 10^6
total_murders <- murders$total
plot(population_in_millions, total_murders)
hist(murder_rate)
boxplot(rate~region, data = murders)

## series.argmax vs which.max

### Assignment
data("heights")
options(digits = 3)
str(heights)
sum(heights$height > mean(heights$height) & heights$sex == 'Female')
mean(heights$sex == 'Female')
min(heights$height)
ind <- which.min(heights$height)
heights$sex[ind]
height <- heights$height
sex <- heights$sex
max(height)
x <- 50:82
sum(!x %in% height)
heights2 <- heights %>% mutate(ht_cm = height * 2.54)
new <- heights2 %>% filter(sex == "Female") %>% select(ht_cm) 
mean(new$ht_cm)

data(olive)
head(olive)
plot(olive$palmitic, olive$palmitoleic)
hist(olive$eicosenoic)
?boxplot
boxplot(data = olive, palmitic~region)
