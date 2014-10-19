# file name: CodeBook.md

This data set consists of the columns:

1. Activity
2. Subject
3. 86 columns named like meanOf...

The values of Activity come from the domein: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING and LAYING.

The values of Subject come from the domein of natural numbers in the range 1 upto and including 30.

The values of the meanOf... columns are from the domain of real numbers in the range from and including -1 upto an including 1.

The data set is a result of an experiment carried out with a group of 30 volunteers. Each volunteer is a Subject identified with a number as described above. Each volunteer performed 6 activities identified as an Activity described above. Each volunteer performed each activity several times. Each time a set of measurements where performed. These measuments where processed to form a feature vector for machine learning purposes.

The experiment and measurement processing is further described in the various files in the "Human Activity Recognition Using Smartphones Dataset" that was handed over as input. Those details provide intersting backgroud information but are not needed to understand this data set.

For our purpose a subset of the features were selected. The subset consists of the features with Mean, mean, Std or std in their name. That gives us for each Activity for each Subject for each of those features several measurements. Per Activity, per Subject, per feature the measurements are averaged and represented in this data set as a meanOf. followed by the feature name.
