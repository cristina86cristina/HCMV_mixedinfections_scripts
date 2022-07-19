for n_haplo in {2..2}; do
    echo $n_haplo
sample=R02-00180
mkdir /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold
mkdir /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/
mkdir /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster
mkdir /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster/error
mkdir /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster/out

mydir=/cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/
filelist=/cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/samples.txt
log_file=nhaplo_${n_haplo}_harold_decideparameters.log
results=nhaplo_${n_haplo}_results

echo "


#!/bin/bash -l
#$ -S /bin/bash
#$ -o /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster/out
#$ -e /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster/error
#$ -l h_rt=12:00:00
#$ -l tmem=20.9G,h_vmem=20.9G
#$ -N  haplo_${n_haplo}
#$ -wd  /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection
#$ -V
#$ -R y

#SCRIPT HAPLO RECONSTRUCTION

##STEP1- HAROLD LEGACY 
#even before step1, need to decide how many haplotypes: run harold with several n of haplo and get elbow number

source /share/apps/anaconda/bin/activate harold
cd ${mydir}//

java -Xmx10g -Xms10g -jar /SAN/breuerlab/Juanita_Virus/Apr2020-Harold-Refinement-Diversity/jar/Cluster_RG/dist/Cluster_RG.jar --count-file ${filelist} --haplotypes ${n_haplo} --alpha-frac 0.1 --gamma-cache 10000 -H -L --threads 1 -p ${mydir}/${results} --seed 12345 > ${mydir}/${log_file}



" > /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster/nhaplo_${n_haplo}_getparameters.sh

     qsub /cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/harold/nhaplo/cluster/nhaplo_${n_haplo}_getparameters.sh

done



