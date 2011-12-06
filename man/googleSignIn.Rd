\name{googleSignIn}
\alias{googleSignIn}
\title{Login to Google account}
\description{
  This function doesn't quite work yet.
  The idea is that we use this to login into a Google account
  and then we use the resulting connection for future requests.
  The initial login will cause cookies to be set in the
  curl connection and so sent in future requests.
}
\usage{
googleSignIn(login = getOption("GooglePassword"), password, service = "trends",
              curl = getCurlHandle(verbose = FALSE,
                                   cookiefile = "",
                                   followlocation = TRUE), 
              userAgent = getOption('HTTPUserAgent'),
              GALX = getGALX(curl))
}
\arguments{
  \item{login}{the name/login for the Google account. You can set this as an R option
    named GooglePassword and it should be a named character string 
  of the form \code{c(login = "password")}. You can set this in your .Rprofile
    so it is available in all sessions. Make certain to ensure that file is not readable by 
   anybody but you.}
  \item{password}{the password for the Google account. This can be left empty if the 
    login and password are passed via the \code{login} parameter.}
  \item{service}{an optional service for which we are logging in}
  \item{curl}{a curl handle used for the login request and returned
      with the updated state.}
  \item{userAgent}{the value for the User-Agent field in the HTTP header}
  \item{GALX}{the value of the Google GALX cookie. This will almost always be omitted in the call and computed
   explicitly.}
}
\value{
  A curl handle that can be used in subsequent requests to Google.
}
\references{
}
\author{
Duncan Temple Lang
}

\seealso{
}
\examples{

}
\keyword{IO}
\concept{Web Services}

