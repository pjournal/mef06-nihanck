library(shiny)
library(dplyr)
library(readxl)
library(tidyverse)


students <- read_excel("www/students.xlsx")
cities<-unlist(students$city)
nationalities<-unlist(students$nationality)
universities<-unlist(students$university)
types<-unlist(students$type)



# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Analysis of Foreign Students"),

    # Sidebar
    sidebarLayout(
        sidebarPanel(
          checkboxGroupInput("type", "Select the type of the University:", choices = list("DEVLET","VAKIF"),selected = "DEVLET"),
          selectInput("city", "City:",  choices = cities, selected = "ADANA",multiple=TRUE),  
          selectInput("university", "University:",  choices = universities, selected = "ADANA ALPARSLAN TÜRKEŞ BİLİM VE TEKNOLOJİ ÜNİVERSİTESİ",multiple=TRUE),  
        ),
  

        # Show a table
        mainPanel(tableOutput("table")),
) 
)

# Define server
server <- function(input, output) {

    output$table <- renderTable({
      students%>%filter(students$type==input$type,students$city==input$city,students$university==input$university)

    })
}

# Run the application 
shinyApp(ui = ui, server = server)
