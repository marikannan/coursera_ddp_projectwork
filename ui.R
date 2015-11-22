library(shiny)
require(rCharts)

rainData <- read.csv("india_rainfall.csv",header=TRUE)
month_list <- c("JUN","JUL","AUG","SEP")

# Main Page
shinyUI(
  fluidPage(
    h1("India Monsoon Rainfall : 1901 - 2013"),
    sidebarLayout(
      sidebarPanel(
        conditionalPanel(2,
               selectInput("YEAR",
                           "YEAR:",
                           c("All",as.character(rainData$YEAR)))
               ),
        conditionalPanel(2, 
               checkboxGroupInput('show_months', 'MONSOON MONTH:',
                                  month_list, selected = c("YEAR",month_list))
               ),
        br(),
        br(),
        br(),
        br(),
        h4("Purpose :"),
        p('Ths purpose of this project is to give graphical insight in rainfall in the last century in India '),
        h4("Usage :"),
        p('By default this application displays rain fall data for all the years from 1901-2013 for all the monsoon months from June to Sep.
          To see a details for a sepecify year, you can choose the year from the dropdown and you can check any specific month to view.
          In all the cases the total rainfaill ( JUN to SEP - JUN.SEP) will be displayed.Based on the month selection it displays the line graph from 1901-2013')
        ),
      mainPanel(
        DT::dataTableOutput("table"),
        showOutput("myChart", "polycharts")
      )
    )
  )
)
