
library(shiny)
library(dplyr)
library(leaflet)
library(readr)
library(ggplot2)



shinyServer(function(input,output){
  
  altmed = read.csv("store.csv")
  
  starRate = filter(altmed,StarRating!="NA")
  fbrate = filter(altmed,FBRating!="NA")
  altmed$Latitude <- as.numeric(altmed$Latitude)
  altmed$Longitude <- as.numeric(altmed$Longitude)
  
  #popup
  semua = mutate(semua, cntnt=paste0('<strong>Name: </strong>',StoreName,
                                     '<br><strong>Contact: </strong>',ContactNumber,
                                     '<br><strong>Star Rating: </strong>',StarRating,
                                     '<br><strong>FB Rating: </strong>',FBRating))
  
  #Output for recommended place
  
  output$recmap <- renderLeaflet({
    
    leaflet(semua %>%
              dplyr::filter(
                State == input$States,
                AlternativeMedicine == input$AltMedicine
              ))%>%
      addTiles()%>%
      addCircleMarkers(lat = ~Latitude, lng = ~Longitude,
                       radius = 4, popup = ~as.character(cntnt),
                       color = ~pal(AlternativeMedicine),
                       stroke = FALSE, fillOpacity = 0.8)%>%
      addLegend(pal = pal, values = semua$AlternativeMedicine,opacity = 1)
  })
  
  
  #create colour pallete
  pal <- colorFactor(pal = c("#9c2424", "#f2f213", "#20b020", "#2036b0","#e68ecb"), domain = c("Acupuncture", "Chiropractic Medicine", "Energy Therapies","Herbal Medicine","Ayurvedic Medicine"))
  
  #Output for map
  output$map <- renderLeaflet({
    
    leaflet(semua) %>%
    addTiles() %>%
    addCircleMarkers(data = semua, lat = ~Latitude, lng = ~Longitude,
                     radius = 4, popup = ~as.character(cntnt),
                     color = ~pal(AlternativeMedicine),
                     stroke = FALSE, fillOpacity = 0.8)%>%
      addLegend(pal = pal, values = semua$AlternativeMedicine,opacity = 1)
})
  
  #output for benefits
  output$benAcu = renderText({
    paste("A system of complementary medicine where five needles are inserted in the skin
  at a specific point along what are considered to be lines of energy (meridians),
  used in the treatment of various physical and mental conditions.")
  })
  output$benChi = renderText({
    paste("It is based on the link between the alignment of the spine and the function of the body.")
  })
  output$benET = renderText({
    paste("It is a form of complementary and alternative medicine based on medicine based on the belief that vital energy flows through the human body.")
  })
  output$benET1 = renderText({
    paste("Although there is no scientific evidence that energy therapies have any benefits, 
  they are used to help people feel relaxed and less anxious, and to improve 
  overall wellbeing.")
  })
  output$benHM = renderText({
    paste("It is remedies and medicines made from plants.")
  })
  output$benAM = renderText({
    paste("It is a medical system from India that its goal is to cleanse the body and restore
  balance to the body, mind, and spirits.")
  })
  
  #output for review
  output$StarRating <- renderPlot({
    ggplot(data = starRate, aes( x=StarRating))+
      geom_bar(color = "pink")
    
  })
  output$FBRating <- renderPlot({
    ggplot(data = fbrate, aes( x=FBRating))+
      geom_bar(color = "pink")
    
  })
  
})