load_app = function(filepath) {
  nodes = readxl::read_excel(filepath, sheet = "Actions") %>% 
    dplyr::transmute(data_version = Version,
                     data_name = "Strategy",
                     System = "Strategy", 
                     Variable.ID = ID,
                     Section.on.Systems.Map = Source,
                     Variable.Name = Action,
                     Description = Description,
                     Source.organisation = Source %>% paste(Clause %>% as.character() %>% tidyr::replace_na(""), sep = " "),
                     Tags = Source,
                     x = x, y = y)
  
  edges = readxl::read_excel(filepath, sheet = "Impacts") %>% 
    dplyr::transmute(data_name = nodes$data_name[1],
                     Variable.ID.A = Action_ID,
                     Variable.ID.B = Impact_ID,
                     Relationship = Relationship,
                     Relationship.Strength = Relationship_strength)
  
  nzst_shiny(network = list(nodes = nodes, edges = edges),
             title = "Strategy",
             colours = nzst_colours(base_palette = palette_sg_dark),
             map_type = "Strategy",
             map_type_plural = "Strategies",
             depth_limit = 5, 
             show_logo = FALSE)
}

shinyServer(function( input, output, session) {
  output$map = renderNZST({}) # empty map to serve as a placeholder until the data is selected
  
  observeEvent(input$network_file, {
    output$map = renderNZST({
      load_app(input$network_file$datapath)
    })
  })
  
  observeEvent(input$show_example, {
    output$map = renderNZST({
      load_app("www/dummy_strategy.xlsx")
    })
  })
})
