library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(RedditExtractoR)


# Read in one year's data
pre_2019 = read_csv("data/pre_season/pre_pbp_2009.csv")
reg_2019 = read_csv("data/regular_season/reg_pbp_2009.csv")
post_2019 = read_csv("data/post_season/post_pbp_2009.csv")

# Look at data
summary(reg_2019)
head(reg_2019)

# How many 4th downs per season? ~ 4,000 in the regular season, 8-10% of plays, 10 in pre-season -> 8 in post-season
table(pre_2019$down)/nrow(pre_2019)
table(reg_2019$down)/nrow(reg_2019)
table(post_2019$down)/nrow(post_2019)

par(mfrow=c(2,2))
barplot(prop.table(table(pre_2019$down)), main = "Pre-season 2019", xlab = "Play Down", ylab = "Frequency")
barplot(prop.table(table(reg_2019$down)), main = "Regular Season 2019", xlab = "Play Down", ylab = "Frequency")
barplot(prop.table(table(post_2019$down)), main = "Post-season 2019", xlab = "Play Down", ylab = "Frequency")



# How many 4th downs per game? ~ 16 4th downs per game
fourth = reg_2019 %>% 
  filter(down == 4) %>%
  group_by(game_id) %>%
  summarize(count = n())

fourth %>% summarize(mean(count))


# Make one regular season rds file for analysis
reg_2009 <- read_csv("data/regular_season/reg_pbp_2009.csv")
reg_2010 <- read_csv("data/regular_season/reg_pbp_2010.csv")
reg_2011 <- read_csv("data/regular_season/reg_pbp_2011.csv")
reg_2012 <- read_csv("data/regular_season/reg_pbp_2012.csv")
reg_2013 <- read_csv("data/regular_season/reg_pbp_2013.csv")
reg_2014 <- read_csv("data/regular_season/reg_pbp_2014.csv")
reg_2015 <- read_csv("data/regular_season/reg_pbp_2015.csv")
reg_2016 <- read_csv("data/regular_season/reg_pbp_2016.csv")
reg_2017 <- read_csv("data/regular_season/reg_pbp_2017.csv")
reg_2018 <- read_csv("data/regular_season/reg_pbp_2018.csv")
reg_2019 <- read_csv("data/regular_season/reg_pbp_2019.csv")

reg_2009$Season = 2009
reg_2010$Season = 2010
reg_2011$Season = 2011
reg_2012$Season = 2012
reg_2013$Season = 2013
reg_2014$Season = 2014
reg_2015$Season = 2015
reg_2016$Season = 2016
reg_2017$Season = 2017
reg_2018$Season = 2018
reg_2019$Season = 2019


reg_seasons = rbind(reg_2009,
      reg_2010,
      reg_2011,
      reg_2012,
      reg_2013,
      reg_2014,
      reg_2015,
      reg_2016,
      reg_2017,
      reg_2018,
      reg_2019)
reg_seasons = within(reg_seasons, rm(desc))


saveRDS(reg_seasons, "reg_seasons.rds")

# Make one preseason season rds file for analysis
pre_2009 <- read_csv("data/pre_season/pre_pbp_2009.csv")
pre_2010 <- read_csv("data/pre_season/pre_pbp_2010.csv")
pre_2011 <- read_csv("data/pre_season/pre_pbp_2011.csv")
pre_2012 <- read_csv("data/pre_season/pre_pbp_2012.csv")
pre_2013 <- read_csv("data/pre_season/pre_pbp_2013.csv")
pre_2014 <- read_csv("data/pre_season/pre_pbp_2014.csv")
pre_2015 <- read_csv("data/pre_season/pre_pbp_2015.csv")
pre_2016 <- read_csv("data/pre_season/pre_pbp_2016.csv")
pre_2017 <- read_csv("data/pre_season/pre_pbp_2017.csv")
pre_2018 <- read_csv("data/pre_season/pre_pbp_2018.csv")
pre_2019 <- read_csv("data/pre_season/pre_pbp_2019.csv")

pre_2009$Season = 2009
pre_2010$Season = 2010
pre_2011$Season = 2011
pre_2012$Season = 2012
pre_2013$Season = 2013
pre_2014$Season = 2014
pre_2015$Season = 2015
pre_2016$Season = 2016
pre_2017$Season = 2017
pre_2018$Season = 2018
pre_2019$Season = 2019


pre_seasons = rbind(pre_2009,
                    pre_2010,
                    pre_2011,
                    pre_2012,
                    pre_2013,
                    pre_2014,
                    pre_2015,
                    pre_2016,
                    pre_2017,
                    pre_2018,
                    pre_2019)

pre_seasons = within(pre_seasons, rm(desc))

saveRDS(pre_seasons, "pre_seasons.rds")

# Make one postseason season rds file for analysis
post_2009 <- read_csv("data/post_season/post_pbp_2009.csv")
post_2010 <- read_csv("data/post_season/post_pbp_2010.csv")
post_2011 <- read_csv("data/post_season/post_pbp_2011.csv")
post_2012 <- read_csv("data/post_season/post_pbp_2012.csv")
post_2013 <- read_csv("data/post_season/post_pbp_2013.csv")
post_2014 <- read_csv("data/post_season/post_pbp_2014.csv")
post_2015 <- read_csv("data/post_season/post_pbp_2015.csv")
post_2016 <- read_csv("data/post_season/post_pbp_2016.csv")
post_2017 <- read_csv("data/post_season/post_pbp_2017.csv")
post_2018 <- read_csv("data/post_season/post_pbp_2018.csv")
post_2019 <- read_csv("data/post_season/post_pbp_2019.csv")

post_2019 = post_2019[, !(colnames(post_2019) %in% c("X1"))]

post_2009$Season = 2009
post_2010$Season = 2010
post_2011$Season = 2011
post_2012$Season = 2012
post_2013$Season = 2013
post_2014$Season = 2014
post_2015$Season = 2015
post_2016$Season = 2016
post_2017$Season = 2017
post_2018$Season = 2018
post_2019$Season = 2019


post_seasons = rbind(post_2009,
                    post_2010,
                    post_2011,
                    post_2012,
                    post_2013,
                    post_2014,
                    post_2015,
                    post_2016,
                    post_2017,
                    post_2018,
                    post_2019)

within(post_seasons, rm(x))

saveRDS(post_seasons, "post_seasons.rds")



# Test Reddit scraping

Reddit_url = "https://www.reddit.com/r/nfl/comments/e4kgbx/game_thread_san_francisco_49ers_101_at_baltimore"
url_data = reddit_content(Reddit_url)

table(url_data$comment_score)
table(url_data$controversiality)
