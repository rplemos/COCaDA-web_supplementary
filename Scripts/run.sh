#!/bin/bash

today=$(date +"%Y-%m-%d")

# Activate base environment if not already active
if [ "$CONDA_DEFAULT_ENV" != "base" ]; then
    source /home/thor/miniconda3/etc/profile.d/conda.sh
    conda activate base
fi
echo "Running with Conda environment: $CONDA_DEFAULT_ENV"

/hd/cocada-web_update/scripts/wrapper.sh | tee -a /hd/cocada-web_update/logs/log_${today}.log
echo -e "\nDatabase update complete!\n" | tee -a /hd/cocada-web_update/logs/log_${today}.log
