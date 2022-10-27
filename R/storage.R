
#' Title
#'
#' @return
#' @export
#'
#' @examples
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
    "),

    tags$script("
      Shiny.addCustomMessageHandler('remove_item', function(request) {
        console.log('Inserting input ' + request['inputId'] + ' in ' + request['type'] + '..');
        value = document.getElementById(request['inputId']).value
        if(request['type'] == 'localStorage'){
          localStorage.setItem(request['key'], value);
        } else if (request['type'] == 'sessionStorage'){
          sessionStorage.setItem(request['key'], value);
        } else {
          console.error('Unknown type of browser storage !');
        }
      });
    ")
  ))
}

#' Title
#'
#' @param type
#' @param key
#' @param input
#'
#' @return
#' @export
#'
#' @examples
read.storage <- function(type, key, input, session){
  # Control type
  session$sendCustomMessage("get_item", list(
    type=type, inputId=NS(type)(key), key=key
  ))
  return(input[[NS(type)(key)]])
}

#' Title
#'
#' @param type
#' @param key
#' @param value
#'
#' @return
#' @export
#'
#' @examples
write.storage <- function(type, key, value, session){
  # Control type
  session$sendCustomMessage("set_item", list(
    type=type, key=key, value=value
  ))
}

#' Title
#'
#' @param type
#' @param key
#' @param input
#'
#' @return
#' @export
#'
#' @examples
remove.storage <- function(type, key, session){
  # Control type
  session$sendCustomMessage("remove_item", list(
    type=type, key=key
  ))
}


input2storage <- function(type, inputId, session, key=inputId){

}
