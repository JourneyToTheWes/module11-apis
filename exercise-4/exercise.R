### Exercise 4 ###
library("httr")
library("jsonlite")

# Use `source()` to load your API key variable.
# Make sure you've set your working directory!
source("apikey.R")


# Define a function that takes in the name of a movie as an argument and returns
# a list of information about that movie. The steps for this algorithm are below:

MovieInfo <- function(name.movie) {

    # Construct an HTTP request to search for reviews for the given movie.
    # The base URI is `https://api.nytimes.com/svc/movies/v2/`
    # The resource is `reviews/search.json`
    # See the interactive console for more detail:
    #   https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
    # You should use YOUR api key (as the `api-key` parameter)
    base.uri <- "https://api.nytimes.com/svc/movies/v2"
    resource <- "/reviews/search.json"
    query.params <- list("api-key"="e8a87bc0427040d4b4ff122236e40ef6", query=movie)

    # Send the HTTP Request to download the data
    # Extract the content and convert it from JSON
    response <- GET(paste0(base.uri,resource), query=query.params)
    body <- fromJSON(content(response, "text"))

    # What kind of data structure did this return?
    is.list(body)

    # Manually inspect the returned data and identify what content you wish to work with

    # Flatten that content into a data structure called `reviews`
    reviews <- flatten(body$results)

    # From the most recent review, store the headline, short summary, and link to
    # the full article, each in their own variables
    first.review <- reviews[1,]
    headline <- first.review$headline
    summary <- first.review$summary_short
    link <- first.review$link.url

    # Return an list of the three pieces of information from above
    info <- list(headline=headline, summary=summary, link=link)
    return(info)
}

# Test that your function works with a movie of your choice
movie.info <- MovieInfo("Lord of the Rings")
