# loading the appropriate libraries
library(ggplot2)
library(webr)
library(dplyr)

# loading the dataset
data <- as.data.frame(Titanic)
head(data)
tail(data)

# Building a table with the data for the plot
PD = data %>% group_by(Class, Survived) %>% summarise(n = sum(Freq))
print(PD)

# STandard Pie-Donut chart by Class
PieDonut(PD, aes(Class, Survived, count=n), title = "Titanic: Survival by Class")


# Standard Pie-Donut chart by Class + Percentage
PieDonut(PD, aes(Class, Survived, count=n), title = "Titanic: Survival by Class",
         ratioByGroup = FALSE)


# Pie-Donut chart by Survival + Percentage
PieDonut(PD, aes(Survived, Class, count=n), title = "Titanic: Survival by Class")


# Exploding Pie-Donut chart
PieDonut(PD, aes(Survived, Class, count=n), title = "Titanic: Survival by Class",
         explode = 2)


# Exploding the Donut part of the chart
PieDonut(PD, aes(Survived, Class, count=n), title = "Titanic: Survival by Class",
         explode = 2, explodeDonut=TRUE)


# Controlling the radius
PieDonut(PD, aes(Survived, Class, count=n), title = "Titanic: Survival by Class",
         r0 = 0)

PieDonut(PD, aes(Survived, Class, count=n), title = "Titanic: Survival by Class",
         r0 = 0.45, r1 = 0.9)








# ------------------ My DATA -------------------------#
PD = readxl::read_xlsx("virus.xlsx")
colnames(PD) = c("V_Families","V_Species","Compounds")
PieDonut(PD, aes(V_Species, V_Families, count=Compounds), title = "Titanic: Survival by Class")
PieDonut(PD, aes(V_Species, V_Families, count=Compounds), title = "Titanic: Survival by Class",
         explode = 2, explodeDonut=TRUE)
?Pie
