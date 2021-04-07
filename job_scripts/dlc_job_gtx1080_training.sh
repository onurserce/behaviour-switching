#!/bin/bash
#SBATCH -p gpu
#SBATCH -t 16:00:00
#SBATCH -G gtx1080:1
#SBATCH --mail-type=END
#SBATCH --mail-user=serce@neuro.mpg.de
#SBATCH -o dlc_job_gtx1080_training_%J.out


module purge
module load cuda10.0/toolkit/10.0.130
module load cuda10.0/blas/10.0.130
module load cudnn/10.0v7.6.3
source activate behaviour-switching

shuffleindex=${1?Error: no shuffleindex given}
gputouse=$CUDA_VISIBLE_DEVICES

echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits

python behaviour-switching/worker_scripts/dlc_start_training.py "$shuffleindex" "$gputouse"
