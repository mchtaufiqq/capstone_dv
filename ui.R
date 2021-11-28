library(shiny)
library(shinydashboard)

    header <- dashboardHeader(
      title = "ISPU JKT MEI 2021"
    )
    
    sidebar <- dashboardSidebar(
      sidebarMenu(
        menuItem(
          text = "Introduction",
          tabName = "intro",
          icon = icon("info")
        ),
        menuItem(
          text = "Indeks Standar Pencemar Udara",
          tabName = "ispu",
          icon = icon("radiation-alt")
        ),
        menuItem(
          text = "Data",
          tabName = "data",
          icon = icon("book")
        )
      )
    )
    
    body <- dashboardBody(
      tabItems(
        
        # TAB 1
        tabItem(
          tabName = "intro",
          fluidPage(
            h2(tags$b("Indeks Standar Pencemar Udara")),
            br(),
            div(style = "text-align:justify",
                p("Indeks Standar Pencemar Udara (ISPU) menurut Kementerian Lingkungan Hidup dan Kehutanan 
                  Republik Indonesia adalah angka yang tidak mempunyai satuan yang menggambarkan kondisi kualitas 
                  udara ambien di lokasi dan waktu tertentu yang didasarkan kepada dampak terhadap kesehatan
                  manusia, nilai estetika dan makhluk hidup lainnya.",
                  "Data Indeks Standar Pencemar Udara diperoleh dari pengoperasian Stasiun Pemantauan 
                  Kualitas Udara Ambien Otomatis. Sedangkan Parameter Indeks Standar Pencemar Udara 
                  meliputi: Partikel Materi (PM10 dan PM 2.5), Karbondioksida (CO), Sulfur dioksida (SO2), Nitrogen dioksida (NO2)."),
                br()
                )
            )
            ), 
        #TAB 2
        tabItem(
          tabName = "ispu",
          fluidRow(
            valueBox(value = ispu$stasiun %>% 
                       unique() %>% 
                       length(),
                     subtitle = "Jumlah Stasiun per Wilayah",
                     width = 4,
                     color = "orange",
                     icon = icon("map-marker-alt")),
            valueBox(value = ispu_case1$Parameter_Polutan %>% 
                       unique() %>% 
                       length(),
                     width = 4,
                     subtitle = "Jumlah Parameter Polutan",
                     color = "lime",
                     icon = icon("atom")),
            valueBox(value = ispu$categori %>% 
                       unique() %>% 
                       length(),
                     width = 4,
                     subtitle = "Total Kategori Indeks Standar Pencemar Udara",
                     color = "yellow",
                     icon = icon("seedling"))),
          fluidPage(  #PLOT 1
            box(
              width = 7,
              plotlyOutput("plot1"),
              title = "Rata-rata Parameter Polutan per Stasiun DKI Jakarta",
              solidHeader = T),
            box(
              width = 5,
              height = 460,
              background = "lime",
              selectInput(inputId = "stasiun_id",
                          label = "Wilayah Stasiun",
                          choices = unique(ispu$stasiun))
        )
      ),
      fluidPage(  #PLOT 2
        box(
          width = 8,
          plotlyOutput("plot2"),
          title = "Total Kategori Indeks Standar Pencemar Udara",
          solidHeader = T),
        box(
          width = 4,
          height = 460,
          background = "lime",
          radioButtons(inputId = "stasiun_id_new",
                      label = "Wilayah Stasiun",
                      choices = unique(ispu$stasiun))
  )
      )
    ),
  tabItem(
    tabName = "data",
    fluidRow(
      box(width = 12,
          DT::dataTableOutput("data_ispu"))
    )
  )
  )
)
    
dashboardPage(
  header = header,
  body = body,
  sidebar = sidebar,
  skin = "green"
)