#Realização da Maximum Likelihood - Raxml-ng

#Antes de realizar o raxml-ng, para não haver nehum erro, devemos retirar os espços em branco do nome da espécie no arquivo .fasta
#ou seja, por padrão, após realizar o alinhamento o nome da espécie irá estar assim:
# >Nome Especius
#Isso ao realizar o raxml-ng irá dar erro por causa desse espaço, então devemos remover esse espaço realizando o comando:
sed -i '/^>/ s/ //g' nome_do_ficheiro.fasta

#1º Passo:

#Tree Inference
#Realização do tree inference com o melhor modelo, visualizado pelo modeltest-ng
#Neste codigo estou a utlizar o GTR+G, pois é o modelo padrão, porém deves utilizar o modelo representado no modelteste-ng
#Iremos utilizar para os valores de random e parsimony: {10}.{10}, {25}.{25}, {50}.{50}, {75}.{75}, {100}.{100},
#ou seja, devemos correr o comando 5 vezes
raxml-ng --msa nome_do_arquivoAlinhado.fasta --model GTR+G --prefix nome_do_prefix --threads 2 --seed 2 --tree pars{10}, rand{10}

#2º Passo:

#Iremos comparar  os resultados dos 5 "runs" para ver qual possui a melhor likelihood
grep "Final LogLikelihood:" {nome_do_prefixo1, nome_do_prefixo2, ....}.raxml.log

#3º Passo:

#Iremos inferir as "bootstraps tree" pelas nossas arvores terem muitas sequencias colocamos no --bs-trees um valor de 5000 como padrão
#O modelo foi utilizado de acordo com o modelo do modeltest-ng
raxml-ng --bootstrap --msa nome_do_ficheiroAlinhado.fasta --model GTR+G --prefix nome_do_prefix --seed 2 --threads 2 --bs-trees 5000

#4º Passo:

#Em seguida realizamos o bootstrap converge, e substituimos o valor de cutoff que era 0.01 para 0.03 para tornar o teste mais rigoroso
raxml-ng --bsconverge --bs-trees nome_do_prefix.bootstrap --prefix nome_do_prefixo --seed 2 --threads 1 --bs-cutoff 0.03 
#Exemplo do OUTPUT:
"""
 # trees        avg WRF       avg WRF in %       # perms: wrf <= 1.00 %     converged?  
      50          7.400              1.644                            0        NO
     100         11.702              1.300                          245        NO
     150         13.960              1.034                          457        NO
     200         16.484              0.916                          648        NO
     250         17.410              0.774                          841        NO
     300         18.900              0.700                          927        NO
     350         20.060              0.637                          942        NO
     400         22.076              0.613                          969        NO
     450         23.856              0.589                          973        NO
     500         26.164              0.581                          985        NO
     550         27.844              0.563                          985        NO
     600         28.462              0.527                          991        YES
Bootstopping test converged after 600 trees
"""
#Devemos esperar que o converge seja "YES" para finalizar este passo

#5º Passo:

#Iremos realizar o branch support e iremos utilizar o bestTree do 2º Passo que escolhemos
raxml-ng --support --tree nome_do_prefixo1.raxml.bestTree --bs-trees nome_do_prefix.bootstraps --prefix nome_do_prefixo --threads 2
