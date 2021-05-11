# Simple reaction time as function of stimulus size

Introduction

This is a simple reaction task experiment, inspired by the paper of Berlucci et al. (1971). The task is simple: the participant must press a key as quickly as possible when a stimulus appears on the screen. In their experiment, Berlucci et al. varied the angle of a rectangle stimulus. By contrast, in the present experiment, I vary merely the size of a cross stimulus (holding constant for angle). Participants are, in random order, presented with either a small cross or a large cross appearing on the centre of the screen. The hypothesis for this experiment is that reaction time varies systematically with stimulus size, with the larger stimulus resulting in shorter reaction times. 

Method 

Participants were were recorded multiple times for both types of stimulus size. This is called "within"-participant design - the resulting data were acquired in the same unit under two conditions. Hence, observations in the data set are not independent. For statistical interference, I first do a basic paired T-test for dependent samples. For this test, I compute means for each participants across all trials, grouped by the stimulus condition (small or large target). 

To capture more variance of the data, I then proceed by computing a linear mixed effects model. This model considers ALL trial observations. It accounts for inter-subject variability by using random effects for the subjects and fixed effects for the actual effect of interest, i.e. the stimulus condition. 

I provide visualization graphics for both methods. I also include descriptive graphics. 

How to run the experiment?

The actual experiment is done with 'my_simple-detection-visual-expyriment.py'. Once the code is run, the experiment will be launched. Once the subject completed a run, data will be automatically registered in a subfolder called 'data' in the enviornment where the script is executed. This can be repeated with different participants as much as needed. 

To generate a consise CSV-data frame from the individual '.xpd'-files across the different subjects, I created 'data_frame_generator_across_subjects.py'. IMPORTANT: the file needs to be executed in the same 'data' subfolder in which the individual subject's data files are stored. The code will generate a CSV-file called 'all_reaction_times.csv' in the same environment. [Adding/removing single data files to this CSV file is no problem, just re-run the script and it will update automatically]

Data analysis is run in R. Note that I struggled with the relative path, so unfortunately the R-script, too, needs to be run in the same environment where the 'all_reaction_times.csv' file is stored. I provided a PDF of sample results based on 3 subjects (with a reduced number of trials per subject, i.e. 10 instead of 30)

Thank you for your patience and commitment especially with us beginners in this class! I hope this project corresponds to what you expect, after having changed it last-minute. 