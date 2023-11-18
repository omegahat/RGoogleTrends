getGoogleCookies =
function(cookieJar = findCookiesFile(), con = dbConnect(SQLite(), cookieJar))
{
  sql = sprintf("SELECT * FROM moz_cookies WHERE host = '.google.com' AND expiry > %d", as.integer(Sys.time()))
  rs = dbSendQuery(con, sql)
  gtb = fetch(rs)


  cookieNames = c("SID")  # Don't need "HSID" or "SSID"
  vals = gtb[ gtb$name %in% cookieNames, ]
  if(nrow(vals) == 0)
     stop("No cookie available from Firefox/Mozilla cookie jar ", cookieJar)

   # Could check when it was last accessed (lastAccessed field) to see if was reasonaly
   # recent.
  paste(vals[, "name"], vals[, "value"], sep = "=", collapse = ";")
}


getFirefoxCookies = 
function(cookieJar = findCookiesFile(copy), con = dbConnect(SQLite(), cookieJar), copy = TRUE)
{
  ans = dbReadTable(con, "moz_cookies")
  class(ans$expiry) = c("POSIXt", "POSIXct")
  ans$isSecure = as.logical(ans$isSecure)
  ans$isHttpOnly = as.logical(ans$isHttpOnly)

  ans
}

findCookiesFile =
  # If we set CookieJar, 
  #    options("CookieJar" = "~/Library/Application\ Support/Firefox/Profiles/pkhq2nzy.default/cookies.sqlite")
  # then we don't get the warning about multiple profiles.
function(copy = TRUE)
{
  cookies = getOption("CookieJar", searchForCookiesFile())

     # Make a copy of it if the caller says copy = TRUE or gives us the name of a file.
     # We do this because if firefox is still running, it may have locked the database.
  if((is.logical(copy) && copy) || is.character(copy)) {
     if(is.logical(copy))
       copy = tempfile()
     file.copy(cookies,  copy)
     copy
  } else
     cookies
}


firefoxDir =
function()
{
  sys = Sys.info()["sysname"]
  if(sys == 'Darwin')
      "~/Library/Application Support/Firefox/Profiles"
  else if(sys %in% c("Linux", "Unix"))
      "~/.mozilla/firefox"
  else
      sprintf("c:/Documents\ and\ Settings/%s/Application\ Data/Mozilla/Firefox/Profiles", Sys.info()["login"], sep = "")
}

searchForCookiesFile =
  #
  # This is for Firefox only. 
  #
function(dir = firefoxDir())
{
  
  profiles = list.files(dir, full.names = TRUE)

  allFiles = list.files(profiles, recursive = TRUE, full.names = TRUE)

  cookies = grep("cookies.sqlite$", allFiles, value = TRUE)
  
  if(length(cookies) > 1) {

     info = file.info(cookies)
     cookies = cookies[ which.max( info[, "mtime"] ) ]
    
     # pick the one with the most recent cookies.sqlite file.
    warning("More than one profile found: ", paste(basename(profiles), collapse = ", "), ". Using ", basename(dirname(cookies)))
  }

  cookies
}


if(length(formals(getOption)) == 1)
  getOption = function(name, defaultValue) {
     if(name %in% names(options()))
       base::getOption(name)
     else
       defaultValue
  }
