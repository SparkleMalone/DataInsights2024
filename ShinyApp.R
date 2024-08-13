# Start Generation Here

library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Normal Distribution Mean Estimation"),
  sidebarLayout(
    sidebarPanel(
      numericInput("mean", "Mean:", value = 30),
      numericInput("variance", "Variance:", value = 100),
      numericInput("dbh_error", "DBH Error:", value = 5),
      numericInput("biltmore_error", "Biltmore Error:", value = 10),
      numericInput("dbh_rate", "DBH Rate:", value = 1),
      numericInput("biltmore_rate", "Biltmore Rate:", value = 2),
      numericInput("max_time", "Max Time (minutes):", value = 200),
      actionButton("generate", "Generate Data")
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  data <- eventReactive(input$generate, {
    rnorm(10000, mean = input$mean, sd = sqrt(input$variance))
  })
  
  output$distPlot <- renderPlot({
    req(data())
    dbh_data <- data() + rnorm(length(data()), mean = 0, sd = input$dbh_error)
    biltmore_data <- data() + rnorm(length(data()), mean = 0, sd = input$biltmore_error)
    
    max_time <- input$max_time
    max_samples_dbh <- min(max_time, length(dbh_data))
    max_samples_biltmore <- min(max_time * input$biltmore_rate, length(biltmore_data))
    
    dbh_data <- dbh_data[1:max_samples_dbh]
    biltmore_data <- biltmore_data[1:max_samples_biltmore]
    
    dbh_se <- sapply(1:length(dbh_data), function(n) sd(dbh_data[1:n]) / sqrt(n))
    biltmore_se <- sapply(1:length(biltmore_data), function(n) sd(biltmore_data[1:n]) / sqrt(n))
    
    time_dbh <- 1:length(dbh_data)
    time_biltmore <- seq(1 / input$biltmore_rate, length(biltmore_data) / input$biltmore_rate, by = 1 / input$biltmore_rate)
    
    se_data <- data.frame(
      Time = c(time_dbh, time_biltmore),
      SE = c(dbh_se, biltmore_se),
      Method = rep(c("DBH", "Biltmore"), c(length(dbh_se), length(biltmore_se)))
    )
    
    se_data_filtered <- se_data %>% filter(Time >= 20)
    
    ggplot(se_data_filtered, aes(x = Time, y = SE, color = Method)) +
      geom_line() +
      labs(title = "Standard Error vs. Time",
           x = "Time (minutes)",
           y = "Standard Error") +
      scale_color_manual(values = c("DBH" = "blue", "Biltmore" = "red")) +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)

# End Generation Here