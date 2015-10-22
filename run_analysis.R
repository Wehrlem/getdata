#Load the needed Library's
library(data.table)
library(plyr)

#Load and merge the training and the test sets to create one data set
all.x <- rbind(read.table("data/test/X_test.txt"),read.table("data/train/X_train.txt"))
all.y <- rbind(read.table("data/test/y_test.txt"), read.table("data/train/y_train.txt"))
all.s <- rbind(read.table("data/test/subject_test.txt"),read.table("data/train/subject_train.txt"))
all.f<-read.table("data/features.txt")
all.a <- read.table("data/activity_labels.txt")

#Extracts only the measurements on the mean and standard deviation for each measurement. 
cols.m.s <- c(grep("-std()",all.f[,2],fixed=TRUE), grep("-mean()",all.f[,2],fixed=TRUE))
all.x <- all.x[,cols.m.s]

#Define the names
names(all.x)<-all.f[,2][cols.m.s]
names(all.y) <- 'Activity'
names(all.s) <- 'Subject'

# Combine everthing together
all <- cbind(all.s,all.y, all.x)

# Aggregate by mean
data <- aggregate( all, by=list(Subject=all$Subject, Activity=all$Activity), FUN= "mean" )

# Remove cols 3 and 4 
tidydata <- subset(data, select = -c(3,4) ) 

# Add labels to activity
tidydata$Activity<-sapply(tidydata$Activity, function(x) { all.a[,2][x] })
head(tidydata)
# Write the textfile
write.table(tidydata, "tidy.txt", row.names = FALSE)

all.x <- all.x[,cols.m.s]

#Define the names
names(all.x)<-all.f[,2][cols.m.s]
names(all.y) <- 'Activity'
names(all.s) <- 'Subject'

# Combine everthing together
all <- cbind(all.s,all.y, all.x)

# Aggregate by mean
data <- aggregate( all, by=list(Subject=all$Subject, Activity=all$Activity), FUN= "mean" )

# Remove cols 3 and 4 
tidydata <- subset(data, select = -c(3,4) ) 

# Add labels to activity
tidydata$Activity<-sapply(tidydata$Activity, function(x) { all.a[,2][x] })

# Write the textfile
write.table(tidydata, "tidy.txt", row.names = FALSE)