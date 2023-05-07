from Bio import Entrez

import sys



Entrez.email = "youremail@email.com"



def Efetch(database, idList):

    fhandle = Entrez.efetch(db=database, id=idList, rettype="fasta")

    sequences = fhandle.read()

    fhandle.close()

    return sequences



if __name__ == '__main__':

    print(Efetch(sys.argv[1], sys.argv[2]))


