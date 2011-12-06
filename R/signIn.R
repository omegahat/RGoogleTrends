
getGALX = 
  # This gets the GALX cookie which we need to pass back in the login form we post.
function(curl)
{
  txt = basicTextGatherer()
  curlPerform(url = "https://www.google.com/accounts/Login?hl=en&continue=http://www.google.com/", 
              curl = curl, writefunction = txt$update, header = TRUE)

  tmp = txt$value()
  val = grep("Cookie: GALX", strsplit(tmp, "\n")[[1]], val = TRUE)
  (strsplit(val, "[:=;]")[[1]])[3]
}

googleSignIn =
function(login = getOption("GooglePassword"), password, service = "trends",
         curl = getCurlHandle(cookiefile = "", followlocation = TRUE, ...),
         userAgent = getOption('HTTPUserAgent', "R"),
         GALX = getGALX(curl), ...) 
{
   if(missing(password) && length(names(login)) > 0) {
       password = login
       login = names(login)
   }
       
   ans = postForm("https://www.google.com/accounts/LoginAuth?hl=en&continue=http://www.google.com/", 
                 Email = login,
                 Passwd = password,
                 GALX = GALX,
                 nui = "1", hl = 'en',
                 continue = "http://www.google.com/",
                 PersistentCookie = "yes", rmShown = "1", asts="",
                 service = service, curl = curl,
                 .opts = list(header = TRUE,
                              httpheader = c('User-Agent' = userAgent)))

   curl
}
