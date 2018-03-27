# the grammar of graphics

# a way of describing "data graphics"

#    language for building graphics

library(ggplot2)
library(mangoTraining)

View(diamonds)
qplot(x = carat, 
      y = price, 
      data = diamonds)

qplot(x = carat, 
      data = diamonds) # gives a histogram

qplot(x = price, 
      data = diamonds)

qplot(x = price, 
      data = diamonds, 
      binwidth = 60)

xRang <- c(0, 35)
yRang <- c(0, 400)

mpgplot <- qplot(x = mpg, 
                 y = hp, 
                 data = mtcars, 
                 main = "Miles per gallon vs Horsepower", 
                 ylab = "Horsepower", 
                 xlab = "Miles per gallon", 
                 ylim = yRang, 
                 xlim = xRang)




# exercise ----------------------------------------------------------------

View(pkData)


# Conc against Time
ex1 <- qplot(x = Time, 
      y = Conc, 
      data = pkData, 
      ylim = c(0,2500), 
      xlab = "Time", 
      ylab = "Concentration", 
      main = "Concentration vs Time from \"pkData\"")

# histogram of Weight from demoData

View(demoData)
hist <- qplot(x = Weight, 
              data = demoData, 
              binwidth = 7)


pdf(file = "./plots/mango.pdf")
ex1; hist
dev.off()



# geoms ------------------------------------------------------------------

qplot(x = factor(cyl), 
      y = mpg, 
      data = mtcars, 
      geom = "boxplot")
grep("^geom", objects("package:ggplot2"), value = TRUE)


qplot(mpg, wt, data = mtcars) + geom_smooth() + geom_rug()



# exercise2 ---------------------------------------------------------------

qplot(x = factor(Sex), 
      y = Height, 
      data = demoData, 
      geom = "boxplot")


a <- rnorm(1000, mean = 0, sd = 1)
qplot(x = a, 
      geom = "density")


qplot(x = Time, 
      y = Conc, 
      data = pkData, 
      geom = "jitter") + geom_smooth(method = "lm", se = FALSE)


# Aesthetics --------------------------------------------------------------

View(quakes)

Fiji <- qplot(x = long, 
              y = lat, 
              data = quakes, 
              size = mag,
              colour = -depth)
Fiji


qplot(mpg, wt, data = mtcars, 
      colour = factor(cyl))

qplot(mpg, wt, data = mtcars, 
      colour = I("blue"), 
      size = I(3))


# exercise3 ---------------------------------------------------------------

qplot(x = Weight, 
      y = Height, 
      data = demoData, 
      colour = factor(Sex), 
      shape = factor(Smokes), 
      size = I(2))

grep("^scale", objects("package:ggplot2"), value = TRUE)


irisplot <- qplot(Sepal.Length, 
                  Sepal.Width, 
                  data = iris, 
                  shape = Species)

irisplot <- irisplot + scale_shape_manual(values = 1:3)



Fiji <- qplot(x = long, 
              y = lat, 
              data = quakes, 
              size = mag,
              alpha = I(0.5),
              colour = -depth)
Fiji <- Fiji + scale_color_continuous("Depth")
Fiji <- Fiji + scale_size_continuous("Magnitude", 
                                     range = c(1,10), 
                                     breaks = c(4:6))
Fiji



qplot(Time, 
      Conc,
      data = pkData, 
      geom = "line", 
      colour = factor(Subject))



# faceting ----------------------------------------------------------------

qplot(mpg, wt, data = mtcars) + facet_grid(am~cyl)

qplot(Time, 
      Conc, 
      data = pkData, 
      geom = "line", 
      group  = factor(Subject)) + facet_wrap(~Subject)


concPlot <- ggplot(data = pkData, 
                   mapping = aes(x = Time, 
                                 y = Conc, 
                                 group = factor(Subject)))

concPlot <- concPlot + geom_line( colour = "red")
concPlot




# advanced examples -------------------------------------------------------

library(dplyr)
mtCopy <- select(mtcars, -cyl)

#

ggplot() + 
  geom_point(data = mtCopy, aes(x = wt, y = mpg), 
             color= "grey65") + 
  geom_point(data = mtcars, aes(x = wt, y = mpg)) + 
  facet_grid( ~ cyl) + 
  ggtitle("MPG vs. weight automobiles \nBy Number of cylinders") + 
  theme_minimal()

thm <- qplot(Height, Weight, data = demoData)
thm <- thm + facet_grid(Sex ~ Smokes)
thm + theme(strip.text.y = element_text(angle = 0), 
            strip.background = element_rect(fill = "orange", 
                                            colour = "grey50"))


ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) + 
  geom_bar(width = 1) # + coord_polar(theta = "y")
