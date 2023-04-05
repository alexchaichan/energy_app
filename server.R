#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  
  # generate bins based on input$bins from ui.R
  
  load('data/data.RData')
  

  
  
  
  
  
  plot_data_line <- reactive({
    data %>%
      filter(year == input$year) %>%
      select(date_time,input$energy)
    
  })
  

  output$linePlot <- renderPlotly({
    
    plot_line <- plot_data_line() %>% 
      ggplot(aes(x= date_time, y = .[[2]])) +
      geom_line(color = 'red') +
      geom_line(data =
                  data %>%
                  filter(year == input$year) %>%
                  select(date_time:others) %>%
                  pivot_longer(biomass:others,
                               names_to = 'energy',
                               values_to = 'value') %>%
                  group_by(date_time) %>%
                  summarise(value = sum(value, na.rm = TRUE)),
                aes(x= date_time, y = value)) +
      # geom_line(data =
      #             data %>%
      #             filter(year == input$year) %>%
      #             select(date_time, pv) %>%
      #             group_by(week(date_time)) %>%
      #             mutate(mean = mean(pv, na.rm = TRUE)),
      #           aes(x = date_time, y = mean)) +
      geom_smooth() +
      geom_line (data =
                   data %>%
                   filter(year == input$year) %>%
                   select(date_time, consumption),
                 aes(x = date_time, y = consumption),
                 color = 'green') +
      labs(title = paste0("Nettostromerzeugung vs. Verbrauch ", input$energy, ' ', input$year),
           caption = "Data: Agora Energiewende",
           x = 'Date',
           y = 'MW') +
      theme_classic()
    
    ggplotly(plot_line) %>%
      layout(xaxis = list(rangeslider = list()))
  })
  
  
  plot_data_stack_area <- reactive({
    data %>% 
      filter(year == input$year) %>% 
      filter(week(date_time) == input$week) %>% 
      select(date_time:others) %>% 
      pivot_longer(biomass:others,
                   names_to = 'energy',
                   values_to = 'value')  %>%
      group_by(date_time, energy) %>% 
      summarise(value = sum(value)) %>%
      rename("energy" = 2)
    
  })
  
  
  output$plot_stack_area <- renderPlotly({
    
    p <- plot_data_stack_area() %>% 
      ggplot() +
      geom_area(aes(x = date_time, y = value, fill = energy), alpha=0.6 , linewidth=.5, colour="white") +
      # geom_line(data =
      #             data %>%
      #             filter(year == input$year) %>% 
      #             filter(week(date_time) == input$week) %>% 
      #             select(date_time, consumption),
      #           aes(x= date_time, y = consumption)) +
      labs(title = paste0("Nettostromerzeugung in Deutschland ", 'in Woche ',  input$week, ' ', input$year),
           caption = "Data: Agora Energiewende",
           x = 'Date',
           y = 'MW') +
      theme_classic()
    
    ggplotly(p)
  })
  

}
