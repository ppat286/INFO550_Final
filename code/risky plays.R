library(tidyverse)
library(lubridate)
library(tidytext)
library(ggjoy)
library(textdata)


post = readRDS("D:/Priyam/Desktop/INFO550_Final/code/post_seasons.rds")

risky = post %>%
  filter(Season == 2019, down == 4, !play_type %in% c("punt", "field_goal"), ydstogo > 3, game_id != 2020012600)

# 10 post season games with risky plays (11 playoff games played)
unique(risky$game_id)

table(risky$ydstogo)

risky %>%
  distinct(game_id, home_team, away_team) %>%
  arrange(game_id) %>%
  select(home_team, away_team)

# Game threads to scrape:
# 1 HOU       BUF      
# 2 NE        TEN      
# 3 PHI       SEA      
# 4 SF        MIN      
# 5 BAL       TEN      
# 6 KC        HOU      
# 7 GB        SEA      
# 8 KC        TEN      
# 9 SF        GB       
# 10 KC        SF    



# Houston vs Buffalo
hou_buff = read.csv("data/hou_buff.csv", stringsAsFactors = FALSE)

# Convert UNIX time to regular time stamp
hou_buff = hou_buff %>%
  mutate(Created = as_datetime(Created)) %>%
  select(Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))


hou_buff = as_tibble(hou_buff)

# Calculate sentiment
hou_buff_sentiment = hou_buff %>%
  unnest_tokens(word, Body)

word_count = hou_buff_sentiment %>%
  count(word, sort = TRUE) 

my_stop_words <- tibble(
  word = c(
    "https",
    "fucking",
    "fuck",
    "shit",
    "football",
    "nfl",
    "league"
  ),
  lexicon = "reddit"
)

all_stop_words <- stop_words %>%
  bind_rows(my_stop_words)


hou_buff_sentiment = hou_buff_sentiment %>%
  anti_join(all_stop_words) %>%
  inner_join(get_sentiments("nrc"), by = "word")

# %>%
#   mutate(score = ifelse(sentiment == "positive", 1, -1)) %>%
#   group_by(Created) %>%
#   summarize(sent_total = sum(score, na.rm = TRUE))


hou_buff_risky = risky %>%
  filter(game_id == 2020010400) %>%
  mutate(time = ymd_hms(paste(game_date, time)))


# # Plot sentiment over time, overlay with risky plays
# hou_buff_sentiment %>%
#   ggplot(aes(x=Created, y=sent_total)) +
#   geom_line() 
# +  geom_vline(data = hou_buff_risky, aes(xintercept = time))



# Visualize different sentiments over time

hou_buff_sentiment %>%
  ggplot() +
  geom_joy(aes(
    x = Created,
    y = sentiment, 
    fill = sentiment),
    rel_min_height = 0.01,
    alpha = 0.7,
    scale = 3) +
  theme_joy() +
  labs(title = "/r/nfl HOU vs. BUF sentiment analysis",
       x = "Comment Date",
       y = "Sentiment") + 
  scale_fill_discrete(guide=FALSE)



