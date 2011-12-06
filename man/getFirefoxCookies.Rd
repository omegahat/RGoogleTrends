\name{getFirefoxCookies}
\alias{getFirefoxCookies}
\title{Retrieve data frame of current Firefox cookies}
\description{
  This function reads the current/live collection of cookies
  from the Firefox browser.
  One can specify which cookie database to use.
  In the future, one will be able to specify the
  user name, i.e. the profile identifier.
}
\usage{
getFirefoxCookies(cookieJar = findCookiesFile(copy),
                  con = dbConnect(SQLite(), cookieJar),
                  copy = TRUE)
}
\arguments{
  \item{cookieJar}{the name of the file containing the cookies}
  \item{con}{a connection to the database. This is a parameter to allow
   an existing connection to be reused.}
  \item{copy}{whether to copy the cookie file. This is \code{TRUE}
    so that we don't have issues with Firefox locking the file.}
}
\value{
  A data frame with 9 columns.
 \item{id}{}
 \item{name}{the name of the cookie}
 \item{value}{the value of the cookie}
 \item{host}{the host for which the cookie is targeted}
 \item{path}{the path within the host for the cookie}
 \item{expiry}{when the cookie expires}
 \item{lastAccessed}{}
 \item{isSecure}{a logical value indicating whether the cookie is secure
 or not}
 \item{isHttpOnly}{whether the cookie is intended for HTTP only}
}
\references{
}
\author{
Duncan Temple Lang
}

%\seealso{}
\examples{
}
\keyword{IO}
