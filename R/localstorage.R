# R6 class

library(R6)

#' Binding of JS localStorage
#'
#' @export
LocalStorage <- R6Class(
  "LocalStorage",
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
      write.storage('localStorage', key, value, private$session)
    },

    getItem = function(key) {
      read.storage('localStorage', key, private$input, private$session)
    },

    removeItem = function(key){
      remove.storage('localStorage', key, private$session)
    }
  )
)
