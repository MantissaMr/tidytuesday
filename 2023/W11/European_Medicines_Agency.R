#importing relevant libraries
library(tidyverse)    # For data manipulation and visualization
library(ggplot2)      # For creating visualizations

#reading the data
drugs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-14/drugs.csv', show_col_types = FALSE)

#plotting chart
drugs %>%
  filter(!is.na(authorisation_status)) %>%
  count(authorisation_status, category) %>%
  ggplot(aes(x = authorisation_status, y = n , fill = category)) +   # x-axis: authorisation status, y-axis: number of drugs, fill: category
  geom_col(position = "dodge") +     # Bar chart with grouped bars
  labs(
    title = str_wrap("Tracking the Approval of Human and Veterinary Drugs in Europe", 40),   # Title of the chart
    subtitle = str_wrap ("Number of human & veterinary drugs between 1995 and 2023, split by authorisation status.", 60),   # Subtitle
    caption = "Data: European Medicines Agency",   # Caption
    x = "", y ="" 
  ) +
  scale_fill_brewer(palette = "Pastel1", name = "species") +   # Color scheme for the categories
  scale_y_continuous(breaks = seq(0, 1500, by = 100)) +    # Y-axis tick marks
  theme_minimal() + 
  theme(
    plot.title = element_text(family = "sans", size = 18, face = "bold"),   # Title font and size
    plot.subtitle = element_text(family = "sans", size = 12),    # Subtitle font and size
    axis.text = element_text(family = "sans", size = 10),   # Axis font and size
    legend.text = element_text(family = "sans", size = 8),   # Legend font and size
    panel.grid.major = element_line(color = "lightgray", size = 0.05),   # Light gray gridlines
    panel.grid.minor = element_blank() # No minor gridlines
  )
