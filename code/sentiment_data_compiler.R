library(tidyverse)
library(lubridate)
library(tidytext)
library(ggjoy)
library(textdata)


# Prep scraped data for sentiment analysis
# Attach each game with its corresponding game_id, clean up formatting of variables, 
# and unnest tokens in prepration for sentiment analysis. Compile all datasets into one RDS dataset.

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

# sf kc 
sf_kc = read.csv("data/sf_kc.csv", stringsAsFactors = FALSE)
sf_kc = sf_kc %>%
  mutate(game_id = 2020020200) %>%
  mutate(Created = as_datetime(Created)) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
sf_kc = as_tibble(sf_kc)
sf_kc_sentiment = sf_kc %>%
  unnest_tokens(word, Body)

# ten kc
ten_kc = read.csv("data/ten_kc.csv", stringsAsFactors = FALSE)
ten_kc = ten_kc %>%
  mutate(game_id = 2020011900) %>%
  mutate(Created = as_datetime(Created)) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
ten_kc = as_tibble(ten_kc)
ten_kc_sentiment = ten_kc %>%
  unnest_tokens(word, Body)

# gb sf
gb_sf = read.csv("data/gb_sf.csv", stringsAsFactors = FALSE)
gb_sf = gb_sf %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020011901) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
gb_sf = as_tibble(gb_sf)
gb_sf_sentiment = gb_sf %>%
  unnest_tokens(word, Body)

# hou kc
hou_kc = read.csv("data/hou_kc.csv", stringsAsFactors = FALSE)
hou_kc = hou_kc %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020011200) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
hou_kc = as_tibble(hou_kc)
hou_kc_sentiment = hou_kc %>%
  unnest_tokens(word, Body)

# sea gb
sea_gb = read.csv("data/sea_gb.csv", stringsAsFactors = FALSE)
sea_gb = sea_gb %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020011201) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
sea_gb = as_tibble(sea_gb)
sea_gb_sentiment = sea_gb %>%
  unnest_tokens(word, Body)

# ten bal
ten_bal = read.csv("data/ten_bal.csv", stringsAsFactors = FALSE)
ten_bal = ten_bal %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020011101) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
ten_bal = as_tibble(ten_bal)
ten_bal_sentiment = ten_bal %>%
  unnest_tokens(word, Body)

# min sf
min_sf = read.csv("data/min_sf.csv", stringsAsFactors = FALSE)
min_sf = min_sf %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020011100) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
min_sf = as_tibble(min_sf)
min_sf_sentiment = min_sf %>%
  unnest_tokens(word, Body)

# sea phi
sea_phi = read.csv("data/sea_phi.csv", stringsAsFactors = FALSE)
sea_phi = sea_phi %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020010501) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
sea_phi = as_tibble(sea_phi)
sea_phi_sentiment = sea_phi %>%
  unnest_tokens(word, Body)

# min no
min_no = read.csv("data/min_no.csv", stringsAsFactors = FALSE)
min_no = min_no %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2010012401) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
min_no = as_tibble(min_no)
min_no_sentiment = min_no %>%
  unnest_tokens(word, Body)

# ten ne
ten_ne = read.csv("data/ten_ne.csv", stringsAsFactors = FALSE)
ten_ne = ten_ne %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020010401) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
ten_ne = as_tibble(ten_ne)
ten_ne_sentiment = ten_ne %>%
  unnest_tokens(word, Body)

# hou buff
hou_buff = read.csv("data/hou_buff.csv", stringsAsFactors = FALSE)
hou_buff = hou_buff %>%
  mutate(Created = as_datetime(Created)) %>%
  mutate(game_id = 2020010400) %>%
  select(game_id, Score, Created, Body) %>%
  filter(Created <= min(Created) + hours(1))
hou_buff = as_tibble(hou_buff)
hou_buff_sentiment = hou_buff %>%
  unnest_tokens(word, Body)


sentiments = rbind(gb_sf_sentiment,
                     hou_buff_sentiment,
                     hou_kc_sentiment,
                     min_no_sentiment,
                     min_sf_sentiment,
                     sea_gb_sentiment,
                     sea_phi_sentiment,
                     sf_kc_sentiment,
                     ten_bal_sentiment,
                     ten_kc_sentiment,
                     ten_ne_sentiment)

saveRDS(sentiments, "2019_sentiments.rds")


### PREVIOUS DATA EXPLORATION
# post = readRDS("post_seasons.rds")
# 
# risky = post %>%
#   filter(Season == 2019, down == 4, !play_type %in% c("punt", "field_goal"), ydstogo > 3, game_id != 2020012600)
# 
# # 10 post season games with risky plays (11 playoff games played)
# unique(risky$game_id)
# 
# table(risky$ydstogo)
# 
# risky %>%
#   distinct(game_id, home_team, away_team) %>%
#   arrange(game_id) %>%
#   select(home_team, away_team)
# 
# # Game threads to scrape:
# # 1 HOU       BUF      
# # 2 NE        TEN      
# # 3 PHI       SEA      
# # 4 SF        MIN      
# # 5 BAL       TEN      
# # 6 KC        HOU      
# # 7 GB        SEA      
# # 8 KC        TEN      
# # 9 SF        GB       
# # 10 KC        SF    
# 
# 
# 
# # Houston vs Buffalo
# hou_buff = read.csv("data/hou_buff.csv", stringsAsFactors = FALSE)
# 
# # Convert UNIX time to regular time stamp
# hou_buff = hou_buff %>%
#   mutate(Created = as_datetime(Created)) %>%
#   select(Score, Created, Body) %>%
#   filter(Created <= min(Created) + hours(1))
# 
# 
# hou_buff = as_tibble(hou_buff)
# 
# # Calculate sentiment
# hou_buff_sentiment = hou_buff %>%
#   unnest_tokens(word, Body)
# 
# word_count = hou_buff_sentiment %>%
#   count(word, sort = TRUE) 
# 
# my_stop_words <- tibble(
#   word = c(
#     "https",
#     "fucking",
#     "fuck",
#     "shit",
#     "football",
#     "nfl",
#     "league"
#   ),
#   lexicon = "reddit"
# )
# 
# all_stop_words <- stop_words %>%
#   bind_rows(my_stop_words)
# 
# 
# hou_buff_sentiment = hou_buff_sentiment %>%
#   anti_join(all_stop_words) %>%
#   inner_join(get_sentiments("nrc"), by = "word")
# 
# # %>%
# #   mutate(score = ifelse(sentiment == "positive", 1, -1)) %>%
# #   group_by(Created) %>%
# #   summarize(sent_total = sum(score, na.rm = TRUE))
# 
# 
# hou_buff_risky = risky %>%
#   filter(game_id == 2020010400) %>%
#   mutate(time = ymd_hms(paste(game_date, time)))
# 
# 
# # # Plot sentiment over time, overlay with risky plays
# # hou_buff_sentiment %>%
# #   ggplot(aes(x=Created, y=sent_total)) +
# #   geom_line() 
# # +  geom_vline(data = hou_buff_risky, aes(xintercept = time))
# 
# 
# 
# # Visualize different sentiments over time
# 
# hou_buff_sentiment %>%
#   ggplot() +
#   geom_joy(aes(
#     x = Created,
#     y = sentiment, 
#     fill = sentiment),
#     rel_min_height = 0.01,
#     alpha = 0.7,
#     scale = 3) +
#   theme_joy() +
#   labs(title = "/r/nfl HOU vs. BUF sentiment analysis",
#        x = "Comment Date",
#        y = "Sentiment") + 
#   scale_fill_discrete(guide=FALSE)

