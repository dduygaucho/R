library(dslabs)
library(tidyverse)
library(dplyr)
data(murders)
# 1.1: Intro to data viz
  ## Data types: categorical (ordinal - with order: bad < good < excellent + non)
# + numeric (continuous or discrete) 

data(heights)
x <- heights$height
unique(x) # returns unique values of x
table(x) == 2 # returns frequency == 2

# 1.2: intro to distributions
prop.table(table(heights[['sex']]))
## Normal distribution: mean(x) and sd(x)
index <- heights$sex=="Male"
x <- heights$height[index]
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)

# calculate standard units
z <- scale(x)

# calculate proportion of values within 2 SD of mean
## used to calculate the proportion mean(bool vector)
mean(abs(z) < 2)

## F(a) = Pr(X < a) = pnorm(a, avg, std)
1 - pnorm(70.5, average, SD)
summary(heights$height)
p <- seq(0.01, 0.99, 0.01)
# quantile for real dataset while qnorm is for theoretical
percentiles <- quantile(heights$height, p)
percentiles
## for table(x) to extract the names of the columns use names(x) == 'hello'
names(percentiles)
percentiles[names(percentiles) == '25%']
## qnorm is the inverse of pnorm
p <- seq(0.01, 0.99, 0.01)
theoretical_quantiles <- qnorm(p, 69, 3)
theoretical_quantiles

## qq plot to check if normal distribution is suitable or not 
p <- seq(0.05, 0.95, 0.05)
observed_quantiles <- quantile(z, p)
theoretical_quantiles <- qnorm(p)
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)



## ggplot
ggplot(data = murders)
murders %>% ggplot()
### geom_point: scatter plot
### args of geom_: aes(), size, ...
murders %>% ggplot() +
  geom_point(aes(x = population / 10^6, y = total), size = 3) +
  geom_text(aes(population/ 10^6, total, label = abb), nudge_x = 1) # just like plt.text(x,y, string)
### for global aes just add aes() inside the ggplot function and 
# local aes will override global ones

## to extract a column of a dataframe we use4 %>% .$
r <- murders %>% summarise(rate = sum(total) / sum(population) * 10^6) %>% .$rate
r
## adding themes
library(dslabs)
install.packages("ggrepel")
library(ggrepel)
ds_theme_set()
install.packages("ggthemes")
library(ggthemes)

## scales labels colors
murders %>% ggplot(aes(x = population / 10^6, y = total, label = abb)) +
  geom_point(size = 3, aes(col = region)) + # col = categorical auto adds colors and regions
  geom_text(nudge_x = 0.075) + # using repel to prevent words on words
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10") + 
  xlab("Populations in millions in log scale") +
  ylab("Total cases of murders in millions") + 
  ggtitle("US Gun Murders") + 
  geom_abline(intercept =  log10(r), color = 'darkgrey', lty = 2) +
  scale_color_discrete(name = "Region") + # change the title of the legend 
  theme_economist()

## 2 ways of filtering: 1st
heights$height[heights$sex == "Male"]
## 2nd: using filter
heights %>% filter(sex == "Male") %>% ggplot() +
  geom_histogram(aes(x = height), binwidth = 1, fill = "blue", col = "black") +
  xlab("Male heights in inches") +
  ggtitle("Histogram")  # col argument adds the borders for the histogram 
  # geom_density(fill = 'blue') either density or histogram


## create qq plot
p <- heights %>% filter(sex == "Male") %>%
  ggplot(aes(sample = height))
params <- heights %>%
  filter(sex == "Male") %>%
  summarize(mean = mean(height), sd = sd(height))
p + geom_qq(dparams = params) +
  geom_abline()
## second way of doing that
heights %>%
  ggplot(aes(sample = scale(height))) +
  geom_qq() +
  geom_abline()

## subplotting in R
p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
p1 <- p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 <- p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 <- p + geom_histogram(binwidth = 3, fill = "blue", col = "black")
install.packages("gridExtra")
library(gridExtra)
grid.arrange(p1,p2,p3, ncol = 3)

## 2 plots in the same graph we use group in aes: color = column(categorical col)
