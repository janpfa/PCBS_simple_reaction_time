### Script for Data Analysis of reaction time experiment ###
library(tidyverse)
library(rstatix)
library(ggpubr)
require(dplyr)
require(lattice)
require(nlme)
se <- function(x) sd(x)/sqrt(sum(!is.na(x))) # defines function for standard error

### Data import

setwd("./data")

data <- read.csv("all_reaction_times.csv", stringsAsFactors = TRUE)
head(data)
str(data)
data$subject_id <- factor(data$subject_id) # make sure these vars are factors

### Graphical results

## For each subject, plot average reaction times across trials, grouped by target type
grouped_means_per_subject <- data %>%
  group_by(subject_id, target_type) %>%
  summarise(grouped_mean_RT = mean(RT, na.rm=TRUE))
grouped_means_per_subject

xyplot(grouped_mean_RT ~ target_type, group=subject_id, data=grouped_means_per_subject, type='l')
xyplot(grouped_mean_RT ~ target_type | subject_id, data=grouped_means_per_subject, type='l')


## For each subject, plot reaction times of single trials and distribution, grouped by target type
bxp <- ggboxplot(
  data, x = "subject_id", y = "RT", 
  ylab = "Reaction Time in ms", 
  xlab = "Subject",
  add = "jitter",
  color = "target_type"
)
bxp

### Descriptive Statistics

# Compute differences for each participant between large_target reaction time and small_target reaction time

long_means <- data %>%
  group_by(subject_id, target_type) %>%
  summarise(grouped_mean_RT = mean(RT, na.rm=TRUE))
long_means

wide_means <- long_means %>% 
  spread(target_type, grouped_mean_RT) %>%
  mutate(RT_diff = target_large - target_small)
wide_means

summary(wide_means$RT_diff)

# Compute correlations between averages for stimulus condition across subjects
cor.test(wide_means$target_large, wide_means$target_small)


### Statistical Inference


# Question : Is there any significant difference between small and large target display regarding
# participants reaction time?

# Paired T-test comparing AVERAGES per subject across the two stimulus conditions
t.test(wide$target_large, wide$target_small, paired=T)


# Linear mixed effects models across ALL trials (i.e. several trials per conditon per subject)

(model_lme <- lme(RT ~ target_type, random=~1|subject_id, data= data))
summary(model_lme)

# Graphic 

# First graphic: with the std.err. of the means
# Errors bars here represent the standard errors (or confidence intervals) of the means of each treatment, they do
# NOT take out inter-subject variability (i.e. not consider dpendence of observations)
attach(data)
par(mfrow=c(1,1))

means <- tapply(RT, target_type, mean)
(ses <- tapply(RT, target_type, se))

ysca = c(min(means-3*ses), max(means+3*ses))

mp <- barplot(means, ylim=ysca, xpd=F, ylab = "Average reaction time in ms",
              main = "Standard errors of the means of different target conditions across all trials")
arrows(mp, means-ses, 
       mp, means+ses, 
       code=3, angle=90)
detach(data)


# Second graphic: standard error bar for the difference between the two treatments when intersubject variability 
# is TAKEN OUT

# compute correlations
attach(data)
data$RT_corr <- RT + mean(RT) - tapply(RT, subject_id, mean)[subject_id]
(ses <- tapply(RT_corr, target_type, se))

ysca = c(min(means-3*ses), max(means+3*ses))

mp <- barplot(means, ylim=ysca, xpd=F, ylab = "Average reaction time in ms",
              main = "Standard errors of the means of different target conditions across all trials 
               - Intersubject variability accounted for - ")
arrows(mp, means-ses, 
       mp, means+ses, 
       code=3, angle=90)

detach(data)

