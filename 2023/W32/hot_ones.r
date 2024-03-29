#setting up packages
library(tidytuesdayR)
library(tidyverse)
library(plotly)

#importing data
tuesdata <- tidytuesdayR::tt_load(2023, week = 32)
episodes <- tuesdata$episodes
sauces <- tuesdata$sauces


#Wrangling
sauces_epi <- left_join (sauces, episodes, by = "season", copy = FALSE)
plot_df <- subset(sauces_epi, select = -c(season,sauce_name, episode_overall, episode_season, title, guest, guest_appearance_number, finished))
plot_df$original_release <- format(as.Date(sprl_df$original_release, format="%d-%m-%Y"), "%Y")
plot_df <- plot_df%>%
  group_by(original_release) %>%
  summarize(mean_scoville = mean(scoville))

#plotting chart
fig <- plot_ly(plot_df, x = ~original_release, y = ~mean_scoville, type = 'scatter', mode = 'lines+markers') %>% 
  layout(
    title = list(
      text = "Tracking Mean Scoville Ratings of \nHot Ones Sauces Over Time",
      font = list(family = "Arial", size = 26, color = "#FF0000", face = "bold"),
      x = 0.5,  # Center the title
      xanchor = "centre"),
    xaxis = list(title = list(text = "Year", font = list(family = "Arial", size = 14))),
    yaxis = list(title = list(text = "Mean Scoville (in SHU)", font = list(family = "Arial", size = 14),
          tickvals = seq(50000, 300000, by = 50000))),
    showlegend = FALSE,
    plot_bgcolor = "#f9f9f9", # Background color
    paper_bgcolor = "#f9f9f9", # Plot area color
    font = list(color = "#333"), # Font color
    margin = list(l = 40, r = 20, b = 20, t = 80), # Margins
    annotations = list(
      list(
        text = "Analyst: Al'ameen Sanusi I. | Data: Hot Ones (August 2023)",
        font = list(family = "Arial", size = 10, color = "#666"),
        x = 1,
        y = 0,
        xref = "paper",
        yref = "paper",
        showarrow = FALSE
      )
    )
  )
fig
