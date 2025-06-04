#!/bin/bash
#SBATCH --job-name="mpi_bcast"
#SBATCH -o %A.out
#SBATCH -e %A.err
#SBATCH -p test.q
#SBATCH -t 00:05:00
#SBATCH -N 1 # number of nodes
#SBATCH -n 4 # number of tasks (MPI ranks)
#SBATCH -c 4 # number of cores per task

module purge
#module load intel/2021.4
#module load intelmpi/2021.6
module load gcc openmpi

mpirun ./mpi_bcast

