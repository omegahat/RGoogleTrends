\name{getGTrends}
\alias{getGTrends}
\title{Get Google Trends Data for a query}
\description{
  This function fetches the Google Trends data for a particular topic.
  This data provides information about the number of times this query
  has been queried within the Google Search Engine.
  We have the index of times the query has been submitted
  overall, over time (by week), by country, by city and by language.

  This function needs access to a Google account to make the query.
  You can specify the account and password via the \code{login}
  parameter. Alternatively, you can specify the 
  SID (session id) cookie for google.com by looking for it in your browser's
  collection of cookies, assuming you have an active session, i.e. signed/logged  into your
  Google account via your browser.
  If you are using Firefox as your browser, R can read the cookies
  directly from your browser.

}
\usage{
getGTrends(term, login, cookie = getGoogleCookies(), relativeScale = TRUE, curl = getCurlHandle(cookie = cookie))
}
\arguments{
  \item{term}{the topic or query term to query within Google Trends}
  \item{login}{a named character vector with one element giving the login and password for the Google account, i.e.
     \code{c(login = "password")}. }
  \item{cookie}{a string providing the cookies to use in the request.
    All we need is the cookie named SID (session id). These come from Google when you
    sign in.  We can retrieve them from Firefox's cookie list.
    Alternatively, you can specify them by hand as a character vector or
    a string in the form "SID=value".  In the future, you should be able to
    sign in to Google from within R and then we will reuse the same curl
    handle which will have the cookies returned by Google during the sign-in request.}
  \item{relativeScale}{a logical value indicating whether we want the  scaled or fixed counts.}
  \item{curl}{a curl handle used in making the HTTP request. This can
    allow you to reuse existing connections and also to set curl
    parameters.
    If you specify this directly, you need not specify the cookies.}
}
\details{
  The current version of this function reads the cookie information
  with which we communicate with Google from the browser.
  You must "Sign In" to Google using your browser.
  We then read the relevant cookies from the browser and use these.
  The names of the relevant cookie is SID (session id).
  At this point, we can only read from the  Firefox browser. 

}
\value{
  A list of 5 data  frames.
  These provide information about the counts for the overall total,
  week, regions, cities and languages. 
}
\references{
  \url{http://www.google.com/trends}
  
  This was motivated by Hal Varian's blog posting
  \url{http://googleresearch.blogspot.com/2009/04/predicting-present-with-google-trends.html}.

  This is a nice example of how we get the cookies from our web browser,
  signing into Google using the browser (not R) and then logging.
}
\author{
Duncan Temple Lang
}


%\seealso{}

\examples{
\dontrun{
      # If you have logged in to your Google account via your Firefox browser
      # or set options(GooglePassword = c(login = password))
   ans = getGTrends("coupon")

   ans = getGTrends("coupon", c(mylogin = "password"))

    # Picks up c(login = password) from GooglePassword option
    # i.e. set with
    #     options(GooglePassword = c(login = "password"))
  g = googleSignIn()
  ans = getGTrends("coupon", curl = g)
}
}
\keyword{IO}

