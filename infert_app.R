#IMPORTAR BIBLIOTECAS NECESSáRIAS
library(shiny)
library(neuralnet)

#CARREGAR MODELO DA REDE NEURAL
modelo = readRDS('model.rds')

#FRONT END - USUáRIO

ui <- pageWithSidebar(
  
  # Cabeçalho da página
  headerPanel('NN infert'),
  
  # Valores de entrada
  sidebarPanel(
    
    tags$label(h3('Entre com os dados a seguir')),
    
    numericInput(inputId = 'idade', label = 'Qual a idade da paciente?',
                value = 0, min = 10, max = 60, step = 1, width = NULL),
    
    numericInput(inputId = 'paridade', label = 'A paciente tem quantos filhos?',
                 value = 0, min = 1, max = 6, step = 1, width = NULL),
    
    numericInput(inputId = 'induzido', label = 'A paciente teve quantos abortos induzidos?',
                 value = 0, min = 0, max = 2, step = 1, width = NULL),
    
    numericInput(inputId = 'espontaneo', label = 'A paciente teve quantos abortos espontaneos?',
                 value = 0, min = 0, max = 2, step = 1, width = NULL),
    
    actionButton(inputId = "botao", label = "Calcule", 
                 class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Texto do codigo Status/Output, desnecessario isso aqui...
    verbatimTextOutput('contents'),
    h3('Probabilidade da paciente ser infertil'),
    tableOutput('tabledata'),#, # Resultado da previsão
    
    h3('Imagem da rede neural'),
    imageOutput("nnplot")
    
  )
)

#SERVIDOR

server <- function(input, output, session) {
  
  # Entrada dos dados
  datasetInput <- reactive({  
    
    df <- data.frame(
      Name = c("Idade",
               "Filhos",
               "Abortos induzidos",
               "Abortos espontaneos"),
      Value = as.character(c(input$idade,
                             input$paridade,
                             input$induzido,
                             input$espontaneo)),
      stringsAsFactors = FALSE)
    
    entrada <- t(df)
    write.table(entrada,"entrada.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    novos_dados <- read.csv(paste("entrada", ".csv", sep=""), header = TRUE)
    saida <- data.frame(Prediction=predict(modelo,novos_dados))
    print(saida)
    
  })
  
  # Caixa de texto do status do app
  output$contents <- renderPrint({
    if (input$botao>0) { 
      isolate("Resultado") 
    } else {
      return("Esperando entrada de dados.")
    }
  })
  
  # Resultados da tabela previsao
  output$tabledata <- renderTable({
    if (input$botao>0) { 
      isolate(datasetInput()) 
    } 
  })
  
  # Imagem da rede neural
  output$nnplot <- renderImage({
    
# Quando input$n é 3, o nome do arquivo  é ./images/image3.png
    filename <- normalizePath(file.path('./images',
                                        paste('nnplot', input$n, '.png', sep='')))
    
    # Retorna a lista contendo o nome do arquivo e o texto alt
    list(src = filename,
         alt = paste("Image number", input$n))
    
  }, deleteFile = FALSE)

}

#CRIA O APP SHINY COMPLETO
shinyApp(ui = ui, server = server)
