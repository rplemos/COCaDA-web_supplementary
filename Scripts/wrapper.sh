#!/bin/bash

today=$(date +"%Y-%m-%d")
update_date=$(date +"%b %-d, %Y")
logfile="/hd/cocada-web_update/logs/log_${today}.log"

#conda deactivate
source /home/thor/miniconda3/bin/activate base

# Run each task sequentially, logging output and exiting on failure
echo
echo "----------------------------------------------------"
echo "| Starting sequence at $(date) |"
echo "----------------------------------------------------"
echo

echo "Running pdb_query.py..."
python3 /hd/cocada-web_update/scripts/pdb_query.py >> "$logfile" 2>&1
if [ $? -ne 0 ]; then
  echo "pdb_query.py failed. Exiting."
  exit 1
fi

echo "Running pdb_missing.py..."
python3 /hd/cocada-web_update/scripts/pdb_missing.py >> "$logfile" 2>&1
if [ $? -ne 0 ]; then
  echo "pdb_missing.py failed. Exiting."
  exit 1
fi

echo "Running pdb_download.py..."
python3 /hd/cocada-web_update/scripts/pdb_download.py >> "$logfile" 2>&1
if [ $? -ne 0 ]; then
  echo "pdb_download.py failed. Exiting."
  exit 1
fi

echo "Running COCaDA..."
python3 /home/thor/Rafael/GITHUB/COCaDA-1.5/cocada.py -f /hd/cocada-web_update/new_files/new_files_${today}/*.cif -s -w -m 20 -o /hd/cocada-web_update/outputs_temp/outputs_${today}/ >> "$logfile" 2>&1
if [ $? -ne 0 ]; then
  echo "COCaDA script failed. Exiting."
  exit 1
fi

echo "Copying files..."
/hd/cocada-web_update/scripts/move_files.sh >> "$logfile" 2>&1
if [ $? -ne 0 ]; then
  echo "File copy operation failed. Exiting."
  exit 1
fi

echo "Copying outputs..."
/hd/cocada-web_update/scripts/move_outputs.sh >> "$logfile" 2>&1
if [ $? -ne 0 ];then
  echo "Output copy operation failed. Exiting."
  exit 1
fi

echo "Updating list.csv..."
cat /hd/cocada-web_update/outputs_temp/outputs_${today}/list.csv >> /hd/PDB_outputs/list.csv
if [ $? -ne 0 ];then
  echo "Update operation failed. Exiting."
  exit 1
fi

echo "Updating intra and inter chains..."
num_ids=$(cat /hd/PDB_outputs/list.csv | wc -l)
python3 /hd/cocada-web_update/scripts/inter_intrachain.py /hd/cocada-web_update/new_files/new_files_${today} ${num_ids} ${today} "${update_date}" False
if [ $? -ne 0 ];then
  echo "Intra- and inter chains operation failed. Exiting."
#  exit 1
fi


echo "All tasks completed successfully at $(date)."

