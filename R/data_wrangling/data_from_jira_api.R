library(httr)
library(base64enc)
library(jsonlite)

# Setup creds
api_token <- readLines("data/api_token.txt") # Generate an API token and store it here
username <- "" # Username/email you used to log into Jira
creds <- paste0(username, api_token)

# Encode creds to base64.
# Using this particular base64 function because it does not add newlines in the encoded string.
raw_string <- charToRaw(creds)
creds_encoded <- base64encode(raw_string)

# Create value for Authorization header
header_auth <- paste0("Basic ", creds_encoded)

# Send an API request!
domain <- "" # Set your org's domain here
issue_number <- "" # In this example,  use the api to fetch data for an issue
url <- paste0("https://", domain, ".atlassian.net/rest/api/3/issue/", issue_number)

res <- GET(
  url,
  add_headers(Authorization = header_auth)
)

# View and manipulate the data
data <- fromJSON(rawToChar(res$content))
data$fields$priority$name

# EXAMPLE: URL for issues in a project of a certain type
project <- ""
issue_type <- ""
example_url <- paste0("https://", domain, ".atlassian.net/rest/api/3/search?jql=project=", project, "%20and%20type=", issue_type)
