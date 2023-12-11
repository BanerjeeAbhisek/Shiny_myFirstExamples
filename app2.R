source(here::here('packages.R'))

dist_cepii = read.xlsx("dist_cepii.xlsx")
geo_cepii = read.xlsx("geo_cepii.xlsx")

code= unique(geo_cepii$iso3) 
country = unique(geo_cepii$country)
x1=country[match(dist_cepii$iso_o,code)] 
x2=country[match(dist_cepii$iso_d,code)] 

df = data.frame(country1=x1 ,country1_code=dist_cepii$iso_o,country2=x2 ,country2_code=dist_cepii$iso_d,distance= dist_cepii$dist)

ui = fluidPage(
  
  #Title
  titlePanel("Distances of Different Countries"),
  #Slidebar Layout
  sidebarLayout(sidebarPanel(
    
    #On the left
    selectInput("country1","Select a country",choices = country, selected = country[1]),
    selectInput("country2","Select another country",choices = country, selected = country[1])),
    
    #On center middle
    mainPanel(
      plotOutput("plt")
    ))
  
)





server = function(input, output) {
  
  output$plt <- renderPlot({
    
    # Download world map data
    world_coordinates <- map_data("world")
    
    
    # Define countries to color differently
    highlight_countries <- c(input$country1, input$country2)
    
    distance_value= df[df$country1==highlight_countries[1] & df$country2==highlight_countries[2],5]
    
    
    ggplot() + 
      
      # geom_map() function takes world coordinates as input  
      # to plot the world map. Color parameter determines the  
      # color of borders in the map, fill parameter determines  
      # the color of fill in the map, and size determines the thickness 
      # of the border in the map.
      geom_map( 
        data = world_coordinates, map = world_coordinates, 
        aes(long, lat, map_id = region, fill = ifelse(region %in% highlight_countries, "yellow", "darkgreen")), 
        color = "white", size = 0.2 
      ) +
      
      # Customize legend labels and colors
      scale_fill_manual(values = c("yellow" = "yellow", "darkgreen" = "darkgreen"), guide_legend(title = "Highlighted Countries :")) +
      
      # Add text to the plot
      annotate("text", x = 250, y = 102, hjust = 1, vjust = 0,
               label = paste("Distance is",distance_value),   #, distance_value()),
               color = "black", size = 5) +
      
      # Adjust legend position to the bottom
      theme(legend.position = "bottom") +
      
      # Add title
      labs(title = "World Map with Highlighted Countries")
    
  })
}


shinyApp(ui=ui, server=server)
























