
print_graph <- function(x, ...) {

  data <- x$data
  data <- data[ sort(names(data)) ]

  lapply(names(data), function(n) {
    cat(" ", tail_style(n), "\n", sep = "")

    funcs <- paste(sort(unique(data[[n]])), collapse = ", ")
    funcs <- strwrap(paste0(arrow(), " ", funcs), indent = 3, exdent = 6)
    funcs <- paste(funcs, collapse = "\n")

    cat(funcs, "\n", sep = "")
  })
}

fill_line <- function(x, chr = "-", width = getOption("width", 80)) {
  len <- width - nchar(x, type = "width") - 4
  if (len <= 0) {
    x
  } else {
    paste0(
      paste0(rep(chr, len), collapse = ""),
      " ", x,
      " --"
    )
  }
}

#' @importFrom crayon green bold

head_style <- function(x) {
  bold(green(fill_line(x, "-")))
}

#' @importFrom crayon green

tail_style <- function(x) {
  green(x)
}

#' @importFrom crayon yellow

arrow <- function(x) {
  yellow("->")
}

#' @method print function_map
#' @export

print.function_map <- function(x, ...) {

  cat(head_style("Function map\n"))

  print_graph(x, ...)

  invisible(x)
}

#' @method print function_map_rfile
#' @export

print.function_map_rfile <- function(x, ...) {

  head <- paste0("FMAP, R script '", x$rfile, "'")
  cat(head_style(head), "\n", sep = "")

  print_graph(x, ...)

  invisible(x)
}

#' @method print function_map_rfolder
#' @export

print.function_map_rfolder <- function(x, ...) {

  head <- paste0("FMAP, R folder '", x$rpath, "'")
  cat(head_style(head), "\n", sep = "")

  print_graph(x, ...)

  invisible(x)
}