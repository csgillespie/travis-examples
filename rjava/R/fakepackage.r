#' An example function
#' @export
#' @examples
#' check_package()
check_package = function() {
  is.function(rJava::clone)
}

