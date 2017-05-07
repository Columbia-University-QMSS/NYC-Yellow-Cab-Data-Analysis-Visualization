---
title: "Process Book - Team C NYC Cabs"
author: "Ze Jia, Hao Liu, Junxuan Mao, Qi Zhu"
date: "5/7/2017"
output: pdf_document
---

# Process book—group C NYC Cabs


###	Overview and Motivation: 

We are motivated by the bad traffic condition in Manhattan to do this project. We would like to figure out a way for both taxi drivers and passengers allocate their time and money more efficiently. 

### Related Work: 

We are inspired by 1) personal experiences. We see taxis all over the city when we do not need them, but see no taxi at all when we do. 
2) by the competition introduced by Uber and Lyft, etc. We would like to see how taxis can struggle their way out. 
3) by news such as Taxi medallions reach lowest value of 21st century, from the New York Post (http://nypost.com/2017/04/05/taxi-medallions-reach-lowest-value-of-21st-century/). 

###	Questions: 

Taxis are losing value; how can taxi drivers earn (more) money by picking up passengers at “better” locations? For a same location, when is a good time during a day to pick up a passenger? 
For passengers, where is a good place to be picked up, when 1) budget is tight, 2) time is tight
What do newspapers say about taxis nowadays?
Our questions have been changing during the time of our data exploration. We first wanted to see the change of taxi drivers’ earnings during a two-year period. However, the data for even one week is too big to be fully processed. We changed our mind from doing a huge time-series analysis to just focusing on one week’s data. 

###	Data: 

We used the TLC Yellow Taxi Dataset. We chose to use period: 04/04/2016 - 04/010/2016 (only one week). The dataset includes trip pickup and drop off locations, trip date & time, fare amount, which is more than 2.6+ million rides.
The Neighborhood Data, used to translate coordinates of locations onto maps, is from package “rgdal”. Location is from coordinate (latitude, longitude) —> neighborhood

e.g. (40.762344, -73.982364) —> Midtown
Merged Data: Pickup time is divided into hours. Trip duration (in sec): time difference between pickup & drop off. 
Text analysis data: We collected news which contain “New York taxi” and “New York cabs” from April to June 2016 from LexisNexis Academic. 

###	 Exploratory: 

There are 2,665,780 observations and 29 variables. Such an overwhelming dataset includes a lot of stuff to be explained: there are “tip amount” “payment type” “toll amount” etc. There could be many analysis deriving from this dataset. We narrowed down our research only looking at the “fare amount”, “locations”, and “travel time”.

###	Design Evolution: 

We explore the dataset with ggoplots and finally decided to present the visualization with interactive plots using plotly. The reason is that plotly is easier to present multiple variables in one table by simply adding traces, and users are free to choose any combination of information they want. For the geographic exploration, we first plot all data points on the map but then turn to cluster maps since there are too much data. We also employed heat map for better visualization. 

###	 Implementation: 
(Give some idea about the intent and functionality of the interactive visualizations you used in the final output.)

- Data table: 

We use interactive data table to show the original dataset and processed dataset in order for users to have a direct understanding of the dataset, as well as to guarantee the transparency of the data visualization process. 
Cluster Analysis of Pickup Locations: we use leaflet package to map all pickup locations for the one week trip data we subset from the entire data set to get a general sense of the distribution of the pickup locations. However, since there are 2.6+ million data points, we choose the cluster option in the leaflet package to show the data clustering numerically.  Detailed pop up information can be obtained by zooming into the clusters and clicking on the circle representing a trip pickup point.
Interactive line and bar chart: we use plotly package to build an interactive line and bar chart to explore what are the busy hours and the most efficient hours to earn profit as drivers in a day.  We obtain the efficiency by dividing the total fare amount by the trip duration for each trip.

- Shiny heat map:

We use a shiny map present heat maps of the pickup locations for 24 pickup hours in a day. The heat map is presented using the leaflet with additional web gadget “addWebGLHeatmap”. We also combined the neighborhood information with our yellow cab data, and plotted the top 10 hottest pickup neighborhood in different pickup hours. Users can select the pickup hour of interest to see the corresponding heat map and bar plot. 

- Word cloud: 

We built a word cloud for the top 50 most frequent words appeared in the news. Uber is the first word that comes into sight. It shows that the competition between the taxi and Uber is discussed by news to a large scale. “drivers” and “taxi” are the second and the third most frequent words, which coincides with our research topic. Highlights from the remaining words show that news are concerned with the service, time, pay, lawsuits, etc.
Sentiment Analysis: We also performed a sentiment analysis based on the NRC Word-Emotion Association Lexicon. The NRC Emotion Lexicon is a list of English words and their associations with eight basic emotions (anger, fear, anticipation, trust, surprise, sadness, joy, and disgust) and two sentiments (negative and positive). Here we are showing the percentages of each of the eight emotions that appeared in the news. In general, news express more positive feelings than negative ones. “trust” and “anticipation” outnumbers “fear” and “anger”. 


###	Evaluation: 

We learned that the busiest areas are: Manhattan, Williamsburg of Brooklyn, LGA and JFK. It is always better for taxi drivers to pick up people from the above areas. 

The drivers earn higher dollar per minute in the morning, when there are the fewest number of trips. So if a taxi driver want to make more money but work fewer hours, he would be better off working in the early morning in the busiest areas. Midtown, west village, and east village are the top three hottest pickup spots.

###	Next Steps:

If we are able to continue the study, we would like to explore the change of fare, pick up time & location, and emotions in a longer period of time. Also we would like to incorporate those variables that were excluded in data wrangling process, such as the tip, toll fare information. 

It would be helpful for the taxi companies to know how news think about taxis and they can thus adjust their business strategies. We could also include social media text data to understand the mass opinions.

