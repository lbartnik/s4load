#' @export
setClass("S4base", contains = "VIRTUAL")

#' @export
setMethod("initialize", "S4base", function (.Object) callNextMethod())



#' @export
setClass("S4class", representation(x = "character"), prototype(x = ""), contains = "S4base")

#' @export
setMethod("initialize", "S4class", function (.Object) {
  .Object@x <- "some text"
  .Object
})




onLoadEnv <- new.env()

.onLoad <- function (libname, pkgname)
{
  onLoadEnv$object <- new("S4class")
}



#' @export
verifyS4Initialization <- function ()
{
  object <- new("S4class")

  cat(".onLoad(): ", onLoadEnv$object@x, '\n')
  cat("regular:   ", object@x, '\n')

  if (!identical(object@x, onLoadEnv$object@x)) {
    stop("slots are not the same", call. = FALSE)
  }
}

