#' An example function
#' @export
#' @examples
#' get_node()
get_node = function() {
    ##Example from tkchooseDirectory
    tt <- tktoplevel()
    tkpack(l1 <- tklabel(tt, text = "Heave"), l2 <- tklabel(tt, text = "Ho"))
    tkpack.configure(l1, side = "left")
    
    ## Try stretching the window and then
    
    tkdestroy(tt)

}

