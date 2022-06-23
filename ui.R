library(shiny)
library(leaflet)
library(shinythemes)

states_16 = c("Johor","Kedah","Kelantan","Malacca","Negeri Sembilan","Pahang","Penang","Perak","Perlis","Sabah","Sarawak","Selangor","Terengganu","WP Kuala Lumpur","WP Labuan","WP Putrajaya")
alt_med = c("Acupuncture","Chiropractic Medicine","Energy Therapies","Herbal Medicine","Ayurvedic Medicine")

shinyUI = fluidPage(
       
      titlePanel("Alternative Medicine Finder"),
               
      sidebarLayout(
        sidebarPanel(
          helpText(h4("Get Treated Now!")),
                   
          selectInput("States", label = "Select State:", states_16,"States"),
          selectInput("AltMedicine", label = "Choose Alternative Medicine:",alt_med,"AltMedicine"),
          submitButton("Go")
        ),
      mainPanel(
        navbarPage(h4("Alternative Medicine"),id="main",
                   tabPanel(h4("Map"),h3("Alternative Medicine in Malaysia"),leafletOutput("map")),
                   tabPanel(h4("Filter"),h3("Filtered Place"),leafletOutput("recmap")),
                   tabPanel(h4("Benefits"),h3("Benefits of Each Alternative Medicine"),
                            h3("Acupuncture"),textOutput("benAcu"),img(src = "BenefitsAcupuncture.png", height = 300, width = 450),
                            h3("Chiropractic Medicine"),textOutput("benChi"),img(src = "BenefitsChi.png", height = 300, width = 450),
                            h3("Energy Therapies"),textOutput("benET"),textOutput("benET1"),
                            h3("Herbal Medicine"),textOutput("benHM"),img(src = "BenefitsHM.png", height = 300, width = 450),
                            h3("Ayurvedic Medicine"),textOutput("benAM"),img(src = "BenefitsAyur.png", height = 300, width = 450)),
                   tabPanel(h4("Review"),h3("Star Rating"), plotOutput("StarRating"), h2("Facebook Rating"),plotOutput("FBRating"))                   
                 
  ),
 )
)
)