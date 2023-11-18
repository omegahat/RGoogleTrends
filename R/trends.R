getGTrends = 
#
# We should change this to use get
#
function(term, login = getOption("GooglePassword"), cookie = getGoogleCookies (), 
          relativeScale = TRUE, curl = getCurlHandle(cookie = cookie),
         url = "http://www.google.com/trends/explore", ...)
{

  if(missing(curl)) {
    if(!is.null(login))
       curl = googleSignIn(login)
    else if(length(cookie) > 1)
       cookie = paste(names(cookie), cookie, sep = "=", collapse = ";")
  }
  
  txt = getForm(url,
                  q = term, graph = "all_csv",
                 scale = as.integer(relativeScale), sa= "N",
                 curl = curl, .opts = list(verbose = FALSE, ...))  # binary = TRUE)

  readMultiCSV(txt)
}

