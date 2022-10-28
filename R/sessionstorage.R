# R6 class
library(R6)


#' Binding of JS localStorage
#'
#' @export
SessionStorage <- R6Class(
  "SessionStorage",
  private = list(
    input = NULL,
    session = NULL
  ),
  public = list(
    initialize = function(input, session) {
      private$input = input
      private$session = session
    },

    setItem = function(key, value) {
      write.storage('sessionStorage', key, value, private$session)
    },

    getItem = function(key) {
      read.storage('sessionStorage', key, private$input, private$session)
    },

    removeItem = function(key){
      remove.storage('sessionStorage', key, private$session)
    }
  )
)
