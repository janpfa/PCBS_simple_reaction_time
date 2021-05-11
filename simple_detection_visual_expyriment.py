#! /usr/bin/env python
# Time-stamp: <2021-03-23 19:13:19 christophe@pallier.org>
""" This is a simple reaction-time experiment.

At each trial, a cross is presented at the center of the screen and
the participant must press a key as quickly as possible.
"""

import random
from expyriment import design, control, stimuli

N_TRIALS = 30
MIN_WAIT_TIME = 1000
MAX_WAIT_TIME = 2000
MAX_RESPONSE_DELAY = 2000

exp = design.Experiment(name="Visual Detection", text_size=40)
control.initialize(exp)

target_large = stimuli.FixCross(size=(300, 300), line_width=4)
target_small = stimuli.FixCross(size=(25, 25), line_width=4)
blankscreen = stimuli.BlankScreen()
instructions = stimuli.TextScreen("Instructions",
    f"""From time to time, a cross will appear at the center of screen.


    Your task is to press any key as quickly as possible when you see it (We measure your reaction-time).

    The size of the cross will vary, but your task remains the same. 

    There will be {N_TRIALS} trials in total.

    Press the space bar to start.""")

exp.add_data_variable_names(['trial', 'wait', 'respkey', 'RT', 'target_type'])

def get_randomized_target():
    target_type = [target_large, target_small]
    return(random.choice(target_type))
    

def get_target_type_string(target):
    if target == target_large:
        return("target_large")
    else: 
        return("target_small")


control.start(skip_ready_screen=True)
instructions.present()
exp.keyboard.wait()

for i_trial in range(N_TRIALS):
    blankscreen.present()
    waiting_time = random.randint(MIN_WAIT_TIME, MAX_WAIT_TIME)
    exp.clock.wait(waiting_time)
    target = get_randomized_target()
    target_type = get_target_type_string(target)
    target.present()
    key, rt = exp.keyboard.wait(duration=MAX_RESPONSE_DELAY)
    exp.data.add([i_trial, waiting_time, key, rt, target_type])

control.end()
