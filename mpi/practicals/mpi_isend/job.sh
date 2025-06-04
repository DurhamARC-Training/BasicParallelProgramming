#!/bin/bash
#SBATCH --job-name="mpi_isend"
#SBATCH -o %A.out
#SBATCH -e %A.err
#SBATCH -p test.q
#SBATCH -t 00:05:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4

module purge
module load intel/2020.4
module load intelmpi/intel/2019.6
mpirun -np 4 ./mpi_isend

