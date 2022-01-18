library(shiny)

port <- Sys.getenv('PORT')

shiny::runApp(
  appDir = getwd(
#seu diretório de trabalho aqui"
),
  host = '0.0.0.0',
  port = as.numeric(port)
)

#documentação completa da função: https://shiny.rstudio.com/reference/shiny/1.6.0/runApp.html
