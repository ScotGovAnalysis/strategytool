load_app = function(filepath) {
  nzst_shiny(network = filepath,
             title = "System",
             colours = nzst_colours(base_palette = palette_sg),
             map_type = "System",
             depth_limit = 5, 
             show_logo = FALSE)
}

shinyServer(function( input, output, session) {
  output$map = renderNZST({}) # empty map to serve as a placeholder until the data is selected
  
  # load from a file
  observeEvent(input$network_file, {
    output$map = renderNZST({
      load_app(input$network_file$datapath)
    })
  })
  
  # load the example data
  observeEvent(input$show_example, {
    output$map = renderNZST({
      load_app("www/dummy_system.xlsx")
    })
  })
})
