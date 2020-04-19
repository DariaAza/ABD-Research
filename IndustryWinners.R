# Libraries:
library(ggplot2)
library(gganimate)

# Creating the monthly dataframes

x_03=data.frame(Industry=c('Entertainment','Consumer_Electronics',
                           'KidsToys/Games')
                , GMV_YoY=c(25,22, 376)
                , months=rep('March 2020',3))


x_04=data.frame(Industry=c('Entertainment','Consumer_Electronics',
                           'KidsToys/Games')
                , GMV_YoY=c(206,94, 463)
                , months=rep('April 2020',3))

x_bind=rbind(x_03,x_04)

index <- rep(1:2,each=3)

df_x <- data.frame(index,x_bind[, 1],x_bind[, 2],x_bind[, 3])

df_x
names(df_x) <- c("index", "Industry", "Gross_Merchandise_Volume_YoY", "Month")

df_x


a <- ggplot(df_x, aes(x = Industry,y = Gross_Merchandise_Volume_YoY, fill = Industry)) +
  geom_bar(stat = "identity") +
  labs(title = "Industry Winners in GMV Growth Year-Over-Year due to COVID-19",
       subtitle = "{closest_state}",
       y = "Gross Merchandise Volume Year-Over-Year, %") +
  geom_text(aes(label = as.character(Gross_Merchandise_Volume_YoY), y = Gross_Merchandise_Volume_YoY), vjust = 0.6, hjust = -0.9) +
  scale_fill_manual(' ', values = c("KidsToys/Games" = "#8abbd0", "Entertainment" = "#d4dddd", "Consumer_Electronics" = "#fbb042")) +
  coord_flip(clip = "on", expand = TRUE) +
  theme(axis.text.x = element_text(face = "bold", size = 16),
        axis.text.y = element_text(face = "bold", size = 16),
        plot.title = element_text(size=24),
        plot.subtitle = element_text(size=18),
        axis.title = element_text(face = "bold", size = 18),
        legend.position = "none",
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        # Change axis line
        axis.line = element_line(colour = "black")) +
  transition_states(Month, transition_length = 6, state_length = 6) + 
  enter_fade() + 
  exit_shrink() +
  ease_aes("cubic-in-out")

animate(a, duration = 12, fps = 20, width = 1200, height = 300, renderer = gifski_renderer())

anim_save("GMV_Winners.gif")





