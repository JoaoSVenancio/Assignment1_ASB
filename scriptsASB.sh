#codigo utilizado para obter as sequencias por ID utilizando o script em python do Homework1
python3 HMASB.py  nucleotide 'ID'

#Para remover os espacos em branco em todas as linhas exceto nas que começam com '>' e criar um ficheiro
sed '/^[^>]/s/\s//g' input.fasta > output.fasta 

#Alinhamento das sequencias atraves do mafft
mafft --auto input.fasta > output.fasta 

#Comando para obter o melhor modelo a ser utilizado atraves do modeltest-ng
modeltest-ng -i arquivo.fasta 
