# R6 class
library(R6)


#' Binding of JS localStorage
#'
#' @export
AbstractStorage <- R6Class(
  "AbstractStorage",
  private = list(
    input = NULL,
    session = NULL,
    name = NULL
  ),
  public = list(
    initialize = function(input, session) {
      private$input = input
      private$session = session
    },

    setItem = function(key, value) {
      write.storage(private$name, key, value, private$session)
    },

    getItem = function(key, ns=NULL) {
      read.storage(private$name, key,
                   private$input, private$session, ns=ns)
    },

    removeItem = function(key){
      remove.storage(private$name, key, private$session)
    }
  )
)


#' Binding of JS localStorage
#'
#' @export
LocalStorage <- R6Class(
  "LocalStorage",
  inherit = AbstractStorage,
  private = list(
    name = 'localStorage'
  ),
  public = list()
)

#' Binding of JS sessionStorage
#'
#' @export
SessionStorage <- R6Class(
  "SessionStorage",
  inherit = AbstractStorage,
  private = list(
    name = 'sessionStorage'
  ),
  public = list()
)

