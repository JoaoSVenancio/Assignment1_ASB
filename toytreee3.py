import toytree       # a tree plotting library
import toyplot       # a general plotting library
import numpy as np   # numerical library
import toyplot.pdf   # pdf
import toyplot.svg


# Vai abrir o ficheiro da arvore de Raxml
with open('nome_do_ficheiro.raxml.txt', 'r') as infile:
    newick = infile.read()
    tre = toytree.tree(newick)

# Vai abrir o ficheiro da arvore do MrBayes
with open('nome_do_ficheiro.nexus.con.tre', 'r') as infile:
    mb = infile.read()
    rmb = toytree.tree(mb,tree_format=10)



# Enraizar a arvore de acordo com o(s) ancestral(ais) mais comum(ns)
rtre = tre.root(names=["nome_do_ancestral","nome_do_ancestral"])

#Palete de cores para os Tips
colorlist = [
    "#d6557c" if "nome_da_especie" in tip else 
    "#398f14" if "nome_da_especie" in tip else 
    "#491570" if "nome_da_especie" in tip else 
    "#960e0e" if "nome_da_especie" in tip else
    "#5384a3" for tip in rtre.get_tip_labels()
]

#Buscar os valores de "support" e "prob" e colocar em variaveis
mlsup = tre.get_node_values('support')
mbsup = rmb.get_node_values('prob')

#Criar uma lista que irá armazenar os valores de "support" e "prob" juntos
full_support =[]

# Realiza um loop sobre duas listas, mlsup e mbsup, usando a função zip
for s,p in zip(mlsup,mbsup):
    if p.strip(): #ver se 'p' é uma string, se não for, irá arredondar todos os seus valores em pelo menos duas casa decimais
        p_rounded = str(round(float(p), 2))
        full_support.append(f"{s}/{p_rounded}")
        
    else: #se 'p' for uma string irá guardar na variavel na lista "full_support" os valores da string com um espaço em branco
        full_support.append(f"{s} ")
   
print(full_support)

#Criar a arvore filogenetica com os valores de "support" e " prob" juntos, porém separados por uma "/"
canvas, axes, mark = rmb.draw(node_labels=full_support, node_sizes=30,width=2000, height=1000,tip_labels_align=False,
                               tip_labels_colors=colorlist)



#print(rtre)
#print(rmb)

#Vai criar um ficheiro em "pdf" com a arvore filogenética
toyplot.pdf.render(canvas, "nome_do_ficheiro_ToyTree.pdf")


#toyplot.svg.render(canvas, "ToyTree.svg")
