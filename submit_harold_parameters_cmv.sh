for n_haplo in {2..3}; do
    echo $n_haplo
sample=R02-00189
mydir=/cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}
filelist=/cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${sample}/samples.txt
log_file=nhaplo_${n_haplo}_harold_decideparameters.log
results=nhaplo_${n_haplo}_results
HAROLD=/SAN/breuerlab/pathseq1/Cristina_home/src/HaROLD-2.0.0/jar/Cluster_RG/dist/Cluster_RG.jar

mkdir ${mydir}/harold
mkdir ${mydir}/harold/cluster


echo "


#!/bin/bash -l
#$ -S /bin/bash
#$ -o ${mydir}/cluster/harold/Haplo_n${n_haplo}.out
#$ -e ${mydir}/cluster/harold/Haplo_n${n_haplo}.error
#$ -l h_rt=12:00:00
#$ -l tmem=20.9G,h_vmem=20.9G
#$ -N  haplo_${n_haplo}
#$ -wd ${mydir}
#$ -V
#$ -R y

#SCRIPT HAPLO RECONSTRUCTION

##STEP1- HAROLD LEGACY 
#even before step1, need to decide how many haplotypes: run harold with several n of haplo and get elbow number

source /share/apps/anaconda/bin/activate harold
cd ${mydir}/harold

java -Xmx10g -Xms10g -jar ${HAROLD} --count-file ${filelist} --haplotypes ${n_haplo} --alpha-frac 0.1 --gamma-cache 10000 -H -L --threads 1 -p ${mydir}/harold/${results} --seed 12345 > ${mydir}/harold/${log_file}



" > ${mydir}/harold/cluster/nhaplo_${n_haplo}_getparameters.sh

     qsub ${mydir}/harold/cluster/nhaplo_${n_haplo}_getparameters.sh

done



