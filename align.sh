
ref=/cluster/scratch8b/test_CV/hcmv_db/HCMV_single.fasta
patient=R01-00060
mypath=/cluster/scratch8b/test_CV/CMV_Wellcome/mixed_infection/${patient}/refinement/
/share/apps/genomics/mafft-7.453/bin/mafft --add  ${mypath}/${patient}.fasta --keeplength ${ref}   > ${mypath}/${patient}_Aln.fasta
