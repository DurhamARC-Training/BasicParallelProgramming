#!/bin/bash
#SBATCH --job-name="mpi_send"
#SBATCH -o %A.out
#SBATCH -e %A.err
#SBATCH -p test.q
#SBATCH -t 00:05:00
#SBATCH -N 1 # number of nodes
#SBATCH -n 10 # number of tasks (MPI ranks)
#SBATCH -c 1 # number of cores per task

module purge
module load gcc openmpi
#module load intel intelmpi

mpirun ./mpi_send
