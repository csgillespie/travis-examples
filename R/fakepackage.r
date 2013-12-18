#' An example function
#' @export
#' @examples
#' get_node()
get_node = function() {
  XML::newXMLNode("bob", namespace = c(r = "http://www.r-project.org"))
}

