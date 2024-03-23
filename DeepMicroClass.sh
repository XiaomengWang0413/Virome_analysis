#!bin/bash

#Rename all sample contigs
#添加连续注释，++i递增序号
awk '/^>/{gsub(/^>/,">wpo-"++i"|")}1' WPO-CD-HT.fasta> wpo.fa 
wk -F "|" '{print $1}' wpo.fa>./End/WPO.fasta
######################
# run deepmicroclass#
######################
#Refenrence:https://github.com/chengsly/DeepMicroClass

DeepMicroClass predict -i WPO.fasta -o ./DeepMicroClass -d cuda
makdir fold
python slice_dmf_table.py -o ./slice/${fold}  ${fold}.fasta_pred_one-hot_hybrid.tsv

find ./ -name *.Txt| xargs -i  cp {}  ./Txt

python slice_fasta_by_names.py ${fold}.fasta sliced_class_ProkaryoticViruses.txt  -o ./
python slice_fasta_by_names.py ${fold}.fasta sliced_class_Eukaryotes.txt  -o ./
python slice_fasta_by_names.py ${fold}.fasta sliced_class_EukaryoticViruses.txt  -o ./
python slice_fasta_by_names.py ${fold}.fasta sliced_class_Prokaryotes.txt  -o ./
python slice_fasta_by_names.py ${fold}.fasta sliced_class_Plasmids.txt  -o ./

#######comebine all sample contigs######
CD-HIT：
