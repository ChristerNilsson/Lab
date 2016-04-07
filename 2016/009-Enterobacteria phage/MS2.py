# -*- coding: utf-8 -*-

from phage import *

MS2genome = """
gggtgggacc cctttcgggg tcctgctcaa cttcctgtcg agctaatgcc atttttaatg
tctttagcga gacgctacca tggctatcgc tgtaggtagc cggaattcca ttcctaggag
gtttgacctg tgcgagcttt tagtaccctt gatagggaga acgagacctt cgtcccctcc
gttcgcgttt acgcggacgg tgagactgaa gataactcat tctctttaaa atatcgttcg
aactggactc ccggtcgttt taactcgact ggggccaaaa cgaaacagtg gcactacccc
tctccgtatt cacggggggc gttaagtgtc acatcgatag atcaaggtgc ctacaagcga
agtgggtcat cgtggggtcg cccgtacgag gagaaagccg gtttcggctt ctccctcgac
gcacgctcct gctacagcct cttccctgta agccaaaact tgacttacat cgaagtgccg
cagaacgttg cgaaccgggc gtcgaccgaa gtcctgcaaa aggtcaccca gggtaatttt
aaccttggtg ttgctttagc agaggccagg tcgacagcct cacaactcgc gacgcaaacc
attgcgctcg tgaaggcgta cactgccgct cgtcgcggta attggcgcca ggcgctccgc
taccttgccc taaacgaaga tcgaaagttt cgatcaaaac acgtggccgg caggtggttg
gagttgcagt tcggttggtt accactaatg agtgatatcc agggtgcata tgagatgctt
acgaaggttc accttcaaga gtttcttcct atgagagccg tacgtcaggt cggtactaac
atcaagttag atggccgtct gtcgtatcca gctgcaaact tccagacaac gtgcaacata
tcgcgacgta tcgtgatatg gttttacata aacgatgcac gtttggcatg gttgtcgtct
ctaggtatct tgaacccact aggtatagtg tgggaaaagg tgcctttctc attcgttgtc
gactggctcc tacctgtagg taacatgctc gagggcctta cggcccccgt gggatgctcc
tacatgtcag gaacagttac tgacgtaata acgggtgagt ccatcataag cgttgacgct
ccctacgggt ggactgtgga gagacagggc actgctaagg cccaaatctc agccatgcat
cgaggggtac aatccgtatg gccaacaact ggcgcgtacg taaagtctcc tttctcgatg
gtccatacct tagatgcgtt agcattaatc aggcaacggc tctctagata gagccctcaa
ccggagtttg aagcatggct tctaacttta ctcagttcgt tctcgtcgac aatggcggaa
ctggcgacgt gactgtcgcc ccaagcaact tcgctaacgg ggtcgctgaa tggatcagct
ctaactcgcg ttcacaggct tacaaagtaa cctgtagcgt tcgtcagagc tctgcgcaga
atcgcaaata caccatcaaa gtcgaggtgc ctaaagtggc aacccagact gttggtggtg
tagagcttcc tgtagccgca tggcgttcgt acttaaatat ggaactaacc attccaattt
tcgctacgaa ttccgactgc gagcttattg ttaaggcaat gcaaggtctc ctaaaagatg
gaaacccgat tccctcagca atcgcagcaa actccggcat ctactaatag acgccggcca
ttcaaacatg aggattaccc atgtcgaaga caacaaagaa gttcaactct ttatgtattg
atcttcctcg cgatctttct ctcgaaattt accaatcaat tgcttctgtc gctactggaa
gcggtgatcc gcacagtgac gactttacag caattgctta cttaagggac gaattgctca
caaagcatcc gaccttaggt tctggtaatg acgaggcgac ccgtcgtacc ttagctatcg
ctaagctacg ggaggcgaat ggtgatcgcg gtcagataaa tagagaaggt ttcttacatg
acaaatcctt gtcatgggat ccggatgttt tacaaaccag catccgtagc cttattggca
acctcctctc tggctaccga tcgtcgttgt ttgggcaatg cacgttctcc aacggtgctc
ctatggggca caagttgcag gatgcagcgc cttacaagaa gttcgctgaa caagcaaccg
ttaccccccg cgctctgaga gcggctctat tggtccgaga ccaatgtgcg ccgtggatca
gacacgcggt ccgctataac gagtcatatg aatttaggct cgttgtaggg aacggagtgt
ttacagttcc gaagaataat aaaatagatc gggctgcctg taaggagcct gatatgaata
tgtacctcca gaaaggggtc ggtgctttca tcagacgccg gctcaaatcc gttggtatag
acctgaatga tcaatcgatc aaccagcgtc tggctcagca gggcagcgta gatggttcgc
ttgcgacgat agacttatcg tctgcatccg attccatctc cgatcgcctg gtgtggagtt
ttctcccacc agagctatat tcatatctcg atcgtatccg ctcacactac ggaatcgtag
atggcgagac gatacgatgg gaactatttt ccacaatggg aaatgggttc acatttgagc
tagagtccat gatattctgg gcaatagtca aagcgaccca aatccatttt ggtaacgccg
gaaccatagg catctacggg gacgatatta tatgtcccag tgagattgca ccccgtgtgc
tagaggcact tgcctactac ggttttaaac cgaatcttcg taaaacgttc gtgtccgggc
tctttcgcga gagctgcggc gcgcactttt accgtggtgt cgatgtcaaa ccgttttaca
tcaagaaacc tgttgacaat ctcttcgccc tgatgctgat attaaatcgg ctacggggtt
ggggagttgt cggaggtatg tcagatccac gcctctataa ggtgtgggta cggctctcct
cccaggtgcc ttcgatgttc ttcggtggga cggacctcgc tgccgactac tacgtagtca
gcccgcctac ggcagtctcg gtatacacca agactccgta cgggcggctg ctcgcggata
cccgtacctc gggtttccgt cttgctcgta tcgctcgaga acgcaagttc ttcagcgaaa
agcacgacag tggtcgctac atagcgtggt tccatactgg aggtgaaatc accgacagca
tgaagtccgc cggcgtgcgc gttatacgca cttcggagtg gctaacgccg gttcccacat
tccctcagga gtgtgggcca gcgagctctc ctcggtagct gaccgaggga cccccgtaaa
cggggtgggt gtgctcgaaa gagcacgggt gcgaaagcgg tccggctcca ccgaaaggtg
ggcgggcttc ggcccaggga cctcccccta aagagaggac ccgggattct cccgatttgg
taactagctg cttggctagt taccaccca
"""

g1 = """MRAFSTLDRENETFVPSVRVYADGETEDNSFSLKYRSNWTPGRF
                     NSTGAKTKQWHYPSPYSRGALSVTSIDQGAYKRSGSSWGRPYEEKAGFGFSLDARSCY
                     SLFPVSQNLTYIEVPQNVANRASTEVLQKVTQGNFNLGVALAEARSTASQLATQTIAL
                     VKAYTAARRGNWRQALRYLALNEDRKFRSKHVAGRWLELQFGWLPLMSDIQGAYEMLT
                     KVHLQEFLPMRAVRQVGTNIKLDGRLSYPAANFQTTCNISRRIVIWFYINDARLAWLS
                     SLGILNPLGIVWEKVPFSFVVDWLLPVGNMLEGLTAPVGCSYMSGTVTDVITGESIIS
                     VDAPYGWTVERQGTAKAQISAMHRGVQSVWPTTGAYVKSPFSMVHTLDALALIRQRLS
                     R"""

g2 = """MASNFTQFVLVDNGGTGDVTVAPSNFANGVAEWISSNSRSQAYK
                     VTCSVRQSSAQNRKYTIKVEVPKVATQTVGGVELPVAAWRSYLNMELTIPIFATNSDC
                     ELIVKAMQGLLKDGNPIPSAIAANSGIY"""

g3 = """METRFPQQSQQTPASTNRRRPFKHEDYPCRRQQRSSTLYVLIFL
                     AIFLSKFTNQLLLSLLEAVIRTVTTLQQLLT"""

g4 = """MSKTTKKFNSLCIDLPRDLSLEIYQSIASVATGSGDPHSDDFTA
                     IAYLRDELLTKHPTLGSGNDEATRRTLAIAKLREANGDRGQINREGFLHDKSLSWDPD
                     VLQTSIRSLIGNLLSGYRSSLFGQCTFSNGAPMGHKLQDAAPYKKFAEQATVTPRALR
                     AALLVRDQCAPWIRHAVRYNESYEFRLVVGNGVFTVPKNNKIDRAACKEPDMNMYLQK
                     GVGAFIRRRLKSVGIDLNDQSINQRLAQQGSVDGSLATIDLSSASDSISDRLVWSFLP
                     PELYSYLDRIRSHYGIVDGETIRWELFSTMGNGFTFELESMIFWAIVKATQIHFGNAG
                     TIGIYGDDIICPSEIAPRVLEALAYYGFKPNLRKTFVSGLFRESCGAHFYRGVDVKPF
                     YIKKPVDNLFALMLILNRLRGWGVVGGMSDPRLYKVWVRLSSQVPSMFFGGTDLAADY
                     YVVSPPTAVSVYTKTPYGRLLADTRTSGFRLARIARERKFFSEKHDSGRYIAWFHTGG
                     EITDSMKSAGVRVIRTSEWLTPVPTFPQECGPASSPR"""

MS2 = []
MS2.append([g1,1])
MS2.append([g2,180])
MS2.append([g3,0])
MS2.append([g4,0])

assert len(clean(MS2genome)) == 3569

_,rev11 = read_table(table)

assert count_atoms_in_genome(MS2,rev11) == [193448, 458275, 71379, 151551, 15561] # [C,H,N,O,S]
assert count_atoms_in_dna_string(MS2genome) == [69514, 108818, 26714, 57182, 7138]
