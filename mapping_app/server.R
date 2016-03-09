
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

source("create_leaflet.R")
source("helper_functions.R")

library(shiny)

shinyServer(function(input, output) {

        output$mymap <- renderLeaflet({
                
                if (is.null(input$checkGroup)) {
                leaflet() %>% setView(lng = 90, lat = 60, zoom = 3) %>% 
                                addTiles()
                } else {
                create_leaflet(langs = input$checkGroup)
                }

  })

})
