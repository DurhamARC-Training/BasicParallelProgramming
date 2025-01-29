#!/bin/bash
#SBATCH --job-name="scheduling"
#SBATCH -o %A.out
#SBATCH -e %A.err
#SBATCH -p test.q
#SBATCH -t 00:05:00
#SBATCH -c 4
#SBATCH --nodes=1
module purge

module load gcc

./schedule.exe
