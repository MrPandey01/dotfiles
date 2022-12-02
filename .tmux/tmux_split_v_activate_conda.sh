#!/bin/sh

current_conda=$CONDA_DEFAULT_ENV

tmux split-window -v -c "#{pane_current_path}"
tmux send-keys "conda activate $current_conda" 'Enter';


