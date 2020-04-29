# INFO550_Final
Final Project for INFO 550

This repo contains all of the work for my INFO 550 Final Project. The final deliverable is the nfl_dashboard.R file, which requires 2019_sentiment.rds, post_seasons.rds, pre_seasons.rds, and reg_seasons.rds to run. 

nfl_dashboard.R lists all of its required libraries at the top of the file, and it also requires the nrc lexicon from the tidytext library. To download this lexicon, run "get_sentiments("nrc")" in your instance of R, which will prompt you to download the lexicon.

The remaining files in this repository represent the work needed to create the dashboard and the .rds datasets:
pbp_data_compiler.R reads and aggregates all of the play by play data stored in the /data/ folder.
sentiment_data_compiler.R reads, prepares, and aggregates all of the postseason /r/nfl game thread comments from the /data/ folder for analysis in nfl_dashboard.

test_visualization.R and first_iteration.markdown.R are files containing preliminary iterations of the dashboard.
