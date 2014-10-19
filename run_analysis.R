# file name: run_analysis.R


# Step 1:
# Merges the training and the test sets to create one data set.

# Create new files for the combination.
# Poor the existing ones in it.

filesToCombine <- c("subject", "X", "y")
dataSets <- c("train", "test")

for (f in filesToCombine) {
  newFileName <- paste(f, ".txt", sep = "")
  file.create(newFileName)

  for (s in dataSets) {
    existingFileName <- paste("UCI HAR Dataset/", s, "/", f, "_", s, ".txt", sep = "")
    file.append(newFileName, existingFileName)
  }

  # Create a variable for it, for later use.
  assign(paste(f, "FileName", sep = ""), newFileName)
}


# Step 2:
# Extracts only the measurements on the mean and standard deviation for each measurement.

# We are given a slightly ambiguous specification.
# To be on the safe side pick any feature with a name matching the regular expression [mM]ean|[sS]td. 

# Get the column numbers and names for all features.
# Take the opportunity to properly name the columns of the data frame.
featuresFileName <- "UCI HAR Dataset/features.txt"
features <-read.table(featuresFileName,
                      header = FALSE,
                      col.names = c("FeatureId", "FeatureName"),
                      colClasses = c("integer", "character")
)

# Build the feature selector.
# A vector of the FeatureId's that need to be extracted.
meanAndStdFeaturesSelector <- grep("[mM]ean|[sS]td", features$FeatureName)

# Build the selector for the columns of the measurement file (X).
# A vector to be used with read.table(colClasses = ) to skip unwanted columns.
meanAndStdFeaturesColumnSelector <- vector(length = dim(features)[1])
meanAndStdFeaturesColumnSelector[] <- "NULL"
meanAndStdFeaturesColumnSelector[meanAndStdFeaturesSelector] <- "numeric"

# The total data set consist of data frames X, y and subject

# Extracts only ...
# Take the opportunity to properly name the columns of the data frame.
X <- read.table(XFileName,
                header = FALSE,
                col.names = features$FeatureName,
                colClasses = meanAndStdFeaturesColumnSelector
)

# Take the opportunity to properly name the columns of the data frame.
y <- read.table(yFileName,
                header = FALSE,
                col.names = c("ActivityId")
)

# Take the opportunity to properly name the columns of the data frame.
subjects <- read.table(subjectFileName,
                       header = FALSE,
                       col.names = c("SubjectId")
)


# Step 3:
# Uses descriptive activity names to name the activities in the data set

# Get the activity numbers and names.
# Take the opportunity to properly name the columns of the data frame.
activitiesFileName <- "UCI HAR Dataset/activity_labels.txt"
activities <- read.table(activitiesFileName,
                         header = FALSE,
                         col.names = c("ActivityId", "ActivityName"),
                         colClasses = c("integer", "character")
)

# Uses descriptive activity names ...
y$Activity <- activities$ActivityName[y$ActivityId]


# Step 4
# Appropriately labels the data set with descriptive variable names.

# This is already consistently done above.


# Step 5
# From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
#
# I assume with "average" the arithmetic mean is meant.
library(stats)
d <- aggregate(X, 
               list(Activity = y$Activity, Subject = subjects$SubjectId),
               mean
)

# Properly name the columns.
# Leave the first two columns alone.
# The rest are a mean of something.
columnNamePrefix <- c(rep("", 2),
                      rep("meanOf.", dim(d)[2] - 2)
)
names(d) <- paste(ColumnNamePrefix, names(d), sep = "")

# Finally ...
write.table(d, "tidy.txt", row.names = FALSE)
