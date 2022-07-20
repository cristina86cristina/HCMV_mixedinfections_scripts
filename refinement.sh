#this script runs the refinement for one patient for all samples available 
#create file with samples names (basename)


for sample in `cat samples_basename.txt`; do
    echo $sample
pat=R02-00189
mydir=/cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${pat}
hardir=${mydir}/harold
resdir=${mydir}/harold/refinement
bamdir=/cluster/scratch8b/test_CV/CMV_Wellcome/batch7_run393/diversity/
harold1files=${hardir}/nhaplo_3_results
ref=/cluster/scratch8b/test_CV/hcmv_db/HCMV_single.fasta

DIRLIB=/SAN/breuerlab/pathseq1/Cristina_home/src/HaROLD-2.0.0/lib
REFIN=/SAN/breuerlab/pathseq1/Cristina_home/src/HaROLD-2.0.0/jar/RefineHaplotypes.jar


mkdir ${mydir}/harold
mkdir ${mydir}/harold/cluster


echo "





java -Xmx16g -Xms16g -cp ${DIRLIB}/htsjdk-unspecified-SNAPSHOT.jar:${DIRLIB}/picocli-4.1.2.jar:${DIRLIB}/pal-1.5.1.jar:${DIRLIB}/commons-math3-3.6.1.jar:${DIRLIB}/cache2k-all-1.0.2.Final.jar:${DIRLIB}/flanagan.jar:${REFIN} refineHaplotypes.RefineHaplotypes -t ${resdir}/${sample} --bam ${bamdir}/${sample}_diversity.bam --baseFreq ${harold1files}.lld --refSequence ${ref} --hapAlignment ${harold1files}.fasta --iterate


" > ${hardir}/cluster/refinement_${sample}.sh

     qsub ${hardir}/cluster/refinement_${sample}.sh

done
