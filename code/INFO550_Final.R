library(dplyr)
library(readr)
library(ggplot2)


# Read in one year's data

reg_2009 <- read_csv("data/regular_season/reg_pbp_2009.csv")





# reg_2010 <- read_csv("data/regular_season/reg_pbp_2010.csv")
# reg_2011 <- read_csv("data/regular_season/reg_pbp_2011.csv")
# reg_2012 <- read_csv("data/regular_season/reg_pbp_2012.csv")
# reg_2013 <- read_csv("data/regular_season/reg_pbp_2013.csv")
# reg_2014 <- read_csv("data/regular_season/reg_pbp_2014.csv")
# reg_2015 <- read_csv("data/regular_season/reg_pbp_2015.csv")
# reg_2016 <- read_csv("data/regular_season/reg_pbp_2016.csv")
# reg_2017 <- read_csv("data/regular_season/reg_pbp_2017.csv")
# reg_2018 <- read_csv("data/regular_season/reg_pbp_2018.csv")
# reg_2019 <- read_csv("data/regular_season/reg_pbp_2019.csv")

# Look at data
summary(reg_2009)
head(reg_2009)

# How many 4th downs per season? ~ 4,000 in the regular season
table(reg_2009$down)

# How many 4th downs per game? ~ 16 4th downs per game
fourth = reg_2009 %>% 
  filter(down == 4) %>%
  group_by(game_id) %>%
  summarize(count = n())

fourth %>% summarize(mean(count))
