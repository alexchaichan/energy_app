#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
fluidPage(# Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      # position of the sidebar
      position = c("left"),
      
      # width sidebar panel
      width = 2,
      
      # numeric input to choose the year to filter the dataset
      numericInput(
        'year',
        'Year:',
        value = 2019,
        min = 2019,
        max = 2022
      ),
      
      # radio buttons to choose energy form
      radioButtons(
        'energy',
        "Energieform:",
        choices = c(
          'Biomasse ' = 'biomass',
          'Wasser' = 'hydro',
          'Wind Onshore' = 'wind_onshore',
          'Wind Offshore' = 'wind_offshore',
          'Photovoltaik' = 'pv',
          'Atomenergie' = 'nuclear',
          'Braunkohle' = 'lignite',
          'Steinkohle' = 'hard_coal',
          'Erdgas' = 'natural_gas',
          'Pumpspeicherwerke' = 'hydro_pump',
          'Andere' = 'others'
        )
      )
    ),
    
    # main panel
    mainPanel(tabsetPanel(
      tabPanel('Plot1', br(),
               plotOutput("linePlot")),
      tabPanel('Plot2', br(),
               plotOutput("barPlot")),
      tabPanel(
        'Plot3',
        # numeric input for the 3rd tabPanel to filter for the week
        numericInput(
          'week',
          'Week:',
          value = 1,
          min = 1,
          max = 53
        ),
        br(),
        plotOutput("stakareaPlot")
      )
    ))
  ))
