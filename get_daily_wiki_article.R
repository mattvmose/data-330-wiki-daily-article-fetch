# get_daily_wiki_article.R

library(rvest)
library(dplyr)
library(readr)

url <- "https://en.wikipedia.org/wiki/Main_Page"

page <- read_html(url)

#Extract "Today's featured article section
featured <- page |>
  html_node("#mp-tfa p") |>
  html_text(trim=TRUE)

#Extract article link
featured_link <- page |>
  html_node("#mp-tfa b a") |> # first <a> in the section
  html_attr("href")

featured_url <- paste0("https://en.wikipedia.org", featured_link)

entry <- tibble(
  link = featured_url,
  article = featured
)


dir.create("wiki_files", showWarnings=FALSE)
file <- "wiki_files/article_of_the_day.csv"

if (file.exists(file)) {
  write_csv(entry, file, append=TRUE)
} else {
  write_csv(entry, file)
}