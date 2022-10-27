
#' Define JS handlers required by shinyBrowserStorage's functions
#'
#' @import shiny
#' @export
#'
withBrowserStorage <- function(){
  return(div(
    tags$script("
      Shiny.addCustomMessageHandler('get_item', function(request) {
        console.log('Reading ' + request['key'] + ' from ' + request['type'] + '..');
        if(request['type'] == 'localStorage'){
          value = localStorage.getItem(request['key']);
        } else if (request['type'] == 'sessionStorage'){
          value = sessionStorage.getItem(request['key']);
        } else {
          console.error('Unknown type of browser storage !');
        }
        Shiny.setInputValue(request['inputId'], value);
      });
    "),

    tags$script("
      Shiny.addCustomMessageHandler('input2storage', function(request) {
        console.log('Saving input ' + request['inputId'] + ' in ' + request['type'] + '..');
        value = document.getElementById(request['inputId'])[request['prop']]
        if(request['type'] == 'localStorage'){
          localStorage.setItem(request['key'], value);
        } else if (request['type'] == 'sessionStorage'){
          sessionStorage.setItem(request['key'], value);
        } else {
          console.error('Unknown type of browser storage !');
        }
      });
    "),

    tags$script("
      Shiny.addCustomMessageHandler('set_item', function(request) {
        console.log('Inserting ' + request['key'] + ' in ' + request['type'] + '..');
        if(request['type'] == 'localStorage'){
          localStorage.setItem(request['key'], request['value']);
        } else if (request['type'] == 'sessionStorage'){
          sessionStorage.setItem(request['key'], request['value']);
        } else {
          console.error('Unknown type of browser storage !');
        }
      });
    "),

    tags$script("
      Shiny.addCustomMessageHandler('remove_item', function(request) {
        console.log('Inserting ' + request['key'] + ' in ' + request['type'] + '..');
        if(request['type'] == 'localStorage'){
          localStorage.removeItem(request['key']);
        } else if (request['type'] == 'sessionStorage'){
          sessionStorage.removeItem(request['key']);
        } else {
          console.error('Unknown type of browser storage !');
        }
      });
    ")
  ))
}

#' Read object from browser's localStorage or sessionStorage
#'
#' @param type Kind of browser storage to use (localStorage ou sessionStorage)
#' @param key Identifier previoulsy used to store the wanted value
#' @param input Shiny input object
#' @param session Shiny session object
#'
#' @return a JSON decoded value (string, numeric, list, ...)
#' @import shiny
#' @export
#'
read.storage <- function(type, key, input, session){
  # Control type
  session$sendCustomMessage("get_item", list(
    type=type, inputId=NS(type)(key), key=key
  ))
  return(input[[NS(type)(key)]])
}

#' Write an object into browser's storage
#'
#' @param type Kind of browser storage to use (localStorage ou sessionStorage)
#' @param key Identifier to store value
#' @param value The value to be inserted in storage (need to be JSON encodable)
#' @param session Shiny session object
#'
#' @import shiny
#' @export
#'
write.storage <- function(type, key, value, session){
  # Control type
  session$sendCustomMessage("set_item", list(
    type=type, key=key, value=value
  ))
}

#' Remove value from browser's localStorage or sessionStorage
#'
#' @param type Kind of browser storage to use (localStorage ou sessionStorage)
#' @param key Identifier previously used to store the wanted value
#' @param session Shiny session object
#'
#' @import shiny
#' @export
#'
remove.storage <- function(type, key, session){
  # Control type
  session$sendCustomMessage("remove_item", list(
    type=type, key=key
  ))
}

#' Save an input's property into browser's storage
#'
#' @description
#' Save an input's property directly in JavaScript into browser's storage
#' without reading the input from R.
#'
#' @param type Kind of browser storage to use (localStorage ou sessionStorage)
#' @param key Identifier to store value
#' @param inputId The input's id
#' @param prop The input's prop to save
#' @param session Shiny session object
#'
#' @export
#'
input2storage <- function(type, key, inputId, prop, session){
  session$sendCustomMessage("input2storage", list(
    type=type, inputId=inputId, key=key, prop=prop))
}
