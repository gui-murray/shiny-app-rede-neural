# shiny-app-rede-neural
Repositório para mostrar aplicativo criado usando a biblioteca Shiny (R e RStudio). O aplicativo carrega uma rede neural treinada para prever a % de pacientes serem inférteis, baseado em um banco de dados gratuito.

O link para acesso ao app publicado online é: https://vizia.shinyapps.io/nn-infert/

Os arquivos base para rodar o app são 4:
  - arquivo .R com o código para criar interface do usuário e o servidor Shiny;
  - arquivo .CSV com informações de input inicial de dados para o app;
  - arquivo .PNG com a imagem da rede neural treinada (baixa acurácia, apenas para mostrar o aplicativo e previsão usando modelo de IA já treinado e salvo anteriormente);
  - arquivo .RDS com informações da rede neural treinada anteriormente.

Arquivos auxiliares neste repositório:
  - arquivo .CSV com a base de dados original, usada para treinar a rede neural e fazer previsões;
  - arquivo .R com código para publicar o aplicativo (fase de testes) em uma porta do localhost, antes do final deployment.

NOTA: para publicar o app online é preciso criar uma conta e conectar o R/RStudio ao ShinyApps.io (https://docs.rstudio.com/shinyapps.io/getting-started.html#CreateAccount). Também, é possível rodar o app localmente no RStudio (pelo comando shinyApp(), da biblioteca shiny). Esta etapa é, inclusive, recomendada para testes antes de realizar o deployment final do app.

