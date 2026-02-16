#!/bin/bash
#SBATCH --job-name="helloworld"
#SBATCH -o %A.out
#SBATCH -e %A.err
#SBATCH -p test.q
#SBATCH -t 00:05:00
#SBATCH --nodes=4
#SBATCH --cpus-per-task=1

module purge
#module load intel/2020.4
#module load intelmpi/intel/2019.6
module load gcc
module load openmpi

mpirun ./helloworld
