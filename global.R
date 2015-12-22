library(dplyr)
library(XLConnect)
library(shiny)
library(shinydashboard)
library(d3heatmap)

# See https://ttso.shinyapps.io/altm2015top100

# Read in Altmetric data and merge affiliation data with ID
wb <- loadWorkbook("altmetrictop1002015.xlsx")
top <- readWorksheet(wb, sheet = "Top 100", header = TRUE)
aff <- readWorksheet(wb, sheet = "Institutional affiliations", header = TRUE)
top_aff <- merge(top, aff, by.x = "id", by.y = "altmetric_id")

# Correction: States -> United States
top_aff$country[top_aff$country == "States"] <- "United States"

# Sorted list of country names, for selection
countries <- sort(unique(aff$country))

# Data for heatmap by category
top100 <- top %>%
  group_by(categories) %>%
  summarise(score = round(mean(score), digits=2),
            news = round(mean(count_news), digits=2),
            blogs = round(mean(count_blogs), digits=2),
            twitter = round(mean(count_twitter), digits=2), 
            facebook = round(mean(count_facebook), digits=2),
            peerReview = round(mean(count_peer_review), digits=2),
            weibo = round(mean(count_weibo), digits=2),
            googlePlus = round(mean(count_google_plus), digits=2),
            reddit = round(mean(count_reddit), digits=2),
            researchHi = round(mean(count_research_hi), digits=2),
            video = round(mean(count_video), digits=2),
            wikipedia = round(mean(count_wikipedia), digits=2))

row.names(top100) <- top100$categories
top100 <- top100 %>%
  select(-categories)



# Data for heatmap by country
top100c <- top_aff %>%
  group_by(country) %>%
  summarise(score = round(mean(score), digits=2),
            news = round(mean(count_news), digits=2),
            blogs = round(mean(count_blogs), digits=2),
            twitter = round(mean(count_twitter), digits=2), 
            facebook = round(mean(count_facebook), digits=2),
            peerReview = round(mean(count_peer_review), digits=2),
            weibo = round(mean(count_weibo), digits=2),
            googlePlus = round(mean(count_google_plus), digits=2),
            reddit = round(mean(count_reddit), digits=2),
            researchHi = round(mean(count_research_hi), digits=2),
            video = round(mean(count_video), digits=2),
            wikipedia = round(mean(count_wikipedia), digits=2))

row.names(top100c) <- top100c$country
top100c <- top100c %>%
  select(-country)




# Data for reactive heatmap by country and category
top100cat <- top_aff %>%
  group_by(country, categories) %>%
  summarise(score = round(mean(score), digits=2),
            news = round(mean(count_news), digits=2),
            blogs = round(mean(count_blogs), digits=2),
            twitter = round(mean(count_twitter), digits=2), 
            facebook = round(mean(count_facebook), digits=2),
            peerReview = round(mean(count_peer_review), digits=2),
            weibo = round(mean(count_weibo), digits=2),
            googlePlus = round(mean(count_google_plus), digits=2),
            reddit = round(mean(count_reddit), digits=2),
            researchHi = round(mean(count_research_hi), digits=2),
            video = round(mean(count_video), digits=2),
            wikipedia = round(mean(count_wikipedia), digits=2)) 
