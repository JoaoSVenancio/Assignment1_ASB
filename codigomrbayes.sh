#Converter um ficheiro fasta em ficheiro nexus
seqmagick convert --output-format nexus --alphabet dna input.fasta > output.nex

#Comando para inicializar o programa MrBayes
mb
#comando do MrBayes para executar o ficheiro
execute arquivo.nex

#Definir o modelo evolucionario utilizado como GTR com distribuicao gamma
lset nst=6 rates=invgamma

#Comeca a Markov Chain Monte Carlo simulation com um valor base de geracoes de 150000(embora em certos casos seja
#necesario utilizar mais geracoes devido ao valor das split frequencies ser >0.01), com 100 de frequencia das 
#samples, 1000 atribuido a frequencia dos valores printados e 1000 para a frequencia com que as geracoes sao
#diagnosticadas
mcmc ngen=150000 samplefreq=100 printfreq=1000 diagnfreq=1000

#Obter um resumo da analise
sump

#Construir uma arvore filogenetica com todos os valores de suporte
sumt contype=Allcompat