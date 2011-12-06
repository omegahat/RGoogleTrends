txt = basicTextGatherer()
curl = getCurlHandle(writefunction = txt$update, cookiefile = "", verbose = TRUE, cookiejar = "myCookies.txt", followlocation = TRUE)

curlPerform(url = "http://www.google.com", header = TRUE, curl = curl)

txt = basicTextGatherer()
curlPerform(url = "https://www.google.com/accounts/Login?hl=en&continue=http://www.google.com/", curl = curl, writefunction = txt$update)

tmp = txt$value()
val = grep("Cookie: GALX", strsplit(tmp, "\n")[[1]], val = TRUE)
GALX = (strsplit(val, "[:=;]")[[1]])[3]

txt$reset()
googleSignIn( GALX = GALX, curl = curl)

z = getGTrends("climate change", curl = curl)



