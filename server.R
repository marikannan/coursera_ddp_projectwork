library(shiny)
library(dplyr)
require(rCharts)

month_list <- c("JUN","JUL","AUG","SEP")
rainData <- read.csv("india_rainfall.csv",header=TRUE)

# Define a server for the Shiny app
shinyServer(function(input, output) {
    # data table to display
    output$table <- DT::renderDataTable(DT::datatable({
    data <- rainData
    if (input$YEAR != "All") {
      data <- data[data$YEAR == input$YEAR,]
    }
    # always display total monsoon rain fall ie JUNE to SEPTEMBER
    data <- data[,c("YEAR",input$show_months,"JUN.SEP"), drop = FALSE] 
    data
  }))
    
  # plot
  output$myChart <- renderChart({
    p1 <- mPlot(x = "YEAR", y = input$show_months, type = "Line", data = rainData)
    p1$addParams(dom = 'myChart')
    return(p1)
    })
})
