
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(caret)

set.seed(111)

inTrain<-createDataPartition(diamonds[,1],p=0.6,list=FALSE) #divide the training set 
#train<-diamonds[inTrain,c(1,2,7)]
train<-cbind(diamonds[inTrain,c(1,7)],cut=as.numeric(diamonds[inTrain,2]))    #by random subsampling
#test<-cbind(diamonds[-inTrain,c(1,7)],cut=as.numeric(diamonds[-inTrain,2]))


#model<-lm(train$price~I(train$carat),data=train)
model<-lm(I(log10(price))~carat+cut,data=train)
coefs<-model$coefficients
#a<-predict(model,test[1,1]^2)
# pred<-function(x){
#   coefs[1]+coefs[2]*(x)
# }
# a<-sapply(1:nrow(test),function(i) pred(test[i,1])-test[i,2])
prediction<-function(x,y){
  pred<-coefs[1]+coefs[2]*x+coefs[3]*as.numeric(y)
  10^pred
}

shinyServer(function(input, output) {

    #output$carat <- renderText({input$carat})
    output$desc <- renderText({paste("Diamond of ",input$carat,"carats and of ",levels(diamonds$cut)[as.integer(input$cut)],"cut:")})
    #diamond<-reactive({c(carat=input$carat,cut=input$cut)})
    #pred<-reactive({predict(model,diamond)})
    output$price <- renderText({paste(round(prediction(input$carat,input$cut)),"$")})
#
  })


