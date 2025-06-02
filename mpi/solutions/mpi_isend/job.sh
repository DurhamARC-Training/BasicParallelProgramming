#!/bin/bash
#SBATCH --job-name="mpi_isend"
#SBATCH -o %A.out
#SBATCH -e %A.err
#SBATCH -p test.q
#SBATCH -t 00:05:00
#SBATCH -N 1 # number of nodes
#SBATCH -n 10 # number of tasks (MPI ranks)
#SBATCH -c 10 # number of cores per task

module purge
module load intel/2021.4
module load intelmpi/2021.6
mpirun ./mpi_isend

