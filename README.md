# YelpHtmlParser

The Yelp HTML Parser is an experimental project designed to showcase the possibility of parsing Yelp content from HTML. For practical consumption of Yelp data, please use the Yelp API (http://www.yelp.com/developers/documentation). The purpose of this project is simply for fun and experimentation.

## What is supported

Currently it supports only the Buinsess search result HTML parsing given latitude and longitude coordinates and start index.

## How to use

    YelpHtmlParser::Business.search(-79.42, 43.85, -79.43, 43.84)

This would return businesses listed on Yelp search result page within the region mapped by the given coordinates.
