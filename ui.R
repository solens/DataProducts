library(shiny)
library(ggplot2)
shinyUI(pageWithSidebar(
  headerPanel("Enter the number of carat and the quality of the cut to estimate the price of a diamond."),
  sidebarPanel(
    sliderInput(inputId="carat", label = "Number of carats",min=0.5,max=6,step=0.1,value=3),
    selectInput(inputId="cut",label = "Quality of the Cut", choices=c("Fair"=1,"Good"=2,"Very Good"=3,"Premium"=4,"Ideal"=5))
  ),
  
  mainPanel(
    textOutput('desc'),
    textOutput('price')
  )
))
