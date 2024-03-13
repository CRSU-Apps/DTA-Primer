
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


 # The smalller the resolution the higher the number of plotting points but 
 # the slower the app will be to update 

  resolution <- 0.05

 # Defining the colour scheme used in the app here to make it easy to change/update

## Colour schemes for 3 transparent colours seems easy, but four needs more research!
  
  col_healthy <- rgb(0,100,0,127, maxColorValue = 255)
  col_diseased <- rgb(139,0,0,127, maxColorValue = 255)
  
  FN_col <- rgb(166, 97, 26, 127, maxColorValue=255) 
  TP_col <- rgb(223, 194, 125, 127, maxColorValue=255)
  
  TN_col <- rgb(166, 217, 106, 127, maxColorValue=255)
  FP_col <- rgb(26, 150, 65, 127, maxColorValue=255)
 
   trans <- rgb(255,255,255,255, maxColorValue=255)
  col_bar<-c(trans,trans,trans,trans)
 
 
  # Loading in icon images for TP, FP, TN, FN
  
  rmanr<-readPNG('./www/rmanr.png')
  rmang<-readPNG('./www/rmang.png')
  gmang<-readPNG('./www/gmang.png')
  gmanr<-readPNG('./www/gmanr.png')

  shinyServer(function(input, output, session) {
  
    
###########################################################
##### Code and text for revealing answers to questions ####
###########################################################
   
    
    output$ans1 <- renderText({(paste("Every ROC curve passes through the bottom left (specificity = 1,
sensitivity = 0) & top right (specificity = 0, sensitivity = 1).
The bottom left point is associated with a threshold value higher than the body of both the test distributions 
for diseased and healthy. (At such a threshold the test would classify all patients as healthy).
The top right point is assoicated with a threshold value lower than the body of both distributions 
for diseased and healthy. (At such a threshold the test would classify all patients as diseased.)")) })
    
    observeEvent(input$a1, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans1", TRUE)})

 
    output$ans2 <- renderText({(paste("The mean and standard deviations of the test results 
              have to be the same for both diseased and healthy patients for the test to 
              have no-accuracy. (Another way of looking at this is that it implies any test score 
                is equally likely to come from either distribution and hence has no discriminatory 
                                      ability.)"))})
    
    observeEvent(input$a2, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans2", TRUE)})
    
    output$ans3 <- renderText({(paste("When this happens the ROC curve goes convex and falls 
below the no accuracy line. This implies the test is worse than results that could be obtained
                                       by guessing disease status of patients(!) In practice this
                  should never happen because it implies, to some extent, that a low test value is indicative of disease 
                                      and thus the threshold rule can be 'flipped'."))})
    
    observeEvent(input$a3, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans3", TRUE)})
    
    output$ans4 <- renderText({(paste("The test will be more accurate as the difference between the means for
                                      diseased and healthy patients is increased. Accuracy is also improved 
                                      as the standard deviations of the distributions is reduced.
                                       Both of these reduce the degree of overlap between the distributions 
                                      for healthy and diseased patients which in turn minimises false 
                                      positive and false negative errors. If there is no overlap at all,
                                      then the test is perfect with an ROC that passes through the top left extreme where
                                       sensitivity = specificity = 1"))})
    
   ## The below code sets the values of the inputs to show answers to the different questions
    
     observe({
      if(input$sl1){
        updateSliderInput(session, "mean_healthy", value = 15)
        updateSliderInput(session, "sd_healthy", value = 0.5)
        updateSliderInput(session, "mean_diseased", value = 25)
        updateSliderInput(session, "sd_diseased", value = 0.5)
        showModal(modalDialog(
          title = "Settings have been changed to illustrate answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    observe({
      if(input$sl2){
        updateSliderInput(session, "mean_healthy", value = 20)
        updateSliderInput(session, "sd_healthy", value = 5)
        updateSliderInput(session, "mean_diseased", value = 20)
        updateSliderInput(session, "sd_diseased", value = 5)
        showModal(modalDialog(
          title = "Settings have been changed to illustrate answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    observe({
      if(input$sl3){
        updateSliderInput(session, "mean_healthy", value = 22)
        updateSliderInput(session, "sd_healthy", value = 5)
        updateSliderInput(session, "mean_diseased", value = 17)
        updateSliderInput(session, "sd_diseased", value = 5)
        showModal(modalDialog(
          title = "Settings have been changed to illustrate answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    
    observe({
      if(input$sl4){
        updateSliderInput(session, "mean_healthy", value = 17)
        updateSliderInput(session, "sd_healthy", value = 3)
        updateSliderInput(session, "mean_diseased", value = 21)
        updateSliderInput(session, "sd_diseased", value = 3)
        showModal(modalDialog(
          title = "Settings have been changed to illustrate answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    
    observe({
      if(input$sl5){
        updateSliderInput(session, "mean_healthy", value = 20)
        updateSliderInput(session, "sd_healthy", value = 3)
        updateSliderInput(session, "mean_diseased", value = 24)
        updateSliderInput(session, "sd_diseased", value = 3)
        showModal(modalDialog(
          title = "Settings have been changed to illustrate answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    
    observe({
      if(input$sl6){
        updateSliderInput(session, "mean_healthy", value = 18)
        updateSliderInput(session, "sd_healthy", value = 8)
        updateSliderInput(session, "mean_diseased", value = 21)
        updateSliderInput(session, "sd_diseased", value = 2)
        showModal(modalDialog(
          title = "Settings have been changed to illustrate answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    
    observe({
      if(input$sl7){
        updateSliderInput(session, "mean_healthy", value = 16)
        updateSliderInput(session, "sd_healthy", value = 3.1)
        updateSliderInput(session, "mean_diseased", value = 22)
        updateSliderInput(session, "sd_diseased", value = 3.7)
        showModal(modalDialog(
          title = "Settings have been changed:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    
    observe({
      if(input$sl8){
        updateSliderInput(session, "mean_healthy", value = 16)
        updateSliderInput(session, "sd_healthy", value = 3.1)
        updateSliderInput(session, "mean_diseased", value = 22)
        updateSliderInput(session, "sd_diseased", value = 3.7)
        updateSliderInput(session, "threshold", value = 18)
        updateSliderInput(session, "prevalence", value = 51)
        showModal(modalDialog(
          title = "Settings have been changed to show answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    
    observe({
      if(input$sl9){
        updateSliderInput(session, "mean_healthy", value = 18)
        updateSliderInput(session, "sd_healthy", value = 2)
        updateSliderInput(session, "mean_diseased", value = 22)
        updateSliderInput(session, "sd_diseased", value = 2)
        updateSliderInput(session, "threshold", value = 19)
        showModal(modalDialog(
          title = "Settings have been changed to show answer:",
          "You will need to change tabs to see the results",
          easyClose = TRUE))
      } 
    }
    )
    
    observeEvent(input$a4, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans4", TRUE)})
    
    output$ans6 <- renderText({(paste("When this happens the ROC curves are always symmetrical around the sensitivity = specificity 
                                      line (the diagonal not drawn on the ROC curve)"))})
    
    
    observeEvent(input$a9, {
      toggle("ans9", TRUE)})
    
    output$ans9 <- renderText({(paste("The sensitivity is 93.3% and the specificity is 69.1%"))})
    
    observeEvent(input$a6, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans6", TRUE)})
    
    output$ans5 <- renderText({(paste("The ROC curve is identical to the situation before the means were
                                       increased by 3 each. This result is generalisable. Test accuracy is only dependent
                                      of the differences between distributions, and not their absolute values."))})
    
    observeEvent(input$a5, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans5", TRUE)})
    
    
    output$ans7 <- renderText({(paste("Non-concave ROC curves of this type are considered 'improper' and can lead to estimation problems."))})
    
    observeEvent(input$a7, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans7", TRUE)})
    
    output$ans8 <- renderText({(paste("The threshold should be set to 18 to maximise specificity to 74.1% while ensuring sensitivity does
                                       not fall below 80%. There would have to be a ", "<b>", "prevalence", "</b>"," of at least 51% of patients having the disease for the 
                                      expected number of patients correctly diagnosed to reach 800 out of 1000. (Because the sensitivity is higher than specificity
                                       for these settings it follows that the more diseased people are present (i.e. the ","<b>","prevalence", "</b>"," is higher) the more patients will be correctly
                                       diagnosed overall, because the test performs better at correctly diagnosing diseased compared to healthy patients.)"))})
    
    observeEvent(input$a8, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("ans8", TRUE)})
    
    output$expl1 <- renderText({(paste("Diagnostic tests are used in medicine to guide future treatment decisions. Many test results 
are measured on a continuous scale, e.g. level of a chemical in a blood sample, but a threshold/cut-off value for test results is required to categorise patients into those
who are considered to have the disease being tested for and those who don't . This primer considers how the performance of a test is measured. Although this webpage starts from the basics, for those with little prior knowledge of this topic, ", 
                                       "<a href='https://m.youtube.com/watch?list=PLkfBg8ML-gIlOHgOLZMPaHq_GrM86zFrJ&v=UF1T7KzRnrs'>", "this 6 minute video", "</a>", "provides further context and is recommended viewing.", br(), br(),
"Consider a test which measures some quantity on a continuous scale.
                                       For simplicity, assume the values for this test are ","<a href='https://en.wikipedia.org/wiki/Normal_distribution'>", "normally 
                                       distributed", "</a>",  "with ", "<b>", "separate distributions", "</b>", " for those who truly have 
                                       the disease being tested for and those who don't (referred to as 'healthy' going forward, 
but they may have diseases not being tested for).", br(), br() , "<section style ='color:#565541; background-color:#f7f4a5'>", "<i>", "You can change the values 
                                       for the means and standard deviations for both distributions using the sliders.", "</i>", "</section>",
                                       br(),
                                       "A ", "<b>","test threshold", "</b>", " (cut-point) value is identified above which patients are diagnosed
                                       as having the disease of interest and below which they are diagnosed as not having the 
                                       disease (healthy).", br(), br(),"<section style ='color:#565541; background-color:#f7f4a5'>", "<i>", "The threshold slider can be used to change the test threshold to explore
                                       the impact this has on test performance.", "</i>", "</section>",
                                       br(),
                                       "The threshold value usually dissects the distributions of test values for the diseased and
                                       healthy (see below left figure) creating four distinct categories of patient: i) Diseased and correctly diagnosed 
                                       - ", "<b>", "True Positives (TP)", "</b>"," ; ii) Diseased but incorrectly diagnosed as healthy - "
,"<b>","False Negatives (FN)","</b>","; 
                                       iii) Healthy and correctly diagnosed as healthy - ","<b>","True Negatives (TN)","</b>","; and iv) Healthy but incorrectly
                                       diagnosed as diseased - ","<b>","False Positives (FP).","</b>", br(), br(),"<section style ='color:#565541; background-color:#f7f4a5'>","<i>", 
"You can identify these fractions of the distributions on 
                                       the plots using the check boxes.", "</i>", "</section>"
                                       ))})
    
    observeEvent(input$e1, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("expl1", TRUE)})
    
    
    
    output$expl2 <- renderText({(paste("The", "<b>", "fraction of diseased patients correctly diagnosed", "</b>" ," by a test is
             often referred to as test", "<font color=\"#8B0000\">","<b>", "sensitivity", "</b>","</font>", " and the ", "<b>" , "fraction of healthy 
                                       patients correctly diagnosed", "</b>"," by a test as","<font color=\"#006400\">", "<b>"," specificity" , "</b>", 
"</font>",". These quantities are used to describe the performance of a 
                                       diagnostic test, and ", "<b>","both will vary with the test threshold", "</b>", "used.",
                                       br(),
                                       br(),
                                       "If", "<b>", " 1 -", "<font color=\"#006400\">", "specificity", "</b>", "</font>", " is plotted against ", "<font color=\"#8B0000\">", "<b>", "sensitivity", "</b>", "</font>"," for", "<b>", "all threshold values,","</b>", 
                                       "a", "<b>", " Receiver Operating Characteristic (ROC)", "</b>", " plot is created (above right figure). This ", "<b>", " summarises test 
                                       performance across all thresholds", "</b>", "giving the possible trade-offs that can be achieved between False Negatives and False Positives (plotted above).",
br(), br(), "<section style ='color:#565541; background-color:#f7f4a5'>","<i>", "Explore how changing the means 
                                       and variances of the test distributions in the diseased and healthy affect the ROC curve.", "</i>", "</section>"
                                        ))})
    
    observeEvent(input$e2, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("expl2", TRUE)})

    
    output$expl3 <- renderText({(paste("<font color=\"#8B0000\">","<b>","Sensitivity", "</b>","</font>", " and", "<font color=\"#006400\">", "<b>"," specificity", "</b>", "</font>",
" describe how well the test result reflects the 
  true disease state, but to get a full picture of how the test would perform, when used in  
                                       clinical practice, the proportion of tested patients who are indeed diseased - ","<b>","prevalence", "</b>"," - needs 
                                       considering.", br(), br(), "<section style ='color:#565541; background-color:#f7f4a5'>", "<i>","<b>", "Prevalence", "</b>"," can be altered using the slider 
while observing the changes in the categorisation of patients to","<b>", "TP, FN, TN & FP", "</b>", "in the table and on one of the selectable visualisations.","</i>", "</section>", br(), br()))})
    
    
    output$expl4 <- renderText({(paste(br(),br(),br(), "<b>", "Positive", "</b>", " & ", "<b>","Negative predicted values", "</b>",
                                       " depend on both test performance and disease ","<b>","prevalence", "</b>"," and provide the probability that a patient with a positive test result is diseased 
and the probability that a patient with a negative test result is healthy respectively.", br(), br(),"These are clinicially relevant measures for health 
professionals to use when talking to patients.") )
    })
    

    
    observeEvent(input$e3, {
      # every time the button is pressed, alternate between hiding and showing the plot
      toggle("expl3", TRUE)})
    
    
    
  ########################################################
  #### MODULARISING REACTIVITY TO IMPROVE PERFORMANCE ####
  ########################################################
  
  ## Not sure this is helping speed up as no task done below, 
  ## but principle is OK
   THRESHOLD <- reactive({input$threshold})
  
  ## Since Sensitivity and Specificity used in several places, 
  ## placed here
   
   TP_PCT <- reactive({(1-pnorm(THRESHOLD(), 
                               input$mean_diseased, input$sd_diseased))*100})
   
   TN_PCT<- reactive({pnorm(THRESHOLD(), 
                 input$mean_healthy, input$sd_healthy) *100})
  
   
  ## Below used in several places to report results of using test
   
   TP_POP <- reactive({ (TP_PCT()/100) * (input$prevalence/100) * 1000 })  
   FN_POP <- reactive({ (1-(TP_PCT()/100)) * (input$prevalence/100) * 1000 })
   TN_POP <- reactive({ (TN_PCT()/100) * (1-(input$prevalence/100)) * 1000 })
   FP_POP <- reactive({ (1-(TN_PCT()/100)) * (1-(input$prevalence/100)) * 1000 })
   
   COUNTS <- reactive({c(FP_POP(),TN_POP(),FN_POP(),TP_POP())})
   
   PREVALENCE <-reactive({input$prevalence})
   
 
  ##############################################################
  ##### PLOT OF TEST DISTRIBUTIONS FOR HEALTHY AND DISEASED ####
  ##############################################################
  
  output$overlay_threshold <- renderPlot({
       
     
    
  # calculating the range for plot to fit both distributions fully on
    
    xmin1<- c(input$mean_healthy-(5*input$sd_healthy), input$mean_diseased-(5*input$sd_diseased))
    xmin2 <-min(xmin1,0)
    
    xmax1<- c(input$mean_healthy+(5*input$sd_healthy), input$mean_diseased+(5*input$sd_diseased))
    xmax2 <-max(xmax1,40)
    
    ## Taking the progress bar out as it seems to slow down updates after user input
    
  #  withProgress(message = 'Making plot', value = 0, {
      # Number of times we'll go through the loop
  #    n <- 10
      
  #    for (i in 1:n) {
    
    
    
  ## HEALTHY PATIENT DISTRIBUTION
    seq_healthy<-seq(xmin2,xmax2,resolution)
    densities_healthy<-dnorm(seq_healthy, input$mean_healthy,input$sd_healthy)
    
  #Calculating PDF plot values split at threshold for healthy
   
    seq_healthy_tn<-c(seq(xmin2,THRESHOLD(), resolution))
    seq_healthy2_tn<-c(xmin2,seq_healthy_tn ,THRESHOLD())
    
    densities_healthy_tn <-dnorm(seq_healthy_tn, input$mean_healthy,input$sd_healthy) 
    densities_healthy2_tn <- c(0,densities_healthy_tn,0) 
    
    seq_healthy_fp<-seq(THRESHOLD(),xmax2,0.01)
    seq_healthy2_fp<-c(THRESHOLD(),seq_healthy_fp,xmax2)
    
    densities_healthy_fp <-dnorm(seq_healthy_fp, input$mean_healthy,input$sd_healthy) 
    densities_healthy2_fp <-c(0,densities_healthy_fp,0) 
    
    
 ## DISEASED PATIENT DISTRIBUTION
    
    seq_diseased<-seq(xmin2,xmax2,resolution)
    densities_diseased<-dnorm(seq_diseased, input$mean_diseased,input$sd_diseased)
    
    #Calculating PDF plot values split at threshold for diseased
    seq_diseased_tp<-seq(THRESHOLD(),xmax2,resolution)
    seq_diseased2_tp<-c(THRESHOLD(),seq_diseased_tp,xmax2)
    
    densities_diseased_tp<-dnorm(seq_diseased_tp, input$mean_diseased,input$sd_diseased)
    densities_diseased2_tp <- c(0, densities_diseased_tp, 0)
    
    seq_diseased_fn<-c( seq(xmin2,THRESHOLD(),.01))
    seq_diseased2_fn<-c(xmin2, seq_diseased_fn,  THRESHOLD())
    
    densities_diseased_fn<- dnorm(seq_diseased_fn, input$mean_diseased,input$sd_diseased)
    densities_diseased2_fn <- c(0, densities_diseased_fn, 0)
    
    ## Working out the max height of the 2 densities to set plot limit
    
    seq_c <- c(densities_healthy, densities_diseased)
    ymax <- max(seq_c)
    
    ## Plotting PDF outlines for the diseased and healthy populations   
    
    plot(seq_healthy, densities_healthy, col=col_healthy,xlab="", ylab="", 
         type="l",lwd=4, cex=2, main="Distribution of test values in diseased and healthy", 
         cex.axis=.8, cex.main=0.9, ylim = c(0, (ymax+ymax/5)), xlim=c(-5, 50))
    
    title(ylab="Density", mgp=c(2,1,0),cex.lab=1)
    title(xlab="Test Response", mgp=c(2,1,0),cex.lab=1)
    
    lines(seq_diseased, densities_diseased, col=col_diseased, 
          type="l",lwd=4)
    
    # Adding line for current threshold to plot
    
    abline(v=THRESHOLD(), lwd=3)
    
    ## Adding interactive shading for TP, FP, FN, TN regions
 
    if(input$FN) { 
    polygon(seq_diseased2_fn,densities_diseased2_fn,col=FN_col)}
 
    if(input$TP) {
    polygon(seq_diseased2_tp,densities_diseased2_tp,col=TP_col) }
    
    if(input$TN) { 
    polygon(seq_healthy2_tn,densities_healthy2_tn,col=TN_col)}
    
    if(input$FP) {
    polygon(seq_healthy2_fp,densities_healthy2_fp,col=FP_col)}
    
    col_legend <- c(col_healthy, col_diseased, "black")
    leg_txt <- c("Healthy", "Diseased", "Test Threshold")
    y_place <- ymax + (ymax/4.5)
    x_place <- -5
    
    legend(x=x_place, y=y_place, leg_txt, lty=c(1,1), lwd=c(4,4), col=col_legend, cex=0.75, box.col=NA)
    
    ### It would be a good exercise to redo this plot using ggplot! 
    
    
 #   incProgress(1/n, detail = paste("Doing part", i))

  #    } })
    
    
    
  })
  
    
    output$table.sesp <- renderPlot({
      
      
      ###################################################################
      ## 2 x 2 contingency table for sens and spec ######################
      ###################################################################
      
      ## Saving existing parameters in case I need to restore them(?)
      op<-par(no.readonly=TRUE) 
      ## Margin does not work when put in the plot command!!
        par(mar=c(0,0,0,0))
         plot(0.5:4.5, type="n", xlim=c(0.4,3.1), ylim=c(1.8,4.6),xaxs="i", xlab="",ylab="",
              axes=F)
      
         x=c(1,2,3)
         y=c(2,3,4)
         
         for (i in 1:3){
         lines(x=c(x[i],x[i]),y=c(2,4))
         lines(x=c(1,3),y=c(y[i],y[i]))}
        text(2,4.5,"True Status", cex=1.4, font=2)
         text(1.5,4.3,"Diseased", cex=1.2, font=2)
        text(2.5,4.3,"Healthy", cex=1.2, font=2)
        text(.7,3,"Test", cex=1.4, font=2)
         text(.85,2.5,"-", cex=2, font=2)
         text(.85,3.5,"+", cex=2, font=2)
        
         if(input$TP) {polygon(c(1,1,2,2),c(3,4,4,3), col=TP_col)
           text(1.7,3.8, "Sensitivity", cex=1, col="dark red") }
         if(input$FP) {polygon(c(2,2,3,3),c(3,4,4,3), col=FP_col)
           text(2.7,3.8, "1-Specificity", cex=1)}
         if(input$FN) {polygon(c(1,1,2,2),c(2,3,3,2), col=FN_col)
           text(1.7,2.8, "1-Sensitivity", cex=1)}
         if(input$TN) {polygon(c(2,2,3,3),c(2,3,3,2), col=TN_col)
           text(2.7,2.8, "Specificity", cex=1, col="dark green")}
         
         
         text(1.65,3.5, paste(round(TP_PCT(), digits = 1), "%"), cex=1.7, col="blue")
        text(2.65,3.5, paste(round(100- TN_PCT(), digits = 1), "%"), cex=1.7, col="blue")
         text(1.65,2.5, paste(round(100- TP_PCT(), digits = 1), "%"), cex=1.7, col="blue")
         text(2.65,2.5, paste(round(TN_PCT(), digits = 1), "%"), cex=1.7, col="blue")
       
         rasterImage(gmanr,2.1,3.1,2.32,3.9, interpolate=F)
         rasterImage(gmang,2.1,2.1,2.32,2.9, interpolate=F)
         rasterImage(rmang,1.1,2.1,1.32,2.9, interpolate=F)
         rasterImage(rmanr,1.1,3.1,1.32,3.9, interpolate=F)
       } )
      
  
    
    ############################################################################
    ### BASIC TEXT DESCRIPTION OF TEST PROPERITES AT CHOSEN DISTRIBUTION AND ###
    ### THRESHOLD VALUES #######################################################
    ########################
    
   
    output$threshold_selected <- renderText({paste(br(), "Performance of a test relating to ", "<b>","specified distribution", "</b>", " and ", 
                                                   "<b>", "threshold values:", "</b>", br(), br(), "<b>","Selected threshold", "</b>"," above which test diagnoses 
                                                   patients as diseased is ","<font color=\"#253494\"><b>",
                                                   THRESHOLD(), "</b></font>", ".", sep="") 
    })
    
    
    output$percent_tp <- renderText({ 
    
    
  ## Working out % of health PDF less than selected threshold
    
    paste("At this test threshold ","<font color=\"#253494\"><b>", round(TP_PCT(), digits = 1), 
          "</b></font>" , 
         "% of diseased patients are correctly diagnosed by the test (","<font color=\"#8B0000\">","<b>","sensitivity","</b>","</font>","), and ",
         "<font color=\"#253494\"><b>", round((100-TP_PCT()), digits=1),"</b></font>" , "% are 
         incorrectly diagnosed as healthy. ",  br(), br(),"<font color=\"#253494\"><b>", round(TN_PCT(), digits=1),
         "</b></font>", "% of healthy patients are correctly diagnosed by the test (","<font color=\"#006400\">","<b>","specificity","</b>","</font>","), and ", 
         "<font color=\"#253494\"><b>",  round((100-TN_PCT()), digits=1), "</b></font>",
         "% are incorrectly diagnosed as diseased.", sep="") 
       
        })
  
  
  #############################################################
  ### ROC PLOT FOR CHOSEN DISTRIBUTIONS AND THRESHOLD VALUE ###
  #############################################################
  
   output$ROCplot <- renderPlot({
    
    widths  <- session$clientData$output_ROCplot_width
    widthr <- min(widths, 400)
    cex.w <- widthr/375
    
    
    withProgress(message = 'Making plot', value = 0, {
      # Number of times we'll go through the loop
      n <- 10
      
      for (i in 1:n) {
    
    
    ## HEALTHY PATIENT CUMULATIVE DISTRIBUTION
    
    # Hard wiring range of thresholds ROC calculated for is 0 to 60
    seq_ROC<-seq(0,60, resolution)
    
    
    cdf_healthy<-pnorm(seq_ROC, input$mean_healthy,input$sd_healthy)
    cdf_diseased<-pnorm(seq_ROC, input$mean_diseased,input$sd_diseased)
    
    ## Aspect ratio option - asp - messes things up here - fix in ui size?
    ## this seems non trivial - due to not being able to set height in html
    
    plot((cdf_healthy), (1-cdf_diseased), col="black", ylab="", xlab="", 
         type="l",lwd=4, cex=1.3*cex.w, main="Receiver Operating Characteristic (ROC) Plot",
         cex.main=.9*cex.w, cex.axis=.8*cex.w,  xlim=c(1,0), ylim=c(0,1), las=1, at=c(0,.2,.4,.6,.8,1), labels=c("0","20","40","60","80","100" ))
    
    title(ylab="True Positive Fraction: Sensitivity (%)", mgp=c(2,1,0),cex.lab=1*cex.w)
    title(xlab="True Negative Fraction: Specificity (%)", mgp=c(2,1,0),cex.lab=1*cex.w)
    
    abline(a=1,b=-1, col="black", lty=2)
    
    
    sequence_n <-THRESHOLD() * (1/resolution)
    
    points((cdf_healthy[sequence_n+1]), (1-cdf_diseased[sequence_n+1]), col="red", lwd=2, 
           bg="dark red", cex=3*cex.w, pch=23)
    
    plotminx <-max(0.1, (cdf_healthy[sequence_n+1]-.07) )
    plotminy <-max(0.1, (1-cdf_diseased[sequence_n+1]-.07) )
    
    text(plotminx, plotminy , label=THRESHOLD())
    
#### Adding estimates of tp, fp, fn, tn fractions to to ROC plot to link plots  
    
    if(input$FP) {lines(x=c(1, TN_PCT()/100), y=c(TP_PCT()/100, TP_PCT()/100), 
          lty=1, col = FP_col, lwd=20, lend="butt")}
    
    if(input$TN) {lines(x=c(0, TN_PCT()/100), y=c(TP_PCT()/100, TP_PCT()/100), 
          lty=1, col = TN_col, lwd=22, lend="butt")}
    
    if(input$TP) {lines(x=c(TN_PCT()/100, TN_PCT()/100), y=c(0, TP_PCT()/100), 
          lty=1, col = TP_col, lwd=18, lend="butt")}
    
    if(input$FN) {lines(x=c(TN_PCT()/100, TN_PCT()/100), y=c(1, TP_PCT()/100), 
          lty=1, col = FN_col, lwd=16, lend="butt")}
    
   
    
    
    col_legendr <- c("black", "black", "red")
    leg_txtr <- c("ROC curve", "No accuracy line", "Current threshold accuracy")
    pch_legendr <- c(NA,NA, pch=23)
    
    legend(x=0.8, y=0.2, leg_txtr, lty=c(1,2,-1), col=col_legendr, 
           cex=0.8*cex.w, bty="n", pch=pch_legendr, merge=T, lwd=c(2,1,NA), pt.bg="darkred", 
           pt.cex=c(NA,NA,1.5))
    
    ## ** WOULD BE GOOD TO TRY IN GGPLOT2
    
    ## Attempting to fix the plot as square to fit the space
    
    incProgress(1/n, detail = paste("Doing part", i))
      }
    })
    
    
    
    
    
  },  width = function() {
   min(600, session$clientData$output_ROCplot_width * 0.95,session$clientData$output_ROCplot_height * 0.95 )
  },  height = function() {
    min(630,session$clientData$output_ROCplot_width, session$clientData$output_ROCplot_height )
  

    
    
    })

## Below is web fix but writing gets messed up on plot
## see https://github.com/rstudio/shiny/issues/705
### and https://github.com/rstudio/shiny/issues/650
#,  height = function() 1 * session$clientData$output_ROCplot_width)
  
  ####################################################
  ##### Text for overall test results ################
  ####################################################
    
    output$tot_posneg <- renderText({ 
      
      
      paste("<font size= 4%>","Taking ", "<font color=\"#000000\"><b> 1000 </b></font>", "patients tested with 
            a disease ","<b>", "prevalence", "</b>"," (in those tested) of ", "<font color=\"#253494\"><b>", 
              round(input$prevalence),"</b></font>" ,"%, produces the following:", sep="")
      })       
      
    ## Taking below out because think it is an unnecessary amount of information     
    # expected categorisations: ","<font color=\"#253494\"><b>", round(TP_POP()+FP_POP()), "</b></font>",
    #       " patients test +ve, and ", "<font color=\"#253494\"><b>",
    #        round(TN_POP()+FN_POP()), "</b></font>", " patients test -ve.", sep="")
      
   
    
    
  #####################################################
  #### HORIZONTAL BAR PLOT FOR TP TN FN FP ############
  #####################################################
 
  
    
    # If conditions determining which plot should be used
    
    output$optionplot <- renderPlot({
      if(input$pType == 'Ap'){

          # Simple Horizontal Bar Plot with Added Labels 
          
          par(las=2, mar=c(4,1,2,1))
          
          if(input$FP) {col_bar[1] <- FP_col }
          if(input$TN) {col_bar[2] <- TN_col }
          if(input$FN) {col_bar[3] <- FN_col }
          if(input$TP) {col_bar[4] <- TP_col }
          
          barplot(COUNTS(), main="Patients diagnosed", horiz=TRUE,
                  names.arg=c("FP", "TN", "FN", 'TP'), col = col_bar, xlim=c(0,1150), las=1)
          
          
          rasterImage(gmanr,COUNTS()[1]+100,0.2,COUNTS()[1]+145,1.2)
          rasterImage(gmang,COUNTS()[2]+100,1.3,COUNTS()[2]+145,2.3)
          rasterImage(rmang,COUNTS()[3]+100,2.6,COUNTS()[3]+145,3.6)
          rasterImage(rmanr,COUNTS()[4]+100,3.8,COUNTS()[4]+145,4.8)
          
          text(COUNTS()+50,y=c(0.8,1.9,3.1,4.3), round(COUNTS()), col="blue", cex=1.5)
          
        }
      
     
      output$Bp <- renderPlot({ 
        
        widths  <- session$clientData$output_Bp_width
        width <- min(widths, 700)
       # height <- session$clientData$output_Bp_height
        
 
        
        ###################################################################
        ## 2 x 2 contingency table for test results #######################
        ###################################################################
          
          ## the aspect ratio command (asp) is overriding xlim and making white space
          ## around the plot excessive - not sure how to fix? Control with plot size in ui.R?
          par(mar=c(0,0,0,0))
          plot(1:6,1:6,type="n", xlim=c(0.5,5.5), ylim=c(0,5.1)
               , xlab="",ylab="", axes=F)
          x=c(1,2,3)
          y=c(2,3,4)
          
          for (i in 1:3){
            lines(x=c(x[i],x[i]),y=c(2,4))
            lines(x=c(1,3),y=c(y[i],y[i]))}
          text(2,4.8,"True Status", cex=1.4*(width/700), font=2)
          text(1.5,4.3,"Diseased", cex=1.2*(width/700), font=2)
          text(2.5,4.3,"Healthy", cex=1.2*(width/700), font=2)
          text(.6,3,"Test", cex=1.4*(width/700), font=2)
          text(.85,2.5,"-", cex=2*(width/700), font=2)
          text(.85,3.5,"+", cex=2*(width/700), font=2)
          
          if(input$TP) {polygon(c(1,1,2,2),c(3,4,4,3), col=TP_col)}
          if(input$FP) {polygon(c(2,2,3,3),c(3,4,4,3), col=FP_col)}
          if(input$FN) {polygon(c(1,1,2,2),c(2,3,3,2), col=FN_col)}
          if(input$TN) {polygon(c(2,2,3,3),c(2,3,3,2), col=TN_col)}
          
          text(1.6,3.5, round(TP_POP()), cex=1.8*(width/700), col="blue")
          text(2.6,3.5, round(FP_POP()), cex=1.8*(width/700), col="blue")
          text(1.6,2.5, round(FN_POP()), cex=1.8*(width/700), col="blue")
          text(2.6,2.5, round(TN_POP()), cex=1.8*(width/700), col="blue")
          
          rasterImage(gmanr,2.1,3.1,2.32,3.9, interpolate=F)
          rasterImage(gmang,2.1,2.1,2.32,2.9, interpolate=F)
          rasterImage(rmang,1.1,2.1,1.32,2.9, interpolate=F)
          rasterImage(rmanr,1.1,3.1,1.32,3.9, interpolate=F)
          
          text(1.5,1.8,"Sensitivity", cex=1.2*(width/700), font=2, col="dark red")
          text(1.1,1.2, "=", cex=1.3*(width/700))
          text(1.5,1.4, round(TP_POP()), cex=1.2*(width/700), col="blue")
          text(1.32,1.0, round(TP_POP()), cex=1.2*(width/700), col="blue")
          text(1.5,1.0, "+", cex=1.2*(width/700))
          text(1.68,1.0, round(FN_POP()), cex=1.2*(width/700), col="blue")
          lines(x=c(1.2,1.8), y=c(1.2,1.2))
          text(1.1,0.5, "=", cex=1.3*(width/700))
          text(1.3,0.5, round((TP_POP()/(TP_POP()+FN_POP()))*100), cex=1.5*(width/700), col="blue")
          text(1.45,0.5, "%", cex=1.5*(width/700))
   
          text(2.5,1.8,"Specificity", cex=1.2*(width/700), font=2, col="dark green")
          text(2.1,1.2, "=", cex=1.3*(width/700))
          text(2.5,1.4, round(TN_POP()), cex=1.2*(width/700), col="blue")
          text(2.32,1.0, round(TN_POP()), cex=1.2*(width/700), col="blue")
          text(2.5,1.0, "+", cex=1.2*(width/700))
          text(2.68,1.0, round(FP_POP()), cex=1.2*(width/700), col="blue")
          lines(x=c(2.2,2.8), y=c(1.2,1.2))
          text(2.1,0.5, "=", cex=1.3*(width/700))
          text(2.3,0.5, round((TN_POP()/(TN_POP()+FP_POP()))*100), cex=1.5*(width/700), col="blue")
          text(2.45,0.5, "%", cex=1.5*(width/700))
          
          text(3.4,3.65,"Positive", cex=1.2*(width/700), font=2)
          
          
          text(3,3.35,"Predicted Value", cex=1.2*(width/700), font=2, pos=4)
          text(4.0,3.5, "=", cex=1.3*(width/700))
          text(4.3,3.75, round(TP_POP()), cex=1.2*(width/700), col="blue")
          text(4.2,3.25, round(TP_POP()), cex=1.2*(width/700), col="blue")
          text(4.35,3.25, "+", cex=1.2*(width/700))
          text(4.5,3.25, round(FP_POP()), cex=1.2*(width/700), col="blue")
          lines(x=c(4.1,4.55), y=c(3.5,3.5))
          text(4.7,3.5, "=", cex=1.3*(width/700))
          text(4.85,3.5, round((TP_POP()/(TP_POP()+FP_POP()))*100), cex=1.5*(width/700), col="blue")
          text(5.0,3.5, "%", cex=1.5*(width/700))
          
          
          text(3.4,2.65,"Negative", cex=1.2*(width/700), font=2)
          text(3,2.35,"Predicted Value", cex=1.2*(width/700), font=2, pos=4)
          text(4.0,2.5, "=", cex=1.3*(width/700))
          text(4.3,2.75, round(TN_POP()), cex=1.2*(width/700), col="blue")
          text(4.2,2.25, round(TN_POP()), cex=1.2*(width/700), col="blue")
          text(4.35,2.25, "+", cex=1.2)
          text(4.5,2.25, round(FN_POP()), cex=1.2*(width/700), col="blue")
          lines(x=c(4.1,4.55), y=c(2.5,2.5))
          text(4.7,2.5, "=", cex=1.3*(width/700))
          text(4.85,2.5, round((TN_POP()/(TN_POP()+FN_POP()))*100), cex=1.5*(width/700), col="blue")
          text(5.00,2.5, "%", cex=1.5*(width/700))
          
          text(3.8, 1.4, "Total number of patients", cex=1.2*(width/700))
          text(3.8, 1.15, "correctly diagnosed", cex=1.2*(width/700))
          text(4.5, 1.28, "=", cex=1.5*(width/700))
          text(4.65, 1.28, round(TP_POP()), cex=1.2*(width/700), col="blue")
          text(4.8, 1.28, "+", cex=1.2*(width/700))
          text(4.93, 1.28, round(TN_POP()), cex=1.2*(width/700), col="blue")
          text(4.5, 0.9, "=", cex=1.7*(width/700))
          text(4.7, 0.9, round(TN_POP()+TP_POP()), cex=1.5*(width/700), col="blue")
          
      })
      
      
      if(input$pType == 'Cp'){
        
        withProgress(message = 'Making plot', value = 0, {
          # Number of times we'll go through the loop
          n <- 10
          
          for (i in 1:n) {
        
        #######################################################
        ## Simple tree diagram v1 ###
        #######################################################
        
        ## Posisbly could have used a package like DiagrammeR for tree
        ## but it seemed so simple probably quicker to do bespoke
        
         par(mar=c(0,0,0,0))
          plot(-1:6,-1:6,type="n", xlim=c(0.3,4.7), ylim=c(-1,6), xlab="",
               ylab="", axes=F)
          
        ## Highlighting TN, TP, FN & FP
          
        ## BUG: The below circles dont update properly when the screen size is resized..
          
          if(input$TP) { draw.circle(1,1.1,0.46,nv=50, col=TP_col, lty=0)}
          
          if(input$FP) { draw.circle(2,1.1,0.46,nv=50, col=FP_col, lty=0)}
          
          if(input$FN) { draw.circle(3,1.1,0.46,nv=50, col=FN_col, lty=0)}
          
          if(input$TN) {  draw.circle(4,1.2,0.46,nv=50, col=TN_col, lty=0)}
          
    
          text(2.5,5.2,"1000 Patients", cex=1.4)
          
## Seems very difficult to get text of different colours with reactive
## expressions in the same string. So reactives put on separate lines to
## stop them clashing on resize of screen
          
          text(1.5,3.75,labels=bquote(paste(.(round(TP_POP()+FP_POP())))), cex=1.2, col="blue")
         text(3.5,3.75,labels=bquote(paste(.(round(FN_POP()+TN_POP())))), cex=1.2, col="blue")
          
          text(1.5,3.45,"test +ve", cex=1.2)
          text(3.5,3.45,"test -ve", cex=1.2)
          
          
          text(1,2.1,labels=bquote(paste(.(round(TP_POP())))), cex=1.2, col="blue")
          text(1,1.8," are diseased", cex=1.2)
          text(1,1.5,"and test +ve", cex=1.2)
          
         text(2,2.1,labels=bquote(paste(.(round(FP_POP())))), cex=1.2, col="blue")
         text(2,1.8," are not diseased", cex=1.2)
         text(2,1.5,"but test +ve", cex=1.2)
          
           text(3,2.1,labels=bquote(paste(.(round(FN_POP())))), cex=1.2, col="blue")
           text(3,1.8, " are diseased", cex=1.2)
           text(3,1.5,"but test -ve", cex=1.2)
           
           text(4,2.1,labels=bquote(paste(.(round(TN_POP())))), cex=1.2, col="blue")
           text(4,1.8," are not diseased", cex=1.2)
           text(4.0,1.5,"and test -ve", cex=1.2)
           
          ax<-c(2.2,2.8,1.4,1.6,3.4,3.6) 
          ay<-c(4.8,4.8,3.2,3.2,3.2,3.2)
          axx<-c(1.6,3.4,1.1,1.9,3.1,3.9)
          ayy<-c(3.9,3.9,2.3,2.3,2.3,2.3)
          
          for (i in(1:6)) {
            arrows(x0=ax[i],y0=ay[i], x1=axx[i],y1=ayy[i], lwd=2) }
          
          ## Could add reactive colour background for TN, FN, FP, TP to this plot
          
          rasterImage(rmanr,0.9,-0.5,1.1,1.2)
          rasterImage(gmanr,1.9,-0.5,2.1,1.2)
          rasterImage(rmang,2.9,-0.5,3.1,1.2)
          rasterImage(gmang,3.9,-0.5,4.1,1.2)
          
          
          incProgress(1/n, detail = paste("Doing part", i))
         
          }
        })
          
          
        }
        
     
      if(input$pType == 'Dp'){ 
      
        withProgress(message = 'Making plot', value = 0, {
          # Number of times we'll go through the loop
          n <- 10
          
          for (i in 1:n) {
        
        
        #######################################################
        ## Simple tree diagram v2 ###
        #######################################################
        
         par(mar=c(0,0,0,0))
          plot(-1:6,-1:6,type="n", xlim=c(0.3,4.7), ylim=c(-1,6), xlab="",
               ylab="", axes=F)
          
          if(input$TP) { draw.circle(1,1.1,0.46,nv=50, col=TP_col, lty=0)}
          
          if(input$FN) { draw.circle(2,1.1,0.46,nv=50, col=FN_col, lty=0)}
          
          if(input$FP) { draw.circle(3,1.1,0.46,nv=50, col=FP_col, lty=0)}
          
          if(input$TN) {  draw.circle(4,1.1,0.46,nv=50, col=TN_col, lty=0)}
          
          
          text(2.5,5.2,"1000 Patients", cex=1.4)
          
          
            text(1.5,3.75,labels=bquote(paste(.(round(TP_POP()+FN_POP())))), cex=1.2, col="blue")
            text(3.5,3.75,labels=bquote(paste(.(round(FP_POP()+TN_POP())))), cex=1.2, col="blue")
            
            text(1.5,3.45,"are diseased", cex=1.2)
            text(3.5,3.45,"are healthy", cex=1.2)
     
            text(1,2.1,labels=bquote(paste(.(round(TP_POP())))), cex=1.2, col="blue")
            text(1,1.8," are diseased", cex=1.2)
            text(1,1.5,"and test +ve", cex=1.2)
            
            text(2,2.1,labels=bquote(paste(.(round(FN_POP())))), cex=1.2, col="blue")
            text(2,1.8," are diseased", cex=1.2)
            text(2,1.5,"but test -ve", cex=1.2)
            
            text(3,2.1,labels=bquote(paste(.(round(FP_POP())))), cex=1.2, col="blue")
            text(3,1.8, " are not diseased", cex=1.2)
            text(3,1.5,"but test +ve", cex=1.2)
            
            text(4,2.1,labels=bquote(paste(.(round(TN_POP())))), cex=1.2, col="blue")
            text(4,1.8," are not diseased", cex=1.2)
            text(4.0,1.5,"and test -ve", cex=1.2)
           
             ax<-c(2.2,2.8,1.4,1.6,3.4,3.6) 
             ay<-c(4.8,4.8,3.2,3.2,3.2,3.2)
             axx<-c(1.6,3.4,1.1,1.9,3.1,3.9)
             ayy<-c(3.9,3.9,2.3,2.3,2.3,2.3)
           
          for (i in(1:6)) {
            arrows(x0=ax[i],y0=ay[i], x1=axx[i],y1=ayy[i], lwd=2) }
          
          ## Could add reactive colour background for TN, FN, FP, TP to this plot
          
          rasterImage(rmanr,0.9,-0.5,1.1,1.2)
          rasterImage(rmang,1.9,-0.5,2.1,1.2)
          rasterImage(gmanr,2.9,-0.5,3.1,1.2)
          rasterImage(gmang,3.9,-0.5,4.1,1.2)
          
          incProgress(1/n, detail = paste("Doing part", i))
          
         
          }
        })
        
          
          
          
          
      }
      
         
    })
     
    ###############################
    ###  PV PLOT BY PREVALENCE  ###
    ###############################
    
    output$pvplot <- renderPlot({
      
      
      withProgress(message = 'Making plot', value = 0, {
        # Number of times we'll go through the loop
        n <- 10
        
        for (i in 1:n) {
      
      
     widths  <- session$clientData$output_pvplot_width
     widthr <- min(widths, 400)
    cex.w <- widthr/475
      
  
 # Calculating points for whole ppv and npv curves for current sens and spec
    
    seq_prev<-seq(0.001,1,0.01)
    seq_TP <- (TP_PCT()/100)*seq_prev
    seq_FP <- (1-(TN_PCT()/100))*(1-seq_prev)
    seq_ppv <-seq_TP/(seq_TP+seq_FP)
    
    seq_TN <- (TN_PCT()/100)*(1-seq_prev)
    seq_FN <- (1-(TP_PCT()/100))*seq_prev
    seq_npv <-seq_TN/(seq_TN+seq_FN) 

    par(mar=c(3.1, 4.1, 4.1, 11.1), xpd=TRUE)
     plot(seq_prev, seq_ppv, col="darkred", ylab="", xlab="", 
          type="l",lwd=2, cex=1.3*cex.w, main="How PPV & NPV Vary With Prevalence",
           cex.main=.9*cex.w, cex.axis=.8*cex.w,  xlim=c(0,1), 
          ylim=c(0,1), las=1, at=c(0,.2,.4,.6,.8,1), 
          labels=c("0","20","40","60","80","100" ))
      
     lines(x=seq_prev, y=seq_npv, type="l", lwd=2, col="darkgreen")
  
     
     prevlab <- paste(PREVALENCE(),"%", sep="")
     
     if (PREVALENCE()/100 > 0.9)  placex = PREVALENCE()/100 -0.06
     else placex = PREVALENCE()/100 + 0.05
     
     text(placex, 0.02, prevlab)
     
     title(ylab="Predictive Value (%)", mgp=c(2,1,0),cex.lab=1*cex.w)
     title(xlab="Prevalence of Disease (%)", mgp=c(2,1,0),cex.lab=1*cex.w)
      
    points( PREVALENCE()/100, (TP_POP()/(TP_POP()+FP_POP())), col="red", 
            lwd=2, bg="dark red", cex=3*cex.w, pch=23)
     
    points( PREVALENCE()/100, (TN_POP()/(TN_POP()+FN_POP())) , col="green",  lwd=2,
           bg="dark green", cex=3*cex.w, pch=23)
    
      
      col_legendp <- c("darkred", "darkgreen", "black","red","green")
      leg_txtp <- c("PPV curve", "NPV curve", "Current prevalence",
                    "Current PPV", "Current NPV")
      pch_legendp <- c(NA,NA, NA, pch=23, pch=23)
      
     
      legend("topright", inset=c(0,.2), leg_txtp, lty=c(1,1,3), col=col_legendp, 
           cex=0.7*cex.w, bty="n", pch=pch_legendp, merge=T, lwd=c(2,2,1,NA,NA), pt.bg=c(NA,NA,NA,"darkred", "darkgreen"), 
           pt.cex=c(NA,NA,NA,1.5,1.5))
      
      par(xpd=FALSE)
      abline(v=PREVALENCE()/100, lty = 3)
      
      
      incProgress(1/n, detail = paste("Doing part", i))
      
     
        }
      })
      
      

  }) 
    
    
    output$formulae <- renderPlot({ 
      
      widths  <- session$clientData$output_formulae_width
      width <- min(widths, 700)
      
      ###################################################################
      ## 2 x 2 contingency table with formulae   #######################
      ###################################################################
      
      withProgress(message = 'Making plot', value = 0, {
        # Number of times we'll go through the loop
        n <- 10
        
        for (i in 1:n) {
      
      
      
      par(mar=c(0,0,0,0))
      plot(1:8,1:8,type="n", xlim=c(0.5,7.7), ylim=c(-1,5.1)
           , xlab="",ylab="", axes=F)
      x=c(1,2,3)
      y=c(2,3,4)
      
      for (i in 1:3){
        lines(x=c(x[i],x[i]),y=c(2,4))
        lines(x=c(1,3),y=c(y[i],y[i]))}
      text(2,4.8,"True Status", cex=1.4*(width/700), font=2)
      text(1.5,4.3,"Diseased", cex=1.2*(width/700), font=2)
      text(2.5,4.3,"Healthy", cex=1.2*(width/700), font=2)
      text(.6,3,"Test", cex=1.4*(width/700), font=2)
      text(.85,2.5,"-", cex=2*(width/700), font=2)
      text(.85,3.5,"+", cex=2*(width/700), font=2)
      
      if(input$TP) {polygon(c(1,1,2,2),c(3,4,4,3), col=TP_col)}
      if(input$FP) {polygon(c(2,2,3,3),c(3,4,4,3), col=FP_col)}
      if(input$FN) {polygon(c(1,1,2,2),c(2,3,3,2), col=FN_col)}
      if(input$TN) {polygon(c(2,2,3,3),c(2,3,3,2), col=TN_col)}
      
      text(1.6,3.5, "TP", cex=1.8*(width/700), col="blue")
      text(2.6,3.5, "FP", cex=1.8*(width/700), col="blue")
      text(1.6,2.5, "FN", cex=1.8*(width/700), col="blue")
      text(2.6,2.5, "TN", cex=1.8*(width/700), col="blue")
      
      rasterImage(gmanr,2.1,3.1,2.32,3.9, interpolate=F)
      rasterImage(gmang,2.1,2.1,2.32,2.9, interpolate=F)
      rasterImage(rmang,1.1,2.1,1.32,2.9, interpolate=F)
      rasterImage(rmanr,1.1,3.1,1.32,3.9, interpolate=F)
      
      text(1.5,1.8,"Total", cex=1.2*(width/700), font=2)
      text(1.5,1.5,"Diseased:", cex=1.2*(width/700), font=2)
      text(1.32,1.2, "TP", cex=1.2*(width/700), col="blue")
      text(1.5,1.2, "+", cex=1.2*(width/700))
      text(1.68,1.2,"FN", cex=1.2*(width/700), col="blue")
      
      text(2.5,1.8,"Total", cex=1.2*(width/700), font=2)
      text(2.5,1.5,"Healthy:", cex=1.2*(width/700), font=2)
      text(2.32,1.2, "FP", cex=1.2*(width/700), col="blue")
      text(2.5,1.2, "+", cex=1.2*(width/700))
      text(2.68,1.2, "TN", cex=1.2*(width/700), col="blue")
      
      text(1.5,0.2,"Sensitivity:", cex=1.2*(width/700), font=2, col="dark red")
      text(1.5,-.2, "TP", cex=1.2*(width/700), col="blue")
      text(1.48,-.6, "Total Diseased", cex=1.0*(width/700))
      lines(x=c(1.0,1.9), y=c(-.4,-.4))
      
      text(2.5,.2,"Specificity:", cex=1.2*(width/700), font=2, col="dark green")
     text(2.5,-.2, "TN", cex=1.2*(width/700), col="blue")
      text(2.48,-.6, "Total Healthy", cex=1.0*(width/700))
      lines(x=c(2.0,2.9), y=c(-.4,-.4))
   
      
      text(3.5,3.65,"Total Tesing", cex=1.2*(width/700), font=2)
      text(3,3.35,"Positive:", cex=1.2*(width/700), font=2, pos=4)
      text(4.15,3.5, "TP", cex=1.2*(width/700), col="blue")
      text(4.3,3.5, "+", cex=1.2*(width/700))
      text(4.45,3.5, "FP", cex=1.2*(width/700), col="blue")
    
      text(3.5,2.65,"Total Tesing", cex=1.2*(width/700), font=2)
      text(3,2.35,"Negative:", cex=1.2*(width/700), font=2, pos=4)
      text(4.15,2.5, "FN", cex=1.2*(width/700), col="blue")
      text(4.3,2.5, "+", cex=1.2*(width/700))
      text(4.45,2.5, "TN", cex=1.2*(width/700), col="blue")
      
      
      text(5.26,3.65,"Positive", cex=1.2*(width/700), font=2)
      text(4.85,3.35,"Predicted Value:", cex=1.2*(width/700), font=2, pos=4)
      text(6.95,3.75, "TP", cex=1.2*(width/700), col="blue")
      text(7,3.25, "Total Testing Positive", cex=1.0*(width/700))
     # text(6.6,3.25, "+", cex=1.2*(width/700))
     # text(6.75,3.25, "FP", cex=1.2*(width/700), col="blue")
      lines(x=c(6.3,7.7), y=c(3.5,3.5))
      
      
      text(5.3,2.65,"Negative", cex=1.2*(width/700), font=2)
      text(4.85,2.35,"Predicted Value:", cex=1.2*(width/700), font=2, pos=4)
      text(6.95,2.75, "TN", cex=1.2*(width/700), col="blue")
      text(7,2.25, "Total Testing Negative", cex=1.0*(width/700))
      lines(x=c(6.3,7.7), y=c(2.5,2.5))

      
      incProgress(1/n, detail = paste("Doing part", i))
      
     
     
        }
      })
      
      
      
    }) 
    
  
})
