# title: "Step 3 Explore Your Data"

# from "Project Details":
# *Step Three - Explore your Data
# This is the fun part. Start exploring your data! Keep track of your thoughts 
# as you go (in an RMD file). Please refer to the Example Project that we have 
# provided. Your report should look similar!*

#-----------------------------------------------------------------------
# What to Do First ("Explore One Variable", 2 of 29):
# "So, what should you do first? ...certainly you want to understand the 
# variables that are most central to your analysis. Often, this is going to 
# take the form of summaries and visualizations of those individual variables."

setwd("D:/DOCUMENTS/LEARNING/DAND/DAND4 EDA - R/PROJECT")
wines <- read.csv('wineQualityWhites.csv')

str(wines)
# 0 ordered factors
summary(wines)

ggplot(wines, aes(x=quality)) + 
  geom_histogram(binwidth=1, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(1, 10, 1))

ggplot(wines, aes(x=fixed.acidity)) + 
  geom_histogram(binwidth=0.5, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(1, 15, 0.5))
# for high quality:
ggplot(hi_Q, aes(x=fixed.acidity)) + 
  geom_histogram(binwidth=0.25, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(1, 15, 0.5))

ggplot(wines, aes(x=volatile.acidity)) + 
  geom_histogram(binwidth=0.1, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 1.75, 0.1))

ggplot(wines, aes(x=citric.acid)) + 
  geom_histogram(binwidth=0.05, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 2.0, 0.1))
  
ggplot(wines, aes(x=citric.acid)) + 
  geom_histogram(binwidth=0.005, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 2.0, 0.05))


ggplot(wines, aes(x=residual.sugar)) + 
  geom_histogram(binwidth=0.5, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 66, 3))
#  cut out outliers bec. such a spike at a low level ( look around 1.5 !)
# see "residual_sugar below Q3.png"
ggplot(wines, aes(x=residual.sugar)) + 
  geom_histogram(binwidth=0.5, color = 'black', fill = '#666966') + 
  scale_x_continuous(limits = c(1, 10), breaks=seq(1, 10, 1)) + 
  scale_y_continuous(breaks=seq(0, 1000, 100))
# shows how sugar highly skewed, zooming in on lower levels, very high < 2, then
# evens out.

ggplot(wines, aes(x=chlorides)) + 
  geom_histogram(binwidth=0.01, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 0.5, 0.05))

# low quality wines, chloride levels
ggplot(lo_Q, aes(x=chlorides)) + 
  geom_histogram(binwidth=0.01, color = 'black', fill = '#666966') + 
  scale_x_log10(breaks=seq(0, 0.1, 0.02))

ggplot(wines, aes(x=free.sulfur.dioxide)) + 
  geom_histogram(binwidth=5, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 300, 25))
# try cutting out that one outlier:
# binwidth of 2.5 makes the "spikes" stand out.
ggplot(wines, aes(x=free.sulfur.dioxide)) + 
  geom_histogram(binwidth=2.5, color = 'black', fill = '#666966') + 
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))

ggplot(wines, aes(x=total.sulfur.dioxide)) + 
  geom_histogram(binwidth=5, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0, 450, 10))

ggplot(wines, aes(x=pH)) + 
  geom_histogram(binwidth=0.1, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(2.0, 4.0, 0.1))

ggplot(wines, aes(x=sulphates)) + 
  geom_histogram(binwidth=0.05, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(0.0, 1.1, 0.1))
# long tail (transform?)

ggplot(wines, aes(x=alcohol)) + 
  geom_histogram(binwidth=0.375, color = 'black', fill = '#666966') + 
  scale_x_continuous(breaks=seq(7.5, 15, 0.5))

# Now free SO2 of high and low quality wines:
ggplot(hi_Q, aes(x=free.sulfur.dioxide)) + 
  geom_histogram(binwidth=1, color = 'black', fill = '#666966') + 
  scale_x_continuous(limits=c(0, 150), breaks=seq(0, 150, 25))
# High qual have neither too little nor too much SO2.
# A marked contrast
ggplot(lo_Q, aes(x=free.sulfur.dioxide)) + 
  geom_histogram(binwidth=1, color = 'black', fill = '#666966') + 
  scale_x_continuous(limits=c(0, 150), breaks=seq(0, 150, 25))
# Low qual have BOTH/EITHER too little or too much SO2.

#---------------------------------------------------------

# Like PS 3-10...
# Investigate the quality of wines using box plots, numerical summaries, 
# and one of the following categorical variables: residual sugar, free SO2, pH,
# chlorides, total SO2.

ggplot(wines, aes(x=factor(quality), y=residual.sugar)) + geom_boxplot()


#---------------------------------------------------------

# Scatterplots "are best for 2 continuous variables"

# qplot SYNTAX: (<X VARIABLE>, <Y VARIABLE>, data=DATAFRAME)
# can also use (x=VARIABLE, y=VARIABLE, data=DATAFRAME)

#The equivalent ggplot syntax for the scatterplot: 
#  ggplot(aes(x = ____, y = ____), data = ____) + 
#  geom_point()

qplot(fixed.acidity, quality, data=wines)
# Look at the regular horizontal lines!

# the closest thing to a linear relationship I've yet found is:
qplot(free.sulfur.dioxide, total.sulfur.dioxide, data=wines)

# Adding in "transparency" with ggplot
ggplot(aes(x=alcohol, y=quality), data=wines) + geom_point(alpha = 1/30)
# Slight tendency for lower qual to have less alcohol, high qual with more alco.

#```{r quality_chlorides_scatter}
ggplot(aes(x=chlorides, y=quality), data=wines) + 
  geom_jitter(alpha = .3) +
  scale_y_continuous(breaks = seq(3, 9, 1)) + 
  scale_x_continuous(limits = c(.01, 0.1), breaks = seq(.01, .1, .01))
#```

#---------------------------------------------------------

#{r Overlaying Summaries with Raw Data}
ggplot(aes(x = chlorides, y = quality), data = wines) + 
  xlim(0.0, 0.3) + 
  geom_jitter(alpha = 1/20, color = 'blue') + 
  # overlay with mean friend count
  geom_point(stat = 'summary', fun.y = mean)
  # overlay with 10% quantile, median (50% quantile), 90% quantile
  geom_line(stat = 'summary', fun.y = quantile, fun.args = list(probs = .1), 
            linetype = 2, color = 'blue') + 
  geom_line(stat = 'summary', fun.y = quantile, fun.args = list(probs = .5), 
            color = 'blue') + 
  geom_line(stat = 'summary', fun.y = quantile, fun.args = list(probs = .9), 
            linetype = 2, color = 'blue')
#Overlaying here doesn't seem to show much.
# fun.y does similar stuff to data that dplyr does.

#---------------------------------------------------------


# CREATE NEW VARIABLES  (refer to Lesson 5-10)
  
# QUALITY CATEGORIES
# This makes me want to create the new variable I mentioned earlier, which 
# categorizes quality as good, bad, or normal. I'll add a new variable, called 
# "quality_3cats", the divides quality into three categories as follows
# categorize quality into three levels: (3,5], (6], (7,9]
# quality  | category  
# -------  | -------------  
# 3, 4, 5  | "below normal"  
#    6     | "normal"  
# 7, 8, 9  | "above normal"  
  
  # was in bivariate, quality vs chlorides:
  # ```{r echo=FALSE, quality_4categories}
  # wines$quality_4cats <-
  #   cut(wines$quality, breaks = c(0, 4, 6, 7, 9), labels = c('poor', 'normal',
  #                                                       'good', 'excellent'))
  # table(wines$quality_4cats) 
  #```
  # Since 3's & 4's and 8's & 9's have nearly the same counts (183 and 180), it
  # made sense to bucket them symmetrically as "poor" and "excellent". The wines
  # Information file hints at 5's and 6's being normal ("there are munch [sic]
  # more normal wines than excellent or poor ones"), so I bucketed them together
  # because right now I'm more interested in the better and worse quality wines.
# four levels:
wines$quality_4cats <- cut(wines$quality, breaks = c(0, 4, 6, 7, 9), 
                         labels= c('poor', 'normal', 'good', 'excellent'))


# where "5" is considered "below average", given the mean & median quality.
wines$quality.factor <- cut(wines$quality, breaks = c(0,4,5,6,7,9), 
                        labels= c('poor (3-4)', 'below avg.(5)', 'average (6)', 
                                  'good (7)', 'excellent (8-9)'))

# RESIDUAL SUGAR CATEGORIES
# categorized vis-a-vis the bimodal transformed histogram: this turns out to be
# the SAME AS the axis breaks when you plot RS using **log2** transformation !!!
wines$RS.sweetness <- cut(wines$residual.sugar, breaks = c(0, 1.2, 4, 12, 66), 
                          labels=c('RS <= 1.2', 'RS 1.2-4', 
                                   'RS 4-12', 'RS > 12'))

                             #labels = c('rs <= 1.1', 'rs <= 3.5', 'rs <= 8', 
                             #           'rs <= 16', 'rs > 16'))
# res.sugar, categorized into quantiles
#wines$r.s.quant <- cut(wines$residual.sugar,breaks=quantile(wines$residual.sugar, 
#                                            probs=seq(0, 1.0, .25))) 

# ALCOHOL CATEGORIES, every 1% ... "alcohol by volume (ABV)"
#wines$alcohol.content <- cut(wines$alcohol, breaks = seq(8, 15, .5))
wines$alcohol.content <- cut(wines$alcohol, breaks = seq(7.9, 14.9, 1), 
                         labels = c('ABV 8-8.9%', 'ABV 9-9.9%', 'ABV 10-10.9%', 
                                    'ABV 11-11.9%',  'ABV 12-12.9%', 
                                    'ABV 13-13.9%', 'ABV 14-14.9%'))

# CHLORIDES CATEGORIES: quartiles
# Line 769 of Project.
wines$NaCl.quartile <- cut(wines$chlorides, breaks = c(0, .036, .043, .05, .35),
                           labels = c('NaCl Q1','NaCl Q2','NaCl Q3','NaCl Q4'))

#----------------------------------------------------------------------


# HORIZONTAL QUALITY "BARS" FULL of JITTER POINTS :

#```{r chlorides_scatter_high_quality}
ggplot(aes(x=chlorides, y=quality), 
       data = subset(wines, wines$quality > 5)) + 
  geom_jitter(size = 2.5, alpha = .5) + 
  scale_x_continuous(limits = c(quantile(wines$chlorides, .05), 
                                quantile(wines$chlorides, .95)))
#```
#Scatter plots of quality 6-9 over the top and bottom 5% of chlorides, jittered.
#The plots get denser towards the left (less salty) as quality increases.



#===== end of section =========================================================


# - # - # - # - # - # - # - #
#  BIVARIATE SCRATCH CODE   #
# - # - # - # - # - # - # - #

# Bivariate box plots w\quality on x will require the quality variable factored
`wines$quality.grade <- factor(wines$quality)`
# (after all the boxplots...)
`wines$quality.grade <- NULL`


ggplot(data = wines, aes(x = alcohol)) + 
  geom_histogram(binwidth = 0.5) + 
  scale_x_continuous(breaks=seq(7, 15, 1)) + 
  facet_wrap(~quality)


# TO USE mean QUALITY ON THE Y-AXIS -----------
# From Video 4-9 "Quiz: Conditional Means"
# "It can be helpful to summarize the relationship between two variables in other 
# ways than just plotting every single point every time. Sometimes you want to 
# understand how the _mean or median_ of one variable varies along with another 
# variable. For example, we can ask how average friend count varies over age."

# For example, we can ask how average quality varies over alcohol or free SO2.
library(dplyr)

alco_groups <- group_by(wines, alcohol)
wines.qual_by_alco <- summarise(alco_groups,
                                q_mean = mean(quality),
                                q_median = median(quality),
                                n = n())
ggplot(aes(x = alcohol, y = q_mean), data = wines.qual_by_alco) + geom_line()


# Group and summarize
mq.by.chlor <- summarise(group_by(wines, chlorides), 
                         mean_quality = mean(quality), 
                         n = n())

ma.by.q <- summarise(group_by(wines, quality),
                     mean_alc = round(mean(alcohol), 2), 
                     n = n())
# Plot it
ggplot(ma.by.q, aes(quality, mean_alc)) + geom_bar(stat='identity')
# Correlation
with(mq.by.alco, cor.test(alcohol, mean_quality))


ggplot(aes(x=free.sulfur.dioxide, y=q_mean), data = wq_by_freeSO2) + 
  geom_point(aes(size=n), alpha=1/2) + 
  geom_smooth()
# Divide FreSO2 in low-med-high, then plot?
# Use dplyr :: filter()
low_SO2 <- filter(wines, free.sulfur.dioxide <= 20)
med_SO2 <- filter(wines, free.sulfur.dioxide > 20 & free.sulfur.dioxide < 50)
hi_SO2 <- filter(wines, free.sulfur.dioxide >= 50)
# quality by low SO2:
#loSO2_grp <- group_by(low_SO2, free.sulfur.dioxide)
mq_loSO2 <- summarise(group_by(low_SO2, free.sulfur.dioxide),
                      mean_quality = mean(quality), n = n())
mq_mdSO2 <- summarise(group_by(med_SO2, free.sulfur.dioxide),
                      mean_quality = mean(quality), n = n())
mq_hiSO2 <- summarise(group_by(hi_SO2, free.sulfur.dioxide),
                      mean_quality = mean(quality), n = n())
p.lS <- ggplot(mq_loSO2, aes(free.sulfur.dioxide, mean_quality)) + 
  geom_point(aes(size=n)) +
  geom_smooth()
p.mS <- ggplot(mq_mdSO2, aes(free.sulfur.dioxide, mean_quality)) + 
  geom_point(aes(size=n)) +
  geom_smooth()
p.hS <- ggplot(mq_hiSO2, aes(free.sulfur.dioxide, mean_quality)) + 
  geom_point(aes(size=n)) +
  geom_smooth()

grid.arrange(p.lS, p.mS, p.hS, nrow=3)

#-------------------------------------------------------------

# !*!*!*!*!
# DPLYR::SUMMARISE_EACH()
# https://www.r-bloggers.com/aggregation-with-dplyr-summarise-and-summarise_each/

# save original column names, then abbreviate
column_names <- colnames(wines)
colnames(wines) <- c('X', 'fxa', 'vola', 'cit', 'rsug', 'chlo',  'fSO2', 'tSO2', 
                     'dens', 'pH', 'sul', 'alco', 'quality')

# function: round means to fewer places
rdmean <- function(x){round(mean(x), 3)}

# function: round medians to fewer places
rdmedian <- function(x){round(median(x), 2)}

# mean of each of the 11 attributes for all wines (not by quality):
wines[1:11] %>% 
  summarise_each(funs(rdmean), fxa, vola, cit, rsug, chlo, fSO2, tSO2, dens, pH,
                               sul, alco)

# mean of each attribute at each quality grade:
wines %>%
  group_by(quality) %>% 
  summarise_each(funs(rdmean), fxa, vola, cit, rsug, chlo, fSO2, tSO2, dens, pH,
                               sul, alco)

# restore original column names
colnames(wines) <- column_names

# these 3 lines do the same as above
feat.mean.by.qual <- summarise_each(group_by(wines, quality), funs(rdmean))
#feat.mean.by.qual$X <- NULL
#feat.mean.by.qual$quality_4catss <- NULL
# Median instead of mean:
feat.med.by.qual <- summarise_each(group_by(wines, quality), funs(rdmedian))

# How to plot, for each quality grade, the average of a single feature
plot.mean.by.qual <- function(df, x, y, yint){
  ggplot(df, aes_string(x, y, label = df[[y]])) +
    geom_point(shape = '-', size = 25) + 
    geom_hline(aes(yintercept = yint), color = 'red', size = 1.5) + 
    scale_x_continuous(breaks=seq(3, 9, 1)) + 
    geom_text(aes(label = df[[y]]), color = 'white')
}

# How to plot the mean by quality per features
plot.all.mean.by.qual <- function(df, x, y, yint){
  ggplot(df, aes_string(x, y, label = df[[y]])) +
    geom_point(shape = 18, size = 4) + 
    geom_line(size = 1) + 
    geom_hline(aes(yintercept = median(df[[y]])), color = 'red', size = 1) + 
    ylab(paste('mean ', y)) + 
    scale_x_continuous(breaks=seq(3, 9, 1))
}


# original plot code before made into function:
ggplot(feat.mean.by.qual, aes(quality, alco, label=alco)) + 
   geom_point(shape='-', size=50) + 
   geom_hline(aes(yintercept=10.51427), color='blue', size=2) + 
   scale_x_continuous(breaks=seq(3, 9, 1)) + 
   geom_text(aes(label=alco), color='white')

# Or, without having run rdmean() on a feature,
# and without having created feat.mean.by.qual:
ggplot(wines, aes(quality, alcohol, label=alcohol)) +
  geom_point(stat = 'summary', fun.y=mean, shape=18, size=5) + 
  geom_hline(aes(yintercept=10.51427), color='red', size=1.5) + 
  scale_x_continuous(breaks=seq(3, 9, 1))


# plot all features' means by quality grade:
# pfa pva pca prs pcl pfs pts pde ppH psu pal
p1 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'fixed.acidity', 6.855)
p2 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'volatile.acidity', .278)
p3 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'citric.acid', .334)
p4 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'residual.sugar', 6.391)
p5 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'chlorides', .046)
p6 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality','free.sulfur.dioxide', 35.308)
p7 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality','total.sulfur.dioxide', 138.361)
p8 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'density', .994)
p9 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'pH', 3.188)
p10 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'sulphates', .49)
p11 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'alcohol', 10.514)
grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11, ncol = 4)

# focusing only on the plots that stood out:
p1 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'fixed.acidity', 6.855)
p5 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'chlorides', .046)
p7 <- plot.all.mean.by.qual(feat.mean.by.qual,'quality','total.sulfur.dioxide',138.361)
p8 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'density', .994)
p9 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'pH', 3.188)
p11 <- plot.all.mean.by.qual(feat.mean.by.qual, 'quality', 'alcohol', 10.514)
grid.arrange(p1,p5,p7,p8,p9,p11, ncol = 3)


#*__NOTE: CHECK OUT section "{r Looking at Sample of Households}" in the Lesson
# 5 file ("lesson5-student.rmd").__*  --  MAYBE CAN PANEL PLOT USING `%in%` ???


# alternative to plot.all.mean.by.qual, so that I can choose which summary stat
# df: data frame
# x: variable on x-axis (in quotes)
# y: variable on y-axis (in quotes)
# funy: summary statistic (mean, median...) to run on y
# funy_lab: name of funy chosen,in quotes, to use on y-axis label (eg, "mean")
plot.avg.by.qual <- function(df, x, y, funy, funy_lab){
  ggplot(df, aes_string(x, y, label = df[[y]])) +
    geom_point(shape = 18, size = 4) + 
    geom_line(size = 1) + 
    geom_hline(aes(yintercept = funy(df[[y]])), color = 'red', size = 1) + 
    ylab(paste(funy_lab, y)) + 
    scale_x_continuous(breaks=seq(3, 9, 1))
}

# Since we're plotting only the median of each feature, create a data frame 
# that summarizes this at each quality grade.
# "fmdbq" stands for "feature medians by quality".
fmdbq <- summarise_each(group_by(wines, quality), funs(median))
# And to plot all in a grid, using medians:
p1 <- plot.avg.by.qual(fmdbq, 'quality', 'fixed.acidity', median, 'median')
p2 <- plot.avg.by.qual(fmdbq, 'quality', 'volatile.acidity', median, 'median')
p3 <- plot.avg.by.qual(fmdbq, 'quality', 'citric.acid', median, 'median')
p4 <- plot.avg.by.qual(fmdbq, 'quality', 'residual.sugar', median, 'median')
p5 <- plot.avg.by.qual(fmdbq, 'quality', 'chlorides', median, 'median')
p6 <- plot.avg.by.qual(fmdbq, 'quality','free.sulfur.dioxide', median, 'median')
p7 <- plot.avg.by.qual(fmdbq, 'quality','total.sulfur.dioxide', median, 'median')
p8 <- plot.avg.by.qual(fmdbq, 'quality', 'density', median, 'median')
p9 <- plot.avg.by.qual(fmdbq, 'quality', 'pH', median, 'median')
p10 <- plot.avg.by.qual(fmdbq, 'quality', 'sulphates', median, 'median')
p11 <- plot.avg.by.qual(fmdbq, 'quality', 'alcohol', median, 'median')
grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11, ncol = 4)

#  flip  it  over ?
# intended mostly for 'quality' as y #x
# funx: summary statistic (mean, median...) to run on x
# funx_lab: funx in quotes, to use on x-axis label (e.g., "mean")
pabq <- function(df, x, y, funx, funx_lab){
  ggplot(df, aes_string(x, y, label = df[[x]])) +
    geom_point(shape = 18, size = 5, color = 'blue') + 
    geom_line(size = 1) + 
    geom_vline(aes(xintercept = funx(df[[x]])), color = 'red', size = 1) + 
    xlab(paste(funx_lab, x)) + 
    scale_y_continuous(breaks=seq(3, 9, 1))
}
# ok, now plot it:
p1 <- pabq(fmbq, 'fixed.acidity', 'quality', mean, 'mean ')
p2 <- pabq(fmbq, 'volatile.acidity', 'quality', mean, 'mean ')
p3 <- pabq(fmbq, 'citric.acid', 'quality', mean, 'mean ')
p4 <- pabq(fmbq, 'residual.sugar', 'quality', mean, 'mean ')
p5 <- pabq(fmbq, 'chlorides', 'quality', mean, 'mean ')
p6 <- pabq(fmbq, 'free.sulfur.dioxide', 'quality', mean, 'mean ')
p7 <- pabq(fmbq, 'total.sulfur.dioxide', 'quality', mean, 'mean ')
p8 <- pabq(fmbq, 'density', 'quality', mean, 'mean ')
p9 <- pabq(fmbq, 'pH', 'quality', mean, 'mean ')
p10 <- pabq(fmbq, 'sulphates', 'quality', mean, 'mean ')
p11 <- pabq(fmbq, 'alcohol', 'quality', mean, 'mean ')
grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11, ncol = 4)
# Yuck !!!


# Submission 1: boxplot feat by qual FUNCTION (v1)
feature.boxplot <- function(d, x, y){
  ggplot(d, aes_string(d[[x]], d[[y]])) + 
    geom_boxplot() +   
    xlab(x) + ylab(y) + 
    stat_summary(fun.y = mean, geom = 'point', shape = 8, size = 2) + 
    geom_hline(aes(yintercept = median(d[[y]])), 
               linetype = 'dashed', color = 'red')
}
# FUNCTION v2: boxplot feat. over qual. (box jitter plot w/mean value markers)
# per reviwer: MAKE A FUNCTION OUT OF THIS... 
ggplot(wines, aes(factor(quality), alcohol)) + 
  geom_jitter(alpha = .2) + 
  geom_boxplot(alpha = .5, color = 'blue2', outlier.size = .9) + 
  stat_summary(fun.y = "mean", geom = "point", 
               fill = 'indianred3', shape = 23, size = 4) + 
  geom_hline(aes(yintercept = median(wines$alcohol)), 
             linetype = 'dashed', color = 'blue') +
  geom_smooth(aes(quality-2, alcohol), 
              method = "lm", se = FALSE, 
              size = 4/3, color = 'blue2')
# as function (d, x, y):
box.jitter <- function(d, x, y){
  ggplot(d, aes_string(factor(d[[x]]), d[[y]])) + 
    geom_jitter(alpha = .2) + 
    geom_boxplot(alpha = .5, color = 'blue2') + 
    labs(x=x, y=y) + 
    stat_summary(fun.y = 'mean', geom = 'point', 
                 fill = 'indianred3', shape = 23, size = 4) + 
    geom_smooth(aes(d[[x]]-2, d[[y]]), 
                method = "lm", se = FALSE, 
                size = 4/3, color = 'blue2')
}

#-------------------------------------------------------------

# BOXPLOTS OF QUALITY BY ATTRIBUTE

# run summary() on these, too?
# e.g., the alcohol summary at each quality level.
# the code for these plots is so similar, can I create a FUNCTION?
ggplot(wines, aes(quality, alcohol)) + 
  geom_boxplot(aes(fill = factor(quality)), outlier.size = 0.2) + 
  stat_summary(fun.y=mean, geom="point", shape=8, size=2)

ggplot(wines, aes(quality, density)) + 
  geom_boxplot(aes(fill = factor(quality)), outlier.size = 0.2) + 
  stat_summary(fun.y=mean, geom="point", shape=1, size=2)

# A more basic to code the plot (from Myles in Forum):
ggplot(aes(x = factor(quality), y = volatile.acidity), data = wines) +  
  xlab("quality") + 
  geom_boxplot()


# +++ FUNCTIONS ++++++++++

# Function for the boxplot code
# syntax: qual.boxplot(wines$VARIABLE)
qual.boxplot <- function(attribute, attribute_name){
  p <- ggplot(wines, aes(factor(quality), attribute)) + 
         xlab("quality") + ylab(attribute_name) + 
         geom_boxplot() + 
         stat_summary(fun.y=mean, geom="point", shape=8, size=2)
  return(p)
}
# example
qual.boxplot(wines$pH)

qual.boxplot <- function(df, attribute, attribute_name){
  p <- ggplot(df, aes(factor(quality), attribute)) + 
    xlab("quality") + ylab(attribute_name) + 
    geom_boxplot() + 
    stat_summary(fun.y=mean, geom="point", shape=8, size=2)
  return(p)
}

qual_cat_box <- function(df, xvar, yvar){
  ggplot(df, aes_string(df[[xvar]], df[[yvar]])) + 
    xlab(xvar) + ylab(yvar) + 
    geom_boxplot() + 
    stat_summary(fun.y=mean, geom="point", shape=8, size=2)
}

# Function: facet attributes histograms by quality
#```{r Function_histograms_by_quality}
qual.facet.histos <- function(x_value, x_label){
  p <- ggplot(data = wines, aes(x = x_value)) + 
         xlab(paste(x_label, 'distribution by quality')) + 
         geom_histogram() + 
         facet_wrap(~quality)
  return(p)
}
# example
qual.facet.histos(wines$residual.sugar, 'residual sugar')


#-------------------------------------------------------------

# try to emulate diamonds example plot on pg. 28: "count of carat by cut"
# lines
ggplot(subset(wines, wines$quality_4cats != "normal"), 
       aes(density, color=quality_4cats)) + 
  xlim(0.986, 1.003) + 
  geom_freqpoly(size = 1.5)

# density plots
ggplot(wines, aes(chlorides, fill=factor(quality))) + #xlim(0, .2) + 
  geom_density(alpha = .5) + 
  scale_x_log10()

# Plot types that may come in handy...
geom_area()
geom_count()
geom_dotplot()

#-------------------------------------------------------------

# Compare variable other than Quality:

# Correlate all the variables
c('fa', 'va', 'ca', 'rs', 'chl', 'fsd', 'tsd', 'den', 'pH', 'sul', 'al', 'q')
c('fxdac', 'volac', 'citra', 'resid', 'chlo', 'frSO2', 'tSO2', 'dens', 'pH', 
  'sul', 'al', 'qual')

#   sulphates and free SO2 &/or total SO2, r = 0.06, 0.13
#   alchohol and residual sugar, r = -0.45
#   volatile and fixed acidity, r = -0.23

# Density???
with(wines, cor.test(residual.sugar, density))
# Pearson's product-moment correlation
# data:  residual.sugar and density
#       cor 
# 0.8389665
with(wines, cor.test(alcohol, density))
# Pearson's product-moment correlation
# data:  alcohol and density
# sample estimates:
# cor 
# -0.7801376 
with(wines, cor.test(quality, density))
# Pearson's product-moment correlation
# data:  quality and density
# sample estimates:
# cor 
# -0.3071233 

ggplot(wq.by.dens, aes(density, q_mean)) + geom_point() + 
  geom_smooth() + 
  scale_x_continuous(limits = c(0.975, 1.0025), breaks = seq(0.975, 1.0025, 0.05))

lm(formula = citric.acid ~ chlorides, data = wines)
lm(formula = quality ~ density, data = wines)


# PLOTS of two variables: ---------------------

# density and alcohol
ggplot(wines, aes(density, alcohol)) +  
  geom_point()
ggplot(wines, aes(density, alcohol)) + 
  xlim(0.987, 1.005) + ylim(8, 14) + 
  geom_jitter()

# density and res.sugar
ggplot(wines, aes(density, residual.sugar)) + 
  geom_point()
ggplot(wines, aes(density, residual.sugar)) + 
  xlim(0.987, 1.003) + ylim(0, 25) + 
  geom_jitter(alpha = .33) + 
  geom_smooth(method = "lm", se = FALSE)

#```{r density_RS_scatter}
p1 <- ggplot(wines, aes(residual.sugar, density)) + 
  #scale_x_continuous(trans = 'log2', breaks = c(1, 4, 8, 16, 32, 64)) +
  geom_jitter(size = 1, alpha = .25) + geom_smooth(color = 'green')
  #geom_smooth(method = "lm", formula = y ~ x + I(x^2))
p2 <- p1 + ylim(0.987, 1.003) + 
  scale_x_continuous(trans = 'log2', breaks = c(1, 4, 8, 16, 32, 64)) + 
  geom_smooth(method = "lm", formula = y ~ x + I(x^2))
grid.arrange(p1, p2, ncol = 1)
#```


#======# end of section #=====================================================#


# # # # # # # # # # # # # # # # #
#   MULTIVARIATE SCRATCH CODE   #
# # # # # # # # # # # # # # # # #

# -----------------------------
# DENSITY vs ALCOHOL, by QUALITY
p.daq <- ggplot(wines, aes(density, alcohol, color = quality.factor)) + 
           xlim(0.987, 1.003)
# First Choice:
p.daq + 
  geom_jitter(size = 3) + 
  scale_color_brewer(type = 'seq', palette = 17)
# alt 1
p.daq + 
  geom_jitter(size = 2) + 
  scale_color_brewer(type = 'div', palette = 2)
# alt 2
p.daq + 
  geom_point(size = 2, alpha = .8) + 
  scale_color_brewer(type = 'seq', palette = 12)
# alt 3
p.daq + 
  geom_point(size = 3, alpha = .5) + 
  scale_color_brewer(type = 'seq', palette = 8) + theme_dark()

ggplot(wines, aes(alcohol)) + 
  scale_color_brewer(type = 'div', palette = 2) + 
  geom_density(aes(color=quality.factor, 
                   fill=quality.factor), alpha=.45) + 
  facet_wrap(~NaCl.quartile)
#group=quality.factor, 
#----------------------------------------------------------------------

# "examine a relationship between x & y by adding a 3rd variable,
# which groups the xy relationship by each level in that 3rd variable"

# RESIDUAL SUGAR, DENSITY, & ALCOHOL

# ~ I like these better ~

ggplot(wines, aes(residual.sugar, density, color = alcohol.content)) + 
  geom_jitter() + #point() + #size = 2.5
  scale_x_continuous(trans = 'log2') + 
  ylim(.987, 1.003) +
  scale_color_brewer(type = 'seq', palette = 'YlGn')

# HEY!: is res.sgr. naturally log 2 ???
# sqrt(2)=1.4, 2^2=4, 2^=8, 2^4=16, 2^5=32, 2^6=64

ggplot(wines, aes(residual.sugar, density)) + 
  geom_jitter(alpha = .25) + 
  scale_x_log10(breaks = seq(0, 20, 4)) + 
  ylim(.9887, 1.0003) + 
  facet_wrap(~alcohol.content, ncol = 3)

ggplot(wines, aes(residual.sugar, density, color = alcohol.content)) + 
  geom_jitter(shape = 18, size = 1.5) + 
  scale_x_continuous(trans = 'log2') + 
  ylim(.987, 1.003) +
  scale_color_brewer(type = 'seq', palette = 'BuGn')

# ??? INCLUDE ???
ggplot(wines, aes(RS.sweetness, density, color = alcohol.content)) + 
  geom_jitter(shape = '-', size = 8) + 
  ylim(.987, 1.003) +
  scale_color_brewer(type = 'seq', palette = 'YlGn')
#----- ??? -----#

# These are the others...
ggplot(wines, aes(alcohol.content, density, color = RS.sweetness)) + 
  geom_jitter(shape = 15, size = 1) + 
  ylim(.987, 1.003) +
  scale_color_brewer(type = 'div', palette = 'BrBG')

ggplot(wines, aes(alcohol, density, color = RS.sweetness)) + 
  geom_jitter(alpha = .75) + 
  ylim(.987, 1.003) +
  scale_color_brewer(type = 'seq', palette = 'YlGn')


#-----------------------------------

# quality, alcohol, and residual sugar
# Q: does the relationship between alcohol and quality hold up regardless of 
#    residual sugar, or is it different at different res. sugar amounts?
ggplot(wines, aes(residual.sugar, quality)) +
  geom_jitter(aes(color = alcohol.content), shape = 8) + #size=3, alpha=.75) +
  scale_x_continuous(trans='log2', breaks = c(1, 2, 4, 8, 16, 24, 32, 64)) + 
  scale_y_continuous(breaks = seq(3, 9, 1)) + 
  scale_color_brewer(type='seq', palette = 8) + theme_dark()
  #geom_vline(aes(xintercept = median(wines$residual.sugar)), color = 'white') + 

ggplot(wines, aes(quality, alcohol, color = RS.sweetness)) + 
  geom_jitter(shape = 9, size = 1) + 
  scale_y_continuous(breaks = seq(8, 14, 1)) + 
  scale_x_continuous(breaks = seq(3, 9, 1)) + 
  geom_hline(aes(yintercept = median(wines$alcohol)), color = 'white') + 
  scale_color_brewer(type='seq', palette = 8) + theme_dark()

# quality, density, and residual sugar
# Q: does the relationship between density and quality hold up regardless of 
#    residual sugar, or is residual sugar affecting density and therefore 
#    indirectly related to quality? Or, maybe residual sugar isn't influencing 
#    quality by making wine sweeter but by making wine denser.
ggplot(wines, aes(residual.sugar, density, color = quality.factor)) + 
  geom_jitter(shape = 6, size = .85) + geom_smooth(se=FALSE) +
  ylim(c(.987, 1.003)) +
  scale_x_log10(breaks = seq(0, 24, 4)) + 
  geom_vline(aes(xintercept = median(wines$residual.sugar)), 
             linetype = 'dashed', color = 'green') + 
  scale_color_brewer(type='seq', palette = 8) + theme_dark()


# density vs alcohol by residual.sugar level
# Are density and alcohol related through residual sugar?
ggplot(wines, aes(density, alcohol)) + 
  xlim(0.987, 1.003) + 
  geom_point(alpha=1/5) + 
  geom_smooth() + 
  facet_wrap(~RS.sweetness)


# - - - - - - - - - - - - - - - - -

# (discarded?)
#This grid of scatter plots shows residual sugar vs density, faceted by a 1% 
#grouping of alcohol content, and colored by quality. Quality 3 & 4 are grouped, 
#as are 8 & 9. Residual sugar is log~2~ transformed, and the vertical lines are 
#at residual sugar's Q1, median, and Q3. The horizontal line is median density. 
#Three density outliers are omitted.
#```{r RS_v_density_by_quality_&_alcohol}
rsQ1 <- quantile(wines$residual.sugar, .25)
rsMd <- median(wines$residual.sugar)
rsQ3 <- quantile(wines$residual.sugar, .75)

ggplot(wines, aes(residual.sugar, density, color = quality.factor)) + 
  geom_jitter(shape = 20, size = 2) + 
  ylim(c(.987, 1.003)) +
  scale_x_continuous(trans = 'log2') + 
  geom_hline(aes(yintercept = median(wines$density)), color = 'gold') + 
  #geom_vline(aes(xintercept = rsQ1), color = 'white', linetype = 2) +
  geom_vline(aes(xintercept = rsMd), color = 'gold') +
  #geom_vline(aes(xintercept = rsQ3), color = 'white', linetype = 2) +
  scale_color_brewer(type='div', palette = 'RdBu', direction = -1) + 
  theme_dark() + 
  facet_wrap(~alcohol.content)

ggplot(wines, aes(residual.sugar, density)) + 
  geom_point(shape = 5, size = 1/2) + 
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), 
              size = .7, color = 'green') +  
  scale_x_continuous(trans = 'log2') + 
  coord_cartesian(ylim = c(.987, 1.003)) + 
  geom_hline(aes(yintercept = median(wines$density)), linetype = 2) + 
  geom_vline(aes(xintercept = median(wines$residual.sugar)), linetype = 2) + 
  facet_wrap(~alcohol.content, ncol = 3)
#---------------------------------------------------------------------

# ALCOHOL BY QUALITY BY NaCl
# 4 relationships between alcohol and NaCl, 1 line for each quality category:
ggplot(wines, aes(alcohol, chlorides, color = quality_4cats)) + 
  scale_y_continuous(breaks = seq(0, .07, .01)) + 
  geom_hline(aes(yintercept = median(wines$chlorides)), color = 'blue') +
  scale_color_brewer(type = 'seq', palette = 'PuRd') + 
  geom_smooth(se=FALSE) + theme_dark()
# Do chlorides affect the relationship between alcohol and quality?

ggplot(wines, aes(alcohol, quality)) + #, color = NaCl.quartile)) + 
  geom_jitter(alpha = .5) + geom_smooth(se=FALSE) + 
  facet_wrap(~NaCl.quartile, ncol = 2)
# It does appear to have some effect. The alcohol & quality scatter plots seem 
# "slide" toward the upper left in the two lower quartiles of chlorides. This 
# suggests that the relationship may be more positive among less salty wines.

ggplot(wines, aes(alcohol)) + #xlim(0, .15) + 
  geom_density(aes(group=quality.factor, color=quality.factor, 
                   fill=quality.factor), alpha=.45) + 
  facet_wrap(~NaCl.quartile)

# ??? INCLUDE ???
ggplot(wines, aes(quality)) + 
  geom_density(aes(group=alcohol.content, color=alcohol.content, 
                   fill=alcohol.content), alpha=.7) + 
  facet_wrap(~NaCl.quartile)
#???----------???

# CHLORIDES vs DENSITY, by QUALITY
p.caq <- ggplot(wines, aes(chlorides, density, color = quality.factor)) + 
  ylim(0.987, 1.003) +
  xlim(0.01, 0.16) 

p.caq + 
  geom_jitter(size = 1, alpha = .65) + 
  scale_color_brewer(type = 'div', palette = "RdBu") + theme_dark()

# quality over density, faceted by chloride quartiles


# others
p.caq + 
  geom_jitter(alpha = 2/3) + 
  scale_color_brewer(type = 'seq', palette = 8) + theme_dark() #17, 11

p.caq + 
  #scale_x_log10() + 
  geom_jitter(shape = 8, size = 1) + 
  scale_color_brewer(type = 'seq', palette = 'YlGn')
#                                , palette = 4, direction = -1)

ggplot(wines, aes(chlorides, density)) + 
  ylim(0.987, 1.003) + 
  scale_x_log10() + 
  geom_jitter(alpha = .4) + 
  geom_smooth(se=FALSE) + 
  facet_wrap(~quality.factor)

# alcohol over chlorides ("spiked" vs "salty"), by quality
ggplot(wines, aes(chlorides, density, color = factor(quality))) + 
  geom_point(size = 2, alpha = 2/3) + 
  scale_color_brewer(type = 'seq', palette = 8) + theme_dark()

ggplot(wines, aes(chlorides, alcohol, color = factor(quality))) + 
  xlim(c(.01, .075)) + 
  geom_jitter(size = 2, alpha = 3/4) + 
  scale_color_brewer(type = 'seq', palette = 'YlOrBr')


#---------------------------------------------------------------------



#---------------------------------------------------------------------

# total SO2 and NaCl both correlated to alcohol but not each other: here they are, 
# faceted by alcohol, colored by quality cat
ggplot(aes(x=chlorides, y=total.sulfur.dioxide, color=quality_4cats), data=wines) + 
  ylim(50, 250) + xlim(0.01, 0.16) + 
  geom_point(stat = 'identity', size=1, alpha = 2/3) + theme_dark() + 
  scale_color_brewer(type = 'div') + facet_wrap(~alcohol.content)

# or, (BETTER): faceted by quality, colored by alcohol:
ggplot(aes(x=chlorides, y=total.sulfur.dioxide), data=wines) + 
  ylim(50, 250) + xlim(0.01, 0.16) + 
  geom_point(aes(color=alcohol.content), stat = 'identity', size=1) + 
  geom_smooth(se=FALSE, size = .5) + facet_wrap(~quality_4cats) + 
  scale_color_brewer(type = 'seq', palette = 7) + theme_dark()
# they don't look related here


#----------------------------------------------------------------------


# ALCOHOL vs FREE SO2, by quality_4cats "poor" & "very good" only.
# Excluding "NORMAL" &\or "7" Wines
wsub <- subset(wines, quality_4cats!='normal') #& quality_4cats!='good')

ggplot(aes(x = alcohol, y = free.sulfur.dioxide), data = wsub) + 
  ylim(10, 150) + 
  geom_point(aes(color = quality_4cats), size=4, alpha=.75) + 
  scale_color_brewer(type = 'div', palette = 'BrBG')

# median FREE SO2 at ALCOHOL content, by quality_4cats
# these doesn't show an effect...
ggplot(wines, aes(alcohol, free.sulfur.dioxide, color = quality.factor)) + 
  scale_x_sqrt() + 
  geom_point() + #(size = 3, stat = 'summary', fun.y = median) + 
  scale_color_brewer(type = 'div') + theme_dark()
ggplot(wines, aes(free.sulfur.dioxide, alcohol, color = quality.factor)) + 
  scale_x_log10() + 
  geom_point(size = 1.5, alpha = 2/3) + 
  scale_color_brewer(type = 'seq', palette = 8) + theme_dark()


#----------------------------------------------------------------------

ggplot(wines, aes(alcohol, quality)) + 
  geom_jitter(alpha = .5, aes(color = RS.sweetness)) + 
  scale_color_brewer()


######################################################


# CHOSEN PLOT THREE, one version:
ggplot(wines, aes(density, alcohol, color = quality.factor)) + 
  ggtitle('Wine Quality by Alcohol Content and Density') +
  coord_cartesian(xlim = c(.9874, 1.0025), ylim = c(8.0, 14.3)) + 
  scale_color_brewer(type = 'div', palette = 'RdBu', direction = -1, 
                     name = 'Wine Quality') + 
  geom_jitter(size = 2, alpha = 3/4) + 
  geom_hline(aes(yintercept = median(wines$alcohol)), color='gray60', 
             size = 1, linetype = 2) + 
  geom_vline(aes(xintercept = median(wines$density)), color='gray60', 
             size = 1, linetype = 2) + 
  geom_text(aes(.9877, 10.3, label = 'median abv'), size=3.5, color = 'grey') + 
  geom_text(aes(.994, 13.9, label = 'median density'), size=3.5, 
            color = 'grey', angle = 270) + 
  geom_smooth(method = "lm", se=FALSE) + 
  scale_x_continuous(breaks = seq(.9875, 1.0025, .0025)) + 
  scale_y_continuous(breaks = seq(8, 14, 1), 
                     labels=c('8%','9%','10%','11%','12%','13%','14%')) + 
  labs(x = 'Wine Density', y = 'Alcohol by Volume') + 
  theme(panel.grid.minor=element_blank(), 
        panel.background = element_rect(fill = 'gray88'), 
        legend.key = element_rect(fill = 'gray88')) #+ 
#theme_dark()


# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# GARBAGE COLLECTION

# was in bivariates section:
```{r echo=FALSE, mean_quality_by_density_scatter} mq.by.dens <-
summarise(group_by(wines, density), mean_quality = mean(quality), n = n()) 
ggplot(mq.by.dens, aes(density, mean_quality)) + geom_point(aes(size=n), alpha
= .5) + coord_cartesian(xlim = c(.987, 1.003)) +
geom_smooth() 
with(mq.by.dens, round(cor(density, mean_quality), 3))
```
# I omitted those outliers from this grouped plot, too. I also added a smooth
# and resized the dots. This seems to show a moderate relationship between
# density and mean quality, but there are still lots of dots in horizontal rows.



# was in bivariates section:
```{rlowchloridestats}
# cor, quality vs chlorides
with(wines, cor.test(chlorides, quality))
# cor, mean quality vs chloride groups
with(mq.by.chlor, cor.test(chlorides, mean_quality))

# ? CUT THE REST...? :
# chlorides between 10% and 90% quantiles
# cor, mean quality vs 10-90% quantile chloride groups
#mq.by.cl.sub <- summarise(group_by(chlo_range, chlorides), 
#                         mean_qual = mean(quality), n = n())
#with(mq.by.cl.sub, cor.test(chlorides, mean_qual))
```
# Pearson's r correlation:  
# quality vs chlorides, all wines = -0.21
# mean quality vs chloride groups, all wines = -0.38
# ???CUT???--mean quality vs 10-90% quantile of chloride groups = -0.84--??CUT??
# 
# Looks like a negative relationship between mean quality and chlorides when 
# chlorides are grouped by amount
# # ???CUT--and outliers are trimmed off. However, I might be overstating it, since
# I am calculating correlation with grouped chlorides summarized with mean quality.


# was in bivariate plots:
```{r echo=FALSE, mean_quality_by_pH} 
Group and summarize
mq.by.pH <- mqual.by.feat(wines, 'pH') 
Give feature column a meaningful name 
names(mq.by.pH)[names(mq.by.pH)=='d[[y]]'] <- 'pH'

ggplot(mq.by.pH, aes(pH, mean_quality)) + geom_point(aes(size = n), alpha =
2/3) + geom_hline(aes(yintercept = mean(wines$quality)), linetype = 2) + 
scale_x_continuous(breaks = seq(2.7, 3.9, 0.1))
```
# Mean quality for a bunch of wines around pH 3.05 to 3.25 is below the overall
# mean quality. Mean quality for a smaller bunch of wines just above 3.25 is
# above the overall mean. There's little variance in quality in these two
# bunches. There's a wider variance in mean quality the farther we get from the
# mean pH of 3.19.

#---------------------


```{r freeSO2_boxplot}
qual.boxplot(wines, 'free.sulfur.dioxide')
#qual.summary(wines, 'free.sulfur.dioxide')
```
# High quality wines are close average for all wines, except the 9's a bit below.
# The lower the Max. SO~subscript2~, the higher the quality; they go in order. 
# The 3's and 4's deviate from average except for the 3's median. I'm thinking maybe a little 
# bit "too much"" SO~subscript2~ is ok on quality, but way too much SO2 is d
# etrimental.


#---------------------


# CUT FROM "QUALITY and SULFUR DIOXIDE, (total SO2 portion), right before ```{r 
# mean_quality_by_free SO2}```... :

#...What happens if I consolidate the boxplots by my three "categories" of quality?  

```{r totalSO2_boxplot_categorized}
qual.cat.box(wines, 'qual_4cats', 'total.sulfur.dioxide')
```
# Lumping in the 4's with the 3's and 5's makes for a different looking set of 
# boxplots. However, does this mean I'm just hiding the average total SO2
# of quality 4 wines within my "below average" category? Perhaps not. There are 
# only 163 of them, which is 9 times _fewer_ wines than there are at quality grade 5.

#---------------------

# <FROM MULTIVAR>
```{r alcohol_v_quality_by_RS} 
Factor the residual.sugar variable for use in faceting and coloring. 
wines$RS.sweetness <- cut(wines$residual.sugar, breaks
= c(0, 1.2, 4, 12, 66), labels=c('RS <= 1.2', 'RS <= 4', 'RS <= 12', 'RS >
12'))
Plot
ggplot(wines, aes(quality, alcohol, color = RS.sweetness)) + 
  geom_jitter(alpha = .75) + scale_y_continuous(breaks = seq(8, 14, 1)) + 
  scale_x_continuous(breaks = seq(3, 9, 1)) + 
  geom_hline(aes(yintercept = median(wines$alcohol)), color = 'green') + 
  scale_color_brewer(type='seq', palette = 8) + theme_dark()
```
# 
# I wanted to explore whether the relationship between alcohol and quality
# remained consistent when residual sugar was plotted along with them.
# 
# This is a scatter plot of alcohol content vs quality, colored by residual
# sugar levels. Darker-shaded areas within each "bar" of points indicate higher
# RS; lighter shades, less RS. For reference, I drew a horizontal line
# representing the median alcohol content of all wines in the data set.
# 
# As quality gets better (left to right), there are more points above the median
# alcohol line than below it: the expected relationship between alcohol and
# quality. However, the relationship weakens as the wines get "sweeter". Judging
# by the slope of the trend lines, the alcohol-quality relationship is stronger
# at lower RS levels ("dry" and "medium").
# 
# I think this suggests that residual sugar _does_ influence the relationship
# between alcohol and quality, despite the weak correlation between RS and
# quality.
# 
# I can see the negative relationship between RS and alcohol: the shade of each
# "bar" of points becomes darker (more RS) near the bottom (less alcohol).