#!/bin/bash  
#SBATCH --nodes=1   
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16                # uses 1 compute core per task
#SBATCH --time=2:00:00
#SBATCH --mem=16GB
#SBATCH --output=trainyoloV5.out
#SBATCH --mail-type=END
#SBATCH --mail-user=lin.y@nyu.edu
#SBATCH --gres=gpu:v100:2

conda activate torch

python train.py --img 640 --data ../Mask/data.yaml --weights yolov5x.pt
