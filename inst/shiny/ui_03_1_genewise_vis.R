shinyPanelVis <- fluidPage(
  tags$div(
    class = "container",
    h1("Gene Visualization"),
    h5(tags$a(href = "https://compbiomed.github.io/sctk_docs/articles/v05-tab03_Dimensionality-Reduction-and-Clustering.html",
              "(help)", target = "_blank")),
    sidebarLayout(
      sidebarPanel(
        h4("Options:"),
        selectInput("visAssaySelect", "Select Assay:", currassays),
        selectInput("visPlotMethod", "Visualization Method:", c("boxplot", "scatterplot", "barplot", "heatmap")),
        selectInput("visCondn", "Condition:", c("none", clusterChoice)),
        h3("Choose data source:"),
        radioButtons(
          "visGeneList", label = NULL, c("Select Gene(s)" = "selVisRadioGenes",
                                         "Saved top genes" = "visBiomarker")
          ),
        conditionalPanel(
          condition = sprintf("input['%s'] == 'selVisRadioGenes'", "visGeneList"),
          selectizeInput("selectvisGenes", label = "Select Gene(s):", NULL, multiple = TRUE)
          ),
        conditionalPanel(
          helpText("To use this, first run Differential expression and save top genes."),
          condition = sprintf("input['%s'] == 'visBiomarker'", "visGeneList"),
          uiOutput("visBioGenes")
          ),
        uiOutput("visOptions"),
        withBusyIndicatorUI(actionButton("plotvis", "Plot"))
        ),
      mainPanel(
        fluidRow(
          plotOutput("visPlot", height = '600px')
          )
        )
      )
    )
  )
