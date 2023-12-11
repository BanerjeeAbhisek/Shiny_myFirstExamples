source(here::here("packages.R"))

# My first example of Shiny dashbrard......

ui1 =dashboardPage(
  
  # Dashboard Header
  dashboardHeader(),
  
  # Dashboard Sidebar
  dashboardSidebar(),
  
  # Dashboard Body
  dashboardBody()
)




server1= function(){
  
  # Empty
}

# Call Shiny

shinyApp(ui=ui, server = server)



# My second example of Shiny Dashboard .....

ui2 = dashboardPage(
  
  # Dashboard Header
  
  dashboardHeader(
    title = "My Shiny DashBoard",
    titleWidth = "300px"
      
  ),
  
  #Dashboard Sidebar
  dashboardSidebar(),
  
  #Dashboard main page
  dashboardBody(
    fluidPage(
      titlePanel("This is just a title of fluid page"),
      mainPanel(plotOutput("example_plot1")),
      sidebarPanel(
        numericInput("x", "Bins", value = 1, min = 1, step = 1)
        
      )
    )
  )
)


server2= function(input,output){
  # Inputs
  bins= reactive(input$x)
  data_r= rnorm(1000,5,2)
  output$example_plot1 = renderPlot({
    hist(data_r,freq= FALSE, breaks= bins())
  })
  
}


shinyApp(ui=ui2,server = server2)




# My third example of Shiny Dashboard .....

ui3 = dashboardPage(
  
  # Dashboard Header
  
  dashboardHeader(
    title = "My Shiny DashBoard",
    titleWidth = "300px"
    
  ),
  
  #Dashboard Sidebar
  dashboardSidebar(
    #Add sidebar menu
    sidebarMenu(
      #Add tab items
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
    
    
  ),
  
  #Dashboard main page
  dashboardBody(
    #Add tab items
    tabItems(
    #First tab item
    tabItem(tabName = "dashboard",
    fluidPage(
      titlePanel("This is just a title of fluid page"),
      mainPanel(plotOutput("example_plot1")),
      sidebarPanel(
        numericInput("x", "Bins", value = 1, min = 1, step = 1))
        
      )
    ),
    #Second tab item
    tabItem(tabName = "widgets",h2("Hello World"))
    )
  )
)





server3= function(input,output){
  # Inputs
  bins= reactive(input$x)
  data_r= rnorm(1000,5,2)
  output$example_plot1 = renderPlot({
    hist(data_r,freq= FALSE, breaks= bins())
  })
  
}


shinyApp(ui=ui3,server = server3)




































