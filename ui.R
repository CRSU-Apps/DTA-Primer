
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyjs)
library(png)
library(plotrix)

## Images seem to need readin in both ui and server files

rmanr<-readPNG('./www/rmanr.png')
rmang<-readPNG('./www/rmang.png')
gmang<-readPNG('./www/gmang.png')
gmanr<-readPNG('./www/gmanr.png')

shinyUI(fluidPage(
  useShinyjs(),
  
# Application title
titlePanel("Quantifying Diagnostic Test Accuracy: An Interactive Primer (v1.0)"),

# Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      tags$head(includeCSS('www/style.css')),
      
   
      
## Rather than change the mean and sd by sliders, it would be good if you could 
## click directly on a little distribution plot to drag to change mean / sd etc
      
      sliderInput("mean_healthy",
                  "Mean test value for healthy:",
                  min = 15,
                  max = 25,
                  value = 17, step=0.5),
      
      sliderInput("sd_healthy",
                  "Standard deviation of test values for healthy:",
                  min = 0.5,
                  max = 6,
                  value = 3),
  
## It would be nice if you could colour code the input, but there does not seem to be
## a way of colour coding(?)
      
      sliderInput("mean_diseased",
                  "Mean test value for diseased:",
                  min = 15,
                  max = 25,
                  value = 22, step=0.5),

## ** Is there a way of saying diseased must have a higher mean response than the 
## ** healthy dynamically - i.e. one silder's limit is a function of the other slider
## ** Not pursued here because it would probabaly be confusing

      sliderInput("sd_diseased",
                  "Standard deviation of test values for diseased:",
                  min = 0.5,
                  max = 6,
                  value = 3),

    sliderInput("threshold",
            "Test threshold: above which defines disease diagnosis by test",
            min = 0,
            max = 40,
            value = 20, step=1, animate = TRUE, 
            animationOptions(interval = 500, playButton = TRUE, 
                             pauseButton = TRUE)),

 
######## Below tick boxes are put in using tags to allow the image to be attached 
######## to them

tags$i("Click on the buttons below to change highlighted related selections accross plots"),

tags$div(class="form-group shiny-input-container",
  tags$div(class="checkbox",
  tags$label(tags$input(id="TP", type="checkbox", checked="checked"),
          tags$img(src='rmanr.png', height=40,
    tags$span("True Positive Fraction (Sensitivity) & Number TP")
       )
    ))),
 
tags$div(class="form-group shiny-input-container",
         tags$div(class="checkbox",
                  tags$label(tags$input(id="FN", type="checkbox"),
                             tags$img(src='rmang.png', height=40,
                                      tags$span("False Negative Fraction (1 - Sensitivity) & Number FN")
                             )
                  ))),


tags$div(class="form-group shiny-input-container",
         tags$div(class="checkbox",
                  tags$label(tags$input(id="TN", type="checkbox", checked="checked"),
                             tags$img(src='gmang.png', height=40,
                                      tags$span("True Negative Fraction (Specificity) & Number TN")
                             )
                  ))),


tags$div(class="form-group shiny-input-container",
         tags$div(class="checkbox",
                  tags$label(tags$input(id="FP", type="checkbox"),
                             tags$img(src='gmanr.png', height=40,
                                      tags$span("False Positive Fraction (1- Specificity) & Number FP")
                             )
                  ))),

sliderInput("prevalence",
            "Prevalence: % of tested population with disease (does not affect Test Accuracy tab)",
            min = 1,
            max = 99,
            value = 50, step=2, animate = TRUE, 
            animationOptions(interval = 10, playButton = TRUE, 
                             pauseButton = TRUE)),

br(),br(), br()



, width=4),


    mainPanel(
      
      
      tabsetPanel(
        tabPanel("Test Accuracy", 
                 
                 fluidRow(
                   column(10, offset=1,
                   
                   
                   ## How to hide / show explanation text - #########
                   actionButton("e1", "Hide/show explanation text"),
                   htmlOutput("expl1"))),
                 
                 
                 fluidRow (
                   column(6, 
                          plotOutput("overlay_threshold")
                         # plotOutput("overlay_threshold", width ="450px", height = "300px")
                   ),
                   column(6,
                          plotOutput("ROCplot")
                         # plotOutput("ROCplot", width = "300px", height = "300px")
                   )
                 ),
                 
                 fluidRow(
                   column(10, offset=1,
                   actionButton("e2", "Hide/show explanation text"),
                   htmlOutput("expl2")
                 )),
                 
                 fluidRow(column(6, 
                                 
                                plotOutput("table.sesp")
                                 
                             #   plotOutput("table.sesp", height = "300px")
                 ),
                 column(5,
                        
                        htmlOutput("threshold_selected"),
                        br(),
                        htmlOutput("percent_tp")
                       
                        
                 ) ), hr()
                 
                 ), 
        
        tabPanel("Prevalence", 
                 fluidRow( column(10, offset=1,
                   
                   tags$hr(),
                   
                   actionButton("e3", "Hide/show explanation text"),
                   htmlOutput("expl3")
                   
                 )),
                 
                 fluidRow(column(10,
                 
                        htmlOutput("tot_posneg"))
                 
                 
                 ),
                 
                 
                 ## Look for R software (or JS ?) to put faces representation in
                 ## https://stackoverflow.com/questions/20673584/visualizing-crosstab-tables-with-a-plot-in-r
                 
                 
                 ### No idea why the below code does not work????
                 
                 # conditionalPanel(condition = "input.Ptype == 'Ap'",
                 #                 plotOutput("tree1")),
                 
                 # conditionalPanel(condition = "input.Ptype == 'Bp'",
                 #                plotOutput("tree2"))
                 
                 
                 #### https://stackoverflow.com/questions/27716261/create-inputselection-to-subset-data-and-radiobuttons-to-choose-plot-type-in-sh?noredirect=1&lq=1
                 #### above website probably has the answer without using conditional panels ....
                 #)
                 #,
                 
                 fluidRow(column(9,
                                 
                                 plotOutput("Bp")),
                                 
                                 #   plotOutput("Bp", width ="700px", height = "400px")),
                          
                          (column(3, 
                                  htmlOutput("expl4")
                                  
                          )),
                          tags$hr()
                          
                 ),
                 
                 fluidRow(column(2,
                                 
                                 radioButtons("pType", "Choose format to view expected results of using the test:",
                                              c("Bar Chart" = "Ap",
                                                "Tree 1" = "Cp",
                                                "Tree 2" = "Dp"))
                 ),
                 
                 column(10,
                        
                        plotOutput("optionplot")
                        
                 )
                 ),
                 
                 fluidRow(column(8,
                   plotOutput("pvplot")
                 ),
                 
                column(4,
                       
               br(), br() ,
"The plot on the left indicates how the ", tags$b("positive")," and", tags$b(" negative predicted values")," 
               vary with ", tags$b("prevalence")," (while holding sensitivity and specificity constant).",
br(), br(),
"In practice, the ",tags$b("prevalence")," is a characteristic of the patient population and cannot be altered 
                                 (although tests can be used in sequence and initial tests can affect the disease prevalence in populations receiving latter tests).",
br(), br(),
"You can explore which test thresholds maximise 
                   the number of patients diagnosed correctly for a given", tags$b("prevalence")," and set of test score distributions, but
it is important to appreciate that in reality further factors need to be taken into account when deciding on a test operation threshold.
These include the consequences of false positive and false negative errors, which may 
be very different from each other."
                       )
),
                  fluidRow(column(10, offset=1, 
                   
                   tags$hr() )
              
                 )), 
        tabPanel("Questions",
                 
                 fluidRow(column(10, offset=1,
                   
                   tags$h3("Questions:"),
                   
                   "1.) Set the distribution of test results in the healthy at a mean of 18 and a standard 
                   deviation of 2, and the distribution of test results in the diseased at a mean of 22 and a 
                   standard deviation of 2. If a cut-off threshold value of 19 is used, what sensitivity and specificity 
                   does the test operate at?",
                   
                   actionButton("a9", "Show/hide answer"),
                   actionButton("sl9", "Show slider settings"),
                   span(hidden( htmlOutput("ans9")),  style="color:darkslategrey; font-style:italic"),
                   br(),br(),
                   
                   "2.) Which points does every ROC curve pass through? Describe the threshold 
                   values associated with these points.",
                   
                   actionButton("a1", "Show/hide answer"),
                   span(hidden( htmlOutput("ans1")),  style="color:darkslategrey; font-style:italic"),
                   br(),br(),
                   
                   "3.) Describe how the distributions for test results have to be set, for healthy and diseased patients, 
                   for the ROC curve to follow the (dashed) line of no accuracy?",
                   
                   actionButton("a2", "Show/hide answer"),
                   actionButton("sl2", "Show example settings for no accuracy"),
                   span(hidden( htmlOutput("ans2")), style="color:darkslategrey; font-style:italic"),
                   br(),br(),
                   
                   
                   "4.) What happens to the ROC curve if the mean of the diseased patients test scores is lower than that of the 
                   healthy? What does this imply?", 
                   
                   actionButton("a3", "Show/hide answer"),
                   actionButton("sl3", "Show example settings"),
                   span(hidden( htmlOutput("ans3")),  style="color:darkslategrey; font-style:italic"),
                   br(), br(),
                   
                   
                   "5.) In terms of the distributions for test results, what characteristics generally improve the accuracy of the test? What would the ROC look like for a perfect test?",
                   
                   actionButton("a4", "Show/hide answer"),
                   actionButton("sl1", "Show perfect test settings"),
                   
                   
                   ## Below trying to use a bit of javascript to move page to top after button pressed 
                   ## but not sure I can include javascript like I can raw html.....
                   
                   #tags$button(id='sl1', type='button', class='btn btn-default action-button',
                   #onClick='document.getElementById('top').scrollIntoView()', 'Show perfect test settings'),
                   
                   # <button id="sl1" type="button" class="btn btn-default action-button"></button>
                   
                   
                   span(hidden( htmlOutput("ans4")), style="color:darkslategrey; font-style:italic"),
                   br(), br(),
                   
                   
                   "6.) Set the distribution sliders to any values you wish and make a note of the ROC curve. Now increase
                   the mean of both the healthy and diseased distributions by 3 each. What do you notice about the 
                   resulting ROC curve?",
                   
                   actionButton("a5", "Show/hide answer"),
                   actionButton("sl4", "Example initial settings"),
                   actionButton("sl5", "Example changed settings"),
                   span(hidden( htmlOutput("ans5")),  style="color:darkslategrey; font-style:italic"),
                   br(), br(),
                   
                   "7.) Set the mean of the healthy to 16 with a standard deviation of 3.1, and 
                   the mean of the diseased to 22 with a standard deviation of 3.7 ", 
                   actionButton("sl7", "Or use this button to do it for you"), 
                   " What is the maximum specificity that can be obtained while ensuring sensitivity is at least 80%;
                   what threshold should the test be operated at to obtain this? What is the minimum disease
                   prevalence that a population would have to have to ensure that, on average, at least 800 per 1000 patients would be correctly diagnosed?",
                   
                   actionButton("a8", "Show/hide answer"),
                   actionButton("sl8", "Show correct settings"),
                   
                   span(hidden( htmlOutput("ans8")),  style="color:darkslategrey; font-style:italic"),
                   br(), br(),
                   
                   "8.) (Harder) What feature do ROC curves have when both the distributions for 
                   diseased and healthy test response are set to the same standard deviation?",
                   
                   actionButton("a6", "Show/hide answer"),
                   span(hidden( htmlOutput("ans6")), style="color:darkslategrey; font-style:italic"),
                   br(), br(),
                   
                   "9.) (Advanced) Can you create ROC curves that are not completely concave with a portion
                   of the curve going below the line of no diagnostic effect? (Hint: Make the standard deviation of the healthy
                   group considerably larger than for the diseased group or vice versa.)",
                   
                   actionButton("a7", "Show/hide answer"),
                   actionButton("sl6", "Example settings"),
                   span(hidden( htmlOutput("ans7")), style="color:darkslategrey; font-style:italic"),
                   
                   hr()
                   
                 )
                 
                 
                 
                 )),
     
tabPanel("Formulae",  
         
         fluidRow(column(10, offset=1,
                         tags$h3("Formulae:"),
           
   "The formulae for sensitivity, specificity, positive 
   predicted values and negative predicted values are summarised below."
   )),            
            
   
   fluidRow(column(10, offset=1,
                   
                   plotOutput("formulae"))
         ),
   
   fluidRow(column(5, offset=1,
                br(),
                   "TP : Number of patients who are True Positives", br(), br(),
                   "TN : Number of patients who are True Negatives", br(), br()),
                   
           column(5, 
                  br(),
                  "FN : Number of patients who are False Negatives", br(), br(),
                  "FP : Number of patients who are False Positives", br())
           
           ),
   
   fluidRow(column(10, offset=1,
                   
                   
                   br(), br(), br(),
                   "Calculating the points on the ROC curve:",
                   br(), br(), 
                   
                   withMathJax(),
                   
                   "When the test result values are distributed as follows",
                   br(),
                   
                   helpText("$$test.result.in.diseased \\sim Normal(mean.diseased, sd.diseased^2)$$"),
                   helpText("$$test.result.in.healthy \\sim Normal(mean.healthy, sd.healthy^2)$$"),
                   "For each threshold",
                   br(),
                   
                   helpText("$$sensitivity(threshold.t) = P(test.result.in.diseased > threshold.t)$$"),
                   helpText("$$= \\Phi \\left(\\frac{mean.diseased - threshold.t}{sd.diseased} \\right)$$"),
                   
                   helpText("$$1 - specificity(threshold.t) = P(test.result.in.healthy > threshold.t)$$"),
                   helpText("$$= \\Phi \\left(\\frac{mean.healthy - threshold.t}{sd.healthy}\\right)$$"),
                   
            
                   
                   "Where ",
                   
                   
                   ## Given up trying to get special character for phi to display properly, something to do with incorrect coding on windows
                   
                   tags$img(src='phi2.png', width='16px'),
                   
                   " is the standard normal cumulative distribution function.",
                   br(), br(),
                   
                   
                   "Plotting and connecting pairs of points for sensitivity and 1-specificity (or specificity, dpending on the direction of the x-axis) while varying the test 
                   threshold from low to high (or high to low) will produce the ROC curve."    
   
          )
          )

   ),
      
      tabPanel("Further Resources",  
               
       

        fluidRow(column(10, offset=1,

  tags$h3("Further Resources:"),
  "Excellent ",
  tags$a("interactive animations", href="https://understandinguncertainty.org/screening"), 
  " showing the impact of applying testing methods in realistic screening contexts (requires flash player)
  by Professor David Spiegelhalter's team at Cambridge.",
  br(),br(),
  "A ", tags$a("further video,", href="https://www.youtube.com/watch?v=Ql2jEJ-6e-Y"), 
  " in the same series as the one linked to at the beginning of this explanation, explains the further topic 
  of likelihood ratios and the challanges of interpreting test results for individual patients.",
  br(), br(),
 "Two textbooks giving more extensive and mathematically rigorous coverage of the material presented here:", br(), br(),
  tags$li("Pepe, M.S. The Statistical Evaluation of Medical Tests for Classification and Prediction
  (Oxford Statistical Science Series No.31) Oxford University Press, New York. 2003"),
  br(),
  tags$li("Zhou,X-H., Obuchowski, N.A., McClish, D.K. Statistical Methods in Diagnostic Medicine
  (Wiley Series In Probability And Statistics) John Wiley and Sons, New York. 2002"),
  br(), br(), br(),
  tags$i("This webpage was created by Professor Alex Sutton, University of Leicester. 
         If you have any feedback, please drop me a line. Similarily, if you want to use the webpage as part of your teaching, please let me know so I can guage interest for future projects. If you would like to see the source code for the project, also contact me. E-mail:"),
  tags$a("ajs22@le.ac.uk", href="mailto:ajs22@le.ac.uk"),
hr())),
 

  tabPanel("Thanks To", 
           fluidRow(column(10, offset=1,
  
 tags$h3("Thanks To:"),
  "Bret Victor for his incredibly inspirational ",
  tags$a("website", href="http://worrydream.com/"), 
 " and ",
 tags$a("explorable explanations", href="http://worrydream.com/ExplorableExplanations/"),
 " in particular.",
  br(), br(),
  tags$a("Nicky Case", href="http://ncase.me/"), 
  " for being the current torch bearer of explorable explanations whose ",
  tags$a("website", href="http://explorabl.es/"), 
"motivated me to create this page.",
  br(),
  br(),
  "Professor Joanne Lord for providing me with her slides on diagnostic test accuracy (many years ago!) out of which this webpage grew.",
  br(), br(),
  "Stephanie Hubbard, Dr Suzanne Freeman, Dr Rhiannon Owen, Dr Hayley Jones and Clareece Kerby for very helpful feedback after carefully testing and proofing prototype versions of the website.",
  br(), br(),
  "RStudio for creating the ",
tags$a("Shiny package", href="https://shiny.rstudio.com/"), 
" which was used to build this page.", br(), br(),

"This work was funded in part by the ", 
tags$a("NIHR Complex Review Support Unit", href="http://www.nihrcrsu.org/"), 
" Grant [project number 14/178/29]", br(), br(),
tags$i("Department of Health Disclaimer:
       The views and opinions expressed therein are those of the author and do not necessarily reflect those of the NIHR or the Department of Health."),
br(),
p("THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
                            BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
                            NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
                            DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
           ,
hr()
)


)
))
)

)

)
))
