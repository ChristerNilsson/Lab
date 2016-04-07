# -*- coding: utf-8 -*-

aminoacids = {} #      [C,H,N,O,S]
aminoacids['A'] = [3,7,1,2,0] # Alanine C3H7NO2
aminoacids['R'] = [6,14,4,2,0] # aRginine C6H14N4O2
aminoacids['N'] = [4,8,2,3,0] # asparagiNe C4H8N2O3
aminoacids['D'] = [4,7,1,4,0] # aspartic aciD C4H7NO4
aminoacids['C'] = [3,7,1,2,1] # Cysteine C3H7NO2S

aminoacids['E'] = [5,9,1,4,0] # glutamic acid C5H9NO4
aminoacids['Q'] = [5,10,2,3,0] # Glutamine C5H10N2O3
aminoacids['G'] = [2,5,1,2,0] # Glycine C2H5NO2
aminoacids['H'] = [6,9,3,2,0] # Histidine C6H9N3O2
aminoacids['I'] = [6,13,1,2,0] # Isoleucine C6H13NO2

aminoacids['L'] = [6,13,1,2,0] # Leucine C6H13NO2
aminoacids['K'] = [6,14,2,2,0] # lysine C6H14N2O2
aminoacids['M'] = [5,11,1,2,1] # Methionine C5H11NO2S
aminoacids['F'] = [9,11,1,2,0] # Phenylalanine C6H5CH2CH(NH2COOH
aminoacids['P'] = [5,9,1,2,0] # Proline C5H9NO2

aminoacids['S'] = [3,7,1,3,0] # Serine C3H7NO3
aminoacids['T'] = [4,9,1,3,0] # Threonine C4H9NO3
aminoacids['W'] = [11,12,2,2,0] # tryptophan C11H12N2O2
aminoacids['Y'] = [9,11,1,3,0] # tYrosine C9H11NO3
aminoacids['V'] = [5,11,1,2,0] # Valine C5H11NO2

nucleobases = {}      # C H N O
nucleobases['A'] = [5,5,5,0]  # C5H5N5   Adenine
nucleobases['T'] = [5,6,2,2]  # C5H6N2O2 Thymine
nucleobases['C'] = [4,5,3,1]  # C4H5N3O  Cytosine
nucleobases['G'] = [5,5,5,1]  # C5H5N5O  Guanine

# table 11
# http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=cgencodes#SG11
table = """
TTT F Phe      TCT S Ser      TAT Y Tyr      TGT C Cys
TTC F Phe      TCC S Ser      TAC Y Tyr      TGC C Cys
TTA L Leu      TCA S Ser      TAA * Ter      TGA * Ter
TTG L Leu      TCG S Ser      TAG * Ter      TGG W Trp

CTT L Leu      CCT P Pro      CAT H His      CGT R Arg
CTC L Leu      CCC P Pro      CAC H His      CGC R Arg
CTA L Leu      CCA P Pro      CAA Q Gln      CGA R Arg
CTG L Leu      CCG P Pro      CAG Q Gln      CGG R Arg

ATT I Ile      ACT T Thr      AAT N Asn      AGT S Ser
ATC I Ile      ACC T Thr      AAC N Asn      AGC S Ser
ATA I Ile      ACA T Thr      AAA K Lys      AGA R Arg
ATG M Met      ACG T Thr      AAG K Lys      AGG R Arg

GTT V Val      GCT A Ala      GAT D Asp      GGT G Gly
GTC V Val      GCC A Ala      GAC D Asp      GGC G Gly
GTA V Val      GCA A Ala      GAA E Glu      GGA G Gly
GTG V Val      GCG A Ala      GAG E Glu      GGG G Gly
"""

def clean(data):
    data = data.replace(' ','')
    return data.replace('\n','')

def fix_gene(g):
    g = clean(g)
    g = g[::-1]
    return swap(g)

def swap(s):
    s = s.replace('a','T')
    s = s.replace('t','A')
    s = s.replace('c','G')
    s = s.replace('g','C')
    return s

def read_table(t):
    hash = {}
    revhash = {}
    for line in t.split('\n'):
        if len(line) > 10:
            for cell in line.split('      '):
                a,b,_ = cell.split(' ')
                hash[a] = b
                revhash[b] = a
    return hash,revhash

def translate(gene, table):
    res = ""
    for i in range(0,len(gene),3):
        s = gene[i:i+3]
        res += table[s]
    return res.replace('*','')

# Beräkna ingående atomer i T4
def count_atoms_in_genome(genome,rev11):
    total = [0,0,0,0,0]
    for translation,count in genome:
        translation = clean(translation)
        for char in translation:
            for b in rev11[char]:
                for i in range(5):
                    total[i] += count * aminoacids[b][i]
    return total

# Beräkna ingående atomer i dubbla dna-strängen
def count_atoms_in_dna_string(genome):
    backbone = [5,10,0,7,1] # CHNOP
    total = [0,0,0,0,0]
    for char in genome:
        char = char.upper()
        if char in 'ACTG':
            for i in range(4):
                total[i] += 2*nucleobases[char][i] + 2*backbone[i]
            total[4] += 2*backbone[4]
    return total



