# Quincunx shiny app 0.1 
# Kevin Little, Ph.D.  13 November 2016
#
#

library(shiny)
library(shinyjs)
library(DT)
library(ggplot2)

shinyUI(fluidPage(
  useShinyjs(),
  # Application title
  titlePanel("Management Data App"),

  # Sidebar with a slider input for meter value
  sidebarLayout(
    sidebarPanel(
      actionButton("reset","Tell System to Get Ready!"),
      br(),
      br(),
      div(sliderInput("Meter_Setting",
                  "Meter Setting:",
                  min = 15,
                  max = 45,
                  value = 30),
      # Forms that include a submit button do not automatically update their outputs when inputs change, 
      # rather they wait until the user explicitly clicks the submit button.
      submitButton("Get value"),
      br(),
      helpText("Please click the 'Tell System to Get Ready' button and then click the 'Get Value' button")
      )
      
    ),

    # print the generated value
    mainPanel(
      tabsetPanel(type="tabs",
        tabPanel("Data Display",
          helpText("Here is the value you requested:"),
          br(),
          htmlOutput("Value"),
          br(),
          helpText("Here is the count"),
          br(),
          htmlOutput("Count")),
      
      tabPanel("Admin-T",
        DT::dataTableOutput("records")),
      
      tabPanel("Admin-P",
          plotOutput("plot1"))
    )
  )
 )
))
