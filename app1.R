source(here::here('packages.R'))

# User Interface

ui = fluidPage(
  
  #Title
  titlePanel("My First shinny Example: PDF of Normal Distribution"),
  
  #Slidebar Layout
  sidebarLayout(sidebarPanel(
    
    # On left side of page
    sliderInput("mean", "Mean", min=-40, max=40, value=0, step = 0.01),
    sliderInput("sd", "Standard Deviation", min=0, max=10, value=1, step = 0.1)),
    #colorInput("selected_color", "Select a Color", value = "#FF5733")),
  
     # On the centre-right of the page
    mainPanel(
      plotOutput("plt")
    ))
  
)

server = function(input,output){
  
  output$plt = renderPlot({
    
    mu= input$mean
    sd= input$sd
    x= seq(-50,50,0.01)
    y= dnorm(x,mu,sd)
    plot(x,y,type = "l",xlab = "Value",ylab = "Probabilities",main =paste("PDF of a Normal(",mu,",",sd,") distribution") )
    
  })
  
}

shinyApp(ui=ui,server = server)






