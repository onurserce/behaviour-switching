#!/bin/bash
#SBATCH -a 41-48:7
#SBATCH -p gpu
#SBATCH -t 09:00:00
#SBATCH -x dge[001-015],dte[001-010]
#SBATCH -G 1
#SBATCH --mem=80G
#SBATCH --mail-type=END
#SBATCH --mail-user=serce@neuro.mpg.de
#SBATCH -o job_array_analyse_videos_except_gtx980_%A_%a.out

module purge
module load cuda/11.1.0
module load cudnn/8.0.4.30-11.1-linux-x64

source "$HOME"/.bashrc
source activate DLC-GPU

videofolder="$HOME"/isopreteranol
shuffleindex=5
snapshotindex=11
gputouse=$CUDA_VISIBLE_DEVICES

nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits

# $SLURM_ARRAY_TASK_ID will be used as an index to a python script
python eMotion/worker_scripts/dlc_analyse_videos_jobarray.py "$shuffleindex" "$snapshotindex" "$videofolder" "$SLURM_ARRAY_TASK_ID" "$gputouse"

#Manually edit:
#slurm parameters: -a -t
#varibles: videofolder
