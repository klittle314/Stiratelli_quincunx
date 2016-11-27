
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
    med1 <- median(data1[1:20,2],na.rm=TRUE)
    med2 <- median(data1[21:40,2], na.rm=TRUE)
    med3 <- median(data1[41:60,2], na.rm=TRUE)
    epoch1 <- cbind.data.frame(c(1:20),med1)
    names(epoch1)[1] <- "row_index"
    names(epoch1)[2] <- "value"
    epoch2 <- cbind.data.frame(c(21:40),med2)
    names(epoch2)[1] <- "row_index"
    names(epoch2)[2] <- "value"
    epoch3 <- cbind.data.frame(c(41:60),med1)
    names(epoch3)[1] <- "row_index"
    names(epoch3)[2] <- "value"
    p1 <- ggplot(data1,aes(x=row_index,y=value))+
          theme_bw()+
          geom_rect(aes(NULL, NULL, xmin = 0, 
                    xmax = 60), fill = alpha('yellow', 0.5),
                ymin = 47.8, ymax = 52.2) +
          geom_point(size=rel(2))+
          geom_line()+
          ylim(40,60)+
          #geom_hline(yintercept=median(data1$value),linetype="dashed")+
          ggtitle("Run chart with desired range shaded \n Dashed horizontal line is median for each epoch")+
          geom_vline(xintercept=20,linetype=5,color="blue")+
          geom_vline(xintercept=40,linetype=5,color="blue")
    
   p2 <- p1 + geom_line(data=epoch1,aes(x=row_index,y=med1),linetype="dashed")+
     geom_line(data=epoch2,aes(x=row_index,y=med2),linetype="dashed")+
     geom_line(data=epoch3,aes(x=row_index,y=med3),linetype="dashed")
            
  print(p2)
  })
  
  }) 
 
})
