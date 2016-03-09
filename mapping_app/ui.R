
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plyr)
library(dplyr)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  titlePanel("Language maps stored in GitHub"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
            checkboxGroupInput("checkGroup", label = h3("Language:"), 
                               choices = readr::read_csv("basic_info.csv") %>% .$lang)),

    # Show a plot of the generated distribution
    mainPanel(
            leafletOutput("mymap")
    )
  )
))
