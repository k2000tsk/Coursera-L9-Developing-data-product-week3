setwd("D:/1-1. R studio/Lecture9. Developing data product/week3")

# Today date
format(Sys.Date(),"%m-%d-%Y")

# install.packages("plotly")
library(plotly)

# Read csv file
library(data.table)
stock_data<-fread("kospi.csv",sep=",",header=TRUE)

# Sort the file order by date
library(lubridate)
stock_data$Date <- dmy(stock_data$Date)
stock_order<-stock_data[order(Date),]

# Calculate mean stock  of each day 
stock_order$Avg<-1:nrow(stock_order)
stock_order$Avg<-rowMeans(data.frame(stock_order$High,stock_order$Low))

# Plot
library(ggplot2)
plot_ly(stock_order,x=~Date,y=~Avg,mode="markers")%>%
  layout(title="KOSPI figures from 2003 ~ 2017",xaxis=list(title="Year"),yaxis=list(title="Stock Figure")) %>%
  add_ribbons(ymin=~Low,ymax=~High,name="Range of day") %>%
  add_lines(color=I("red"),name="Average of day")
