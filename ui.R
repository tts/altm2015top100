sidebar <- dashboardSidebar(disable = T)


body <- dashboardBody(
  
  fluidRow(
    column(
      width = 6,
      box(
        height = "1250px",
        width = NULL,
        title = "Average metrics by country",
        status = "success",
        d3heatmapOutput("country", height = "1200px")
      )
    ),
    column(
      width = 6,
      box(
        title = "About",
        width = NULL,
        status = "info",
        tags$div(class="header", checked=NA,
                 tags$a(href="https://figshare.com/s/38e6a778945e11e5aafe06ec4bbcf141", "Data on Figshare by Altmetric (License CC-BY)")
        ),
        tags$div(class="header", checked=NA,
                 tags$p("To select, click row and/or column label. Draw a rectangle to zoom. To reset, click map.", 
                        a(href="https://github.com/rstudio/d3heatmap/issues/43", "Note tooltip issue in FF while zooming")
                 )
        ),
        tags$div(class="header", checked=NA,
                 tags$a(href="https://gist.github.com/tts/c6f8cb8a66f1bb9a21f0", "R source code"))
      ),
      box(
        title = "Average metrics by category",
        width = NULL,
        status = "warning",
        d3heatmapOutput("category")
      ),
      box(
        width = NULL,
        selectInput(inputId = "c",
                    label = "Select country for the map below",
                    choices = countries,
                    selected = "Finland")
      ),
      box(
        width = NULL,
        heigth = "600px",
        status = "primary",
        d3heatmapOutput("selcountry", height = "550px")
      )
    )
  )
)


dashboardPage(
  dashboardHeader(title = "Altmetric Top 100 articles 2015",
                  titleWidth = "500"),
  sidebar,
  body,
  skin = "black"
)

