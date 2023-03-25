#importing relevant libraries 
library(tidyverse)
library(ggplot2)
library(showtext)

#loading fonts 
font_add_google("VT323", "vt")
font_add_google("Share Tech Mono", "share")
showtext_auto()

#reading the data
tuesdata <- tidytuesdayR::tt_load(2023, week = 12)
languages <- tuesdata$languages


#data wrangling 
languages$appeared <- as.Date(paste0(languages$appeared, "-01-01")) # Converting the 'appeared' column to date
languages <- subset(languages, !is.na(appeared)) # Removing rows with missing values in the 'appeared' column

#aggregations
yearly_counts <- languages %>% 
  group_by(appeared) %>% 
  summarize(count = n())
  
#plotting an area chart + formattings 
ggplot(yearly_counts, aes(x = appeared, y = count)) + 
  geom_area(fill = "#3333FF", alpha = 0.5) + 
  scale_x_date(limits = as.Date(c("1990-01-01", "2020-01-01")), 
               breaks = as.Date(paste0(seq(1990, 2020), "-01-01")), 
               date_labels = "%Y") + 
  scale_y_continuous(breaks = seq(0, 1500, by = 10)) + 
  theme_minimal() + 
  theme(
    plot.title = element_text(family = "vt", size = 26, face = "bold", color = "#00FF00"),
    plot.subtitle = element_text(family = "share", size = 12, color = "#00FF00"),
    plot.caption = element_text(family = "share", size = 9, color = "#00FF00"),
    axis.text = element_text(family = "share", size = 10, color = "white"),
    panel.grid.major = element_line(color = "lightgray", linewidth = 0.005),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "black"),
    plot.background = element_rect(fill = "black"),
    legend.background = element_rect(fill = "black")
  ) + 
  labs(
    title = "Emergence of New Programming Languages Over the Years", 
    subtitle = str_wrap ("There have been more programming languages introduced in 2019 than in any other year during the last three decades", 120), # Subtitle 
    caption = "Analyst: Al'ameen Sanusi I. | Data: Programming Language Database (March 2023)", 
    x = "", y = ""
  )
  
  
