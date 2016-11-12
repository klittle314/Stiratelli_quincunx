
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(animation)
library(shinyjs)
source("script1.R")

shinyServer(function(input, output) {
  values <- reactiveValues()
  values$data <- df1
  observeEvent(input$reset, {
    count1 <- input$reset
    data1 <- values$data
    drop_value <- reactive({
      meter_val <- input$Meter_Setting
      if(count1 <=20) {
            out_value <- single_drop1(meter=meter_val)
      } else if (count1 > 20 && count1 <= 40) {
            #if(!is.null(data1[20,2]) && data1[20,2] < 50) {
            #if(!is.na(data1[20,2])){
              if(mean(data1[c(1:20),2],na.rm=TRUE) < 50) {
                  out_value <- single_drop1(meter=meter_val,
                                    offset=10)
            } else out_value <- single_drop1(meter=meter_val,
                                    offset=16)
      } else if (count1 > 40) {
          if(mean(data1[c(21:40),2],na.rm=TRUE) < 50) {
              out_value <- single_drop1(meter=meter_val,
                                    offset=9)
          } else out_value <- single_drop1(meter=meter_val,
                                    offset=17)
      } 
        #return(out_value)
      })
      new_row <- t(c(count1,drop_value(),input$Meter_Setting))
      
      values$data <- rbind(values$data,new_row)
      # names(values$data)[1] <- "index1"
      # names(values$data)[2] <- "value"
      
  
  
  # record_set <- reactive({
  #   value2 <- as.numeric(drop_value())
  #   data2 <- values$data
  #   count1 <- input$reset
  #   new_row <- t(c(count1,value2))
  #   records <- rbind(data2,new_row)
  #   values$data <- records
  #   
  # })
    
  value_now <- reactive({
    value2 <-drop_value()
  })
  
  output$Value <- renderUI({
     value1 <- tags$div(tags$h1(as.character(drop_value())))
  })
  
  output$Count <- renderUI({
     value2 <- tags$div(tags$h1(as.character(input$reset)))
  })
 
  output$records <- DT::renderDataTable({
    records <- values$data
    names(records)[1] <- "index"
    names(records)[2] <- "value"
    names(records)[3] <- "meter setting"
    records[,1] <- as.integer(records[,1])
    records[,2] <- as.integer(records[,2])
    DT::datatable(records, options = list(pageLength = 25),rownames=TRUE)
  })
  
  output$plot1 <- renderPlot({
    data1 <- values$data
    names(data1)[1] <- "index"
    names(data1)[2] <- "value"
    data1$row_index <- as.integer(rownames(data1))
    p1 <- ggplot(data1,aes(x=row_index,y=value))+
          theme_bw()+
          geom_rect(aes(NULL, NULL, xmin = 0, 
                    xmax = 60), fill = alpha('yellow', 0.5),
                ymin = 47.8, ymax = 52.2) +
          geom_point(size=rel(2))+
          geom_line()+
          ylim(40,60)+
          geom_hline(yintercept=median(data1$value),linetype="dashed")+
          ggtitle("Run chart with desired range shaded \n Dashed horizontal line is median")+
          geom_vline(xintercept=20,linetype=5,color="blue")+
          geom_vline(xintercept=40,linetype=5,color="blue")
            
  print(p1)
  })
  
  }) 
 
})
