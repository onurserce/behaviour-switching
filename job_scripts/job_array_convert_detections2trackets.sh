#!/bin/bash
#SBATCH -a 0-63
#SBATCH -t 2:00:00
#SBATCH --qos=short
#SBATCH -c 4
#SBATCH --mem=80G
#SBATCH --mail-type=END
#SBATCH --mail-user=serce@neuro.mpg.de
#SBATCH -o job_array_convert_detections2tracklets_%A_%a.out

module purge
#module load cuda/11.1.0
#module load cudnn/8.0.4.30-11.1-linux-x64

source "$HOME"/.bashrc
source activate DLC-GPU

videofolder="$HOME"/isopreteranol
shuffleindex=${1?Error: no shuffleindex given}
snapshotindex=${2?Error: no snapshotindex given}

# $SLURM_ARRAY_TASK_ID will be used as an index to a python script
python eMotion/worker_scripts/dlc_convert_detections2tracklets.py "$shuffleindex" "$snapshotindex" "$videofolder" "$SLURM_ARRAY_TASK_ID"

#Manually edit:
#slurm parameters: -a -t
#varibles: videofolder
