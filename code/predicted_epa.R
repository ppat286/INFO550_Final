library(tidyverse)
library(shiny)
library(plotly)
library(reshape)
library(forcats)

reg = readRDS("D:/Priyam/Desktop/INFO550_Final/code/reg_seasons.rds")

test = reg %>%
  filter(Season == 2019, down == 1, game_seconds_remaining <= 15*60, !is.na(play_type)) %>%
  select(Season, game_seconds_remaining, down, yardline_100, play_type, epa) %>%
  group_by(yardline_100, play_type) %>%
  mutate(success = ifelse(epa > 0, 1, 0)) %>%
  summarize(positive = sum(success, na.rm = TRUE), plays = n()) %>%
  mutate(convert = positive/plays) %>%
  ungroup() %>%
  complete(play_type, nesting(yardline_100), fill = list(positive = 0, plays = 0, convert = 0)) %>%
  arrange(yardline_100)


test %>% 
  ggplot(aes(x = yardline_100, y = convert, color = play_type)) + geom_line()
