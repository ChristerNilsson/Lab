# -*- coding: utf-8 -*-

from phage import *

# rIIA membrane integrity protector [ Enterobacteria phage T4 ]
# http://www.ncbi.nlm.nih.gov/gene?cmd=Retrieve&dopt=full_report&list_uids=1258593

trans =    """MIITTEKETILGNGSKSKAFSITASPKVFKILSSDLYTNKIRAV
VRELITNMIDAHALNGNPEKFIIQVPGRLDPRFVCRDFGPGMSDFDIQGDDNSPGLYN
SYFSSSKAESNDFIGGFGLGSKSPFSYTDTFSITSYHKGEIRGYVAYMDGDGPQIKPT
FVKEMGPDDKTGIEIVVPVEEKDFRNFAYEVSYIMRPFKDLAIINGLDREIDYFPDFD
DYYGVNPERYWPDRGGLYAIYGGIVYPIDGVIRDRNWLSIRNEVNYIKFPMGSLDIAP
SREALSLDDRTRKNIIERVKELSEKAFNEDVKRFKESTSPRHTYRELMKMGYSARDYM
ISNSVKFTTKNLSYKKMQSMFEPDSKLCNAGVVYEVNLDPRLKRIKQSHETSAVASSY
RLFGINTTKINIVIDNIKNRVNIVRGLARALDDSEFNNTLNIHHNERLLFINPEVESQ
IDLLPDIMAMFESDEVNIHYLSEIEALVKSYIPKVVKSKAPRPKAATAFKFEIKDGRW
EKRNYLRLTSEADEITGYVAYMHRSDIFSMDGTTSLCHPSMNILIRMANLIGINEFYV
IRPLLQKKVKELGQCQCIFEALRDLYVDAFDDVDYDKYVGYSSSAKRYIDKIIKYPEL
DFMMKYFSIDEVSEEYTRLANMVSSLQGVYFNGGKDTIGHDIWTVTNLFDVLSNNASK
NSDKMVAEFTKKFRIVSDFIGYRNSLSDDEVSQIAKTMKALAA"""

gene   = """ttaggccgc aagggccttc atagttttag cgatttggga aacttcatca
tcacttaaag agttgcgata accgatgaag tcggaaacaa tacggaattt cttggtaaac
tcagcaacca ttttatcact gttttttgaa gcattatttg ataatacatc aaaaagatta
gttactgtcc aaatgtcatg accgatggta tcttttccac cattaaaata tacaccctgt
aatgaactaa ccatattagc gagtcgtgta tattcttcag aaacttcatc tatactgaag
tacttcatca taaaatctaa ctcaggatac ttgataattt tatcaatata tcgtttagct
gaacttgaat aacctacata cttatcataa tctacatcat caaaagcatc tacatataaa
tcacgcaaag cttcaaaaat acattggcac tgaccgagtt cttttacctt tttctgtaaa
agcggacgaa taacataaaa ttcattaatg ccaataagat tagccatacg aatcaaaata
ttcatagatg gatgacaaag agatgtagta ccatccatag agaaaatatc agaacgatgc
atatacgcta cataaccagt aatttcatct gcttctgatg tgaggcgtaa ataattcctc
ttttcccagc gcccgtcttt aatttcaaac ttaaacgctg tagcagcttt aggacgagga
gctttacttt taactacctt tggaatataa ctttttacta aagcttcaat ttctgacaaa
taatgaatgt taacttcatc actttcaaac atcgccataa tatcaggaag caaatcaatc
tgcgattcta cttctggatt aataaacaga agacgttcgt tatgatgaat attcaaagtg
ttattaaatt cactatcatc taacgcacgt gctaatccac ggacaatatt aacacgattt
ttaatattat caataacgat attaattttt gttgtattaa taccaaacag acgataactt
gatgcaacgg ctgaagtttc atgactttgc ttaatgcgct tcagtcgagg gtcaagattt
acttcataca caactcccgc gttgcataac ttactgtcag gttcaaacat gctctgcatc
tttttatatg acagattttt agtcgtgaat ttgactgaat tactaatcat ataatctcga
gcagaatacc ccatcttcat caattcacga tatgtgtgac gaggagatgt agattcttta
aatcgtttta catcttcatt aaatgctttc tcactgagtt ctttaactcg ttcaataata
tttttacgag tgcgatcatc cagtgaaaga gcctcgcgag atggagcaat atcaagtgaa
cccattggaa acttaatgta attcacttca ttgcgaatgc ttagccagtt acggtctcta
ataacaccat cgataggata aacaatacca ccgtagatag catataatcc accacgatca
ggccagtatc tttctggatt tacaccgtaa tagtcatcaa aatccggaaa ataatcaatt
tcgcggtcaa gaccattaat gatagccaaa tctttgaacg gtcgcatgat ataagaaact
tcataagcaa agtttctaaa gtctttttct tcaactggaa ctacgatttc aataccagtt
ttatcatctg gacccatttc ttttacgaat gtaggtttaa tctgtggacc atcaccatcc
atgtaagcta cataaccacg aatttcacct ttatgatacg aagtaatact aaacgtatca
gtataactaa acggagattt agaacctaaa ccaaatccgc caataaagtc attagattca
gctttagatg aactgaagta tgaattatac aacccaggag aattatcatc accttgaata
tcaaaatcac tcatacccgg accaaaatct cgacaaacaa atcgtgggtc taaacgtcca
ggaacttgta tgataaattt ttcaggattt ccattaagtg catgagcatc aatcatgtta
gtaatcaatt cacggactac tgcgcgaatc ttgtttgtat acaaatcaga tgacagaatt
ttaaatactt taggagatgc tgtgatgcta aatgcttttg atttagaacc attaccaaga
attgtttctt tttcagtggt gataatcat"""

T4genome = """
        1 aattttcctt attaggccgc aagggccttc atagttttag cgatttggga aacttcatca
       61 tcacttaaag agttgcgata accgatgaag tcggaaacaa tacggaattt cttggtaaac
      121 tcagcaacca ttttatcact gttttttgaa gcattatttg ataatacatc aaaaagatta
      181 gttactgtcc aaatgtcatg accgatggta tcttttccac cattaaaata tacaccctgt
      241 aatgaactaa ccatattagc gagtcgtgta tattcttcag aaacttcatc tatactgaag
      301 tacttcatca taaaatctaa ctcaggatac ttgataattt tatcaatata tcgtttagct
      361 gaacttgaat aacctacata cttatcataa tctacatcat caaaagcatc tacatataaa
      421 tcacgcaaag cttcaaaaat acattggcac tgaccgagtt cttttacctt tttctgtaaa
      481 agcggacgaa taacataaaa ttcattaatg ccaataagat tagccatacg aatcaaaata
      541 ttcatagatg gatgacaaag agatgtagta ccatccatag agaaaatatc agaacgatgc
      601 atatacgcta cataaccagt aatttcatct gcttctgatg tgaggcgtaa ataattcctc
      661 ttttcccagc gcccgtcttt aatttcaaac ttaaacgctg tagcagcttt aggacgagga
      721 gctttacttt taactacctt tggaatataa ctttttacta aagcttcaat ttctgacaaa
      781 taatgaatgt taacttcatc actttcaaac atcgccataa tatcaggaag caaatcaatc
      841 tgcgattcta cttctggatt aataaacaga agacgttcgt tatgatgaat attcaaagtg
      901 ttattaaatt cactatcatc taacgcacgt gctaatccac ggacaatatt aacacgattt
      961 ttaatattat caataacgat attaattttt gttgtattaa taccaaacag acgataactt
     1021 gatgcaacgg ctgaagtttc atgactttgc ttaatgcgct tcagtcgagg gtcaagattt
     1081 acttcataca caactcccgc gttgcataac ttactgtcag gttcaaacat gctctgcatc
     1141 tttttatatg acagattttt agtcgtgaat ttgactgaat tactaatcat ataatctcga
     1201 gcagaatacc ccatcttcat caattcacga tatgtgtgac gaggagatgt agattcttta
     1261 aatcgtttta catcttcatt aaatgctttc tcactgagtt ctttaactcg ttcaataata
     1321 tttttacgag tgcgatcatc cagtgaaaga gcctcgcgag atggagcaat atcaagtgaa
     1381 cccattggaa acttaatgta attcacttca ttgcgaatgc ttagccagtt acggtctcta
     1441 ataacaccat cgataggata aacaatacca ccgtagatag catataatcc accacgatca
     1501 ggccagtatc tttctggatt tacaccgtaa tagtcatcaa aatccggaaa ataatcaatt
     1561 tcgcggtcaa gaccattaat gatagccaaa tctttgaacg gtcgcatgat ataagaaact
     1621 tcataagcaa agtttctaaa gtctttttct tcaactggaa ctacgatttc aataccagtt
     1681 ttatcatctg gacccatttc ttttacgaat gtaggtttaa tctgtggacc atcaccatcc
     1741 atgtaagcta cataaccacg aatttcacct ttatgatacg aagtaatact aaacgtatca
     1801 gtataactaa acggagattt agaacctaaa ccaaatccgc caataaagtc attagattca
     1861 gctttagatg aactgaagta tgaattatac aacccaggag aattatcatc accttgaata
     1921 tcaaaatcac tcatacccgg accaaaatct cgacaaacaa atcgtgggtc taaacgtcca
     1981 ggaacttgta tgataaattt ttcaggattt ccattaagtg catgagcatc aatcatgtta
     2041 gtaatcaatt cacggactac tgcgcgaatc ttgtttgtat acaaatcaga tgacagaatt
     2101 ttaaatactt taggagatgc tgtgatgcta aatgcttttg atttagaacc attaccaaga
     2161 attgtttctt tttcagtggt gataatcata atttcctcat taattcatat tacgcttaat
     2221 aacttcagca acttctagta gttcatcttt agttgcggtg tcggattgaa ttttatctct
     2281 aatatcttta aagcgggttt taaattcttc ggcttctccc atatcgaaaa agcgttgaat
     2341 gattctatat tctcgatgaa ctgctttatc aaaaagttct aaatttactt tatatgattt
     2401 catttcaata tcctcatttg cccaattaat tataccacat ccttgtggta aagtaaacta
     2461 ctggctcatc cattctttac gaaggtcagc attatctccc atgagcattt caaaaagctc
     2521 tttccagttc tcaggaagtt taacaacatc atatactggg ttttgaatca tctcacgata
     2581 ttcagatttt tccaaagagc caagtccctt aatataacgg atgctatgtt taggtagagc
     2641 atctttggca ctctcatatt cagcgactgt ataaaaccat tcttgttttt taccgacctg
     2701 agcgatgatt acaggagttt tgacaaagcg aattcgtcct tgctcaaaca attctggcca
     2761 attactaaaa aatccgagca gagaaggata aatagaacct aatccaataa tctcttaatt
     2821 atgaggtatt tctatagata gcccgaaggc tatccatcgt gatctgcgtc tgtcataata
     2881 gcgacattcg catagttcat tgaagaggat ttaatagaac gacgaacatt gttctgcaat
     2941 ttatattttt tcatatcaac gctagaagaa tcaattttta caaatttcat tatacacctc
     3001 atagaacttt tcatcaggaa tccaaccgcg tttaaattca ttaaatgctc ggccgaataa
     3061 ttttgaattc acagttatat tattaactga tttccattta gcaactcccg ttcgtttata
     3121 atgatcgggg tcatatttcg tgacgtacca ttcatataaa tttggtatta attttacagc
     3181 ctctggattt gtcgctgatt tattatacca tggtttcgct ttttcaagtt cagctgcttt
     3241 tgcagtagca gcaacagtat ttccaacacc aactaatttt tcagttttaa tgcgtggatc
     3301 attaacatga agacgaaaaa cttcgccctt ttcattttta aagcatgtca tgcctttaat
     3361 tccaggaagc ttaacacctt tattaacacc gcatcattcc tttgggttaa atgatccttt
     3421 aattaataag gcgcatttac ccgatttaac tacttctcat tcaacaactt tatctttcat
     3481 aacgtttttt gaccattcag atactgctct ttgatggcta aattctagca atttcactat
     3541 aatttgcact agaacgtaaa ctatttttca gtgtttcaac attctattca tcgcatatgc
     3601 catttcacga ttacgatgaa ttttatatag tagaaaatag tgctaaaaag tgttcacgaa
     3661 aagtcatgtt tcaccaaatt ttcgttatca tcagaacctc ccattgatct tggaaggata
     3721 tgatgaattt cacccttaaa tttagaaacg cgggttttac cccgcactat taagtcatta
     3781 tagatttttt cgtaattcac ctactgttat ccatttacca ttaatctgta cttcatcatt
     3841 ttcatttacg ataattgtat cgccatttag ctcgaaagta aaccactcgc catcttcttt
     3901 ttcttcaaac gctttttcac cgagaactag accagtgatt gcgcaaatat caaatagttc
     3961 tttgttttta agcatatctg cataagacat accccaactg ttgagaactt taccacgcaa
     4021 tggataacca ccgtgaagtt ctttatcacg aacatcaata agatatccga tagccgaatc
     4081 accctcagtc aagaaaagag tagtatcagc atctttaccg caaagattcg ctttgatatg
     4141 tttatgaacc ttagctttag aagccttttt agctgcttta gtttctgctg ctttttctgc
     4201 cgccaattta cgagccaaag cagcttcaat aatcggcatt agaattgctt cattatttag
     4261 aatatcacgt gaaatctttt tagcatcaag ttgaatatga ctacgaattt cgccaaatgg
     4321 agaagtcaaa cgctctttag tttgacgaat caatcgcatg tttttcatat cacgaacaaa
     4381 cataacgata gtcaaacatt ctttgacacg tgctttagtc acatcaattt tgaacttacg
     4441 tttgatttgt ggaataaggt cttcacaaat atcatccata gcgcagtcaa tgtgatggcc
     4501 accattctta gtatgaatgt tattgacgta tgttaattga cgaaaaccat ccggtgaacg
     4561 accaaccgca atagaacaat tttcttgctc ttgaacaata gcatgttcat catactgccg
     4621 tgcatatttc ttaaaattgc cctgaacctt tttaccatta aaggtaaatt gaatatcagg
     4681 ataaactaca gcaagtgtct ggagacgatc cagtgtaatg tcaagataaa cttgggacag
     4741 ctcattagtt tcaaatgaca taaaatcagg aatgaaagta acacgagttc ctttccattt
     4801 tccaggaata tcttcccatg atttattttc catgccattt gaacaacgaa ctacaatatt
     4861 attttgaccg tcgccagttt caccgacaaa catcacagaa aaaatgtttg tcaaactaga
     4921 accaacaccg ttcataccgc cggtgacgcg ttctttatca tcaccaaagt taccacctgc
     4981 ttttggaata gtccatgcgg caacaggacc aggaatttct tcaccggtag gtgttttaac
     5041 catcgcttgt ggaataccgc gaccgttatc ttcaactgtt acttgattgt ttttaatagt
     5101 aacattaatt ttattcgcga atttaaactt agtacgaata ccttcatcta ctgagttatc
     5161 gataatttca tcaataagct taacaagacc aggtacatac tgaacacttt cccatttacc
     5221 aaacataaag cgctcatgcg tttcattagc agaagagcca atgtacatgc cactacgctt
     5281 tttgatatgt tcaatatcgc tcagaatttt aatttcattc ttaatcatca cttatcctcg
     5341 tttggtttcg ggaatattat actccggtaa tcataaagct aaaggcccga aggcctttta
     5401 tttaaaacga atagttgaat ccttaaagaa cagcccagaa catactgttc cttctacttt
     5461 ctgcccggta ggtccaatag cacgaaatcc agtatgctgg aaatcatttt cagagcaacc
     5521 gaaccaatta tatccagtga tttcaatatt agtaaaacca cttgaagaca aaactttggt
     5581 tgcattaatc agcatcagta ctattaatta aagacactgc taatactaat gctgcaattg
     5641 aacgactaat atatttcata actacccttt aagcaagtcg taaaatccat tattcccatg
     5701 cttaggaagc ggaaactaac cgaacagcca gccgatgaca atcaggacat acaccagtat
     5761 ctcttccaga aattttcttg attttttcgt attcttttgc acagtctttg gattgacatt
     5821 tataatcata aagcggcata attattcctt aaagtaagct ttcaacatct gatataaaga
     5881 ccacgcctga tcattatttt caatagtaac tttcatgact gggaattctg tgaaatcttc
     5941 tatttgttct tgctctttct cttcctgctc ttgctcttca accgcctgat atggattttc
     6001 cacttcatca aagaacccag cttcgttagt agagagccag ataaagtttt cgtcaaggat
     6061 atcaccgccg gcacaacgtt tgagtacacc tatggatgtc ataattttag taggacgccc
     6121 aagataatca gcatctaaaa ttttaaaagg ctccatacct aaacgtcgtg catagattcc
     6181 gttatcagta tggtctttaa taaaattttc ttgagcttgt ttatttttaa attgatacca
     6241 tttattaact tcaaatttaa tagccattaa taaatttcct tccagtaagt tgtgccgtct
     6301 tcagtaattt cacgaaatac accataaatt ggctgtttat caccgacttt ctcatacaca
     6361 taaacagaag tcaagtgagt aaacttgcta gtatgttcct tttgaactac taccaaattt
     6421 ggatcaaata atacatcttc aaattcatca ttagtgcaat tctgaacaat tttacgtttc
     6481 attacaattt cctcattaat tgaacagtgg agcgatacgt ttcagaagag tatcaacacc
     6541 tttagcgaat tttccatttt attctccaag ttgttttctg tatcagtagt tgatattgat
     6601 atagtaccat aatcaactac tgatgtatat agttttatga aaaatttaaa ctttatgcat
     6661 agagagcatt gctatagtgt ttaatccaac tttcaggaat gactttgtat gttcctaaaa
     6721 ataccacgtt gtacaactta acaccatctt ctacccattg atcggtaatg tatccacaca
     6781 tagcgcgagt ataaacaacc cttccatcat ctttaataaa gttaaattca caaggagcaa
     6841 tgaacttgat agcctgaccg agtttccact taaagtctac acctacatgc gaagtatcaa
     6901 tcgtttcaat tcctttagca ggaacagctt ttaaaaacgc agactcaaga aatttcgcac
     6961 gaacatagcc aaactggggt ttagactttc catctttagg aatgatacgc acttttactt
     7021 cagaatcttc atctttaaca ccatgcttaa gctgaatgct tacaacttcg accaattttc
     7081 ctgctgcttt agaacgggat ttatcagata cacgagctaa ttcaccaata ttaataatca
     7141 tagttatctc tcacttgtta aaaagatttt atactccacg ggaccattat actctggtcc
     7201 caagagtttg taaactatta attcaaaata gctaccactg cactacgagg aactacggag
     7261 tactctccag catgaactac gttcagaagt tcaacgccat cttccaatcc attggtcagt
     7321 tacccaacca ccaatcggat tcgcaaatgg acgacgaatg taaactgcct tacacaacaa
     7381 atcagtcggg tcttcaggtt tttcaatttc tgtcaataga ttaaaatctt cttcatagat
     7441 gatgaatgat gatacccttc cataatagtt tctaatttcc atgtacactg taccaatgag
     7501 aattccacta ttaacactaa tgacagtaaa aggatatccg ccagttgtac caagaagttc
     7561 ccaaaatttg ctatcagtcg tattcgacat tgtctgaaaa tcaatttcag atggtttttt
     7621 catttgatac gcagtattaa ttttaatcat aattttctct ttagtttaag gtaataaagc
     7681 cttttagttc ggcataggat ttacggaaca ttacttgatg cccgccaatg ataacttggt
     7741 catctggtac ttcgtataca gcaagataaa atcctttcga agctaattct tcacgctctt
     7801 ctcgtgtgaa ccatttcatc atatcatatt cgctagcaaa agcaaaatga taaagagcta
     7861 caaaccatcc gggaatatga tattctactc caacataatc tttcttgaac ttagtattaa
     7921 ttacgatatt agcattttta actaatagtt tgtcttcgtg cggcacagga attcttttat
     7981 tatcattact atgatgcata aaattaggtc tgtcataacc tacatgtaat aaccactctt
     8041 cactccatga atctattata cttctatacg gcgttatttg aacacaaaga tctcggcgta
     8101 ttgttatagc gtcttcataa ttaagaatac taaacgatga ttcaacacga taaattttca
     8161 ttttattatc ctcagtagct atggtgttat agtaccacaa ctaaccgagg aagtaaacaa
     8221 ctttttatcg ttttgttgga agagatagag gatcgcattc ttcctctgat ggagcatctt
     8281 caagacccat agcatatcgc aaagcatact tcatcatcag gatgtctttc gcacagtcat
     8341 gaatagaatc atgtgcaacg aatccatcta aagttccctt tggaagagga cacgttgtca
     8401 tatcacgaac aagcagaagt gcttcaattc tagtacgaat atcacgctga ttccaaaatt
     8461 tacaaggttc taacttaaat gtatcaagct cattctcgga aacgccgtta agacgttgaa
     8521 tatcgcgaat aagatcgact aaaattggaa aatcaaacga cattccacgg caccagcctt
     8581 gagatttcca aggatcgata ttatgtgcat tgatgtaatc attaaatttt gcaataccgt
     8641 cgatagtgct tacatcttca tcggatggtg caatattttt tcgagcttca ggagattgat
     8701 tcttccacca ttcgatagta cttttagtaa aaagacggtg tcctttttgg ctttttaaat
     8761 caaatttgat tttaatgcca cgtgaaacta attcatcgaa tgtttcaact acttctggat
     8821 tagggtcaaa agcaattaca gccaaatcaa taaccgctgc tttttcacca cttcccattg
     8881 tttcaaaatc tataataaaa tcaaacatta aattttcctc gctaaatcac gaatttgacc
     8941 tacagtatag tcttgaatat aaactttatt aataggctca tcaataaatt ttgccataga
     9001 ttcaatatct ttttgtattt cttcaagact gtatactatc tttgaagctt tttcgcgaat
     9061 agtgatattt tcaggacccg gattttcttg aatgacaact ttaacatttg tcataagaga
     9121 tttaaactgg taccaactta attcaatcat taataatcgc ctcataaaga tagctaattt
     9181 cgcctaaaac ataatcattg attgtaacag ttttaacttc accgcaaaag aattctaacg
     9241 caattaaatc tcgttcaatt tcttctaatt gaagcatcaa cttactagat tcaattttta
     9301 cagtttcacg atttttgcta taagctattt cataaatttc gcttacttta tcttgaagaa
     9361 gataaaactg atctttagtt atttccacga atagcttcct caaatttaat catacataaa
     9421 acacatcata acgaccacgg gtgacaccaa cataaagaag ttgttgagct aattcaacat
     9481 ctgcataatg aatacaaggc gtataaatga aagcacggtc tacagacata ccctgcgctt
     9541 tatggaatgt tgatgcagga agtgctttca ctttactaaa ctgtgattta gcatcccaaa
     9601 aatcactcca cggagctttt ccgcctttgt tccaattttt ataagtttct gctgttttag
     9661 ctaaaaatag gttaaactta tacaattctt cgtcagatga aattatttta atcttttcac
     9721 gataatattc atcatcgcca taagtttcta ctgttaaatc ccaatgacga attagatatt
     9781 ctccaggaac accacgggct ttaacaaacg ttgatgtata ctctgcttct ataatacgaa
     9841 ctaattgtcc gttattaaaa ataatttctg acacaggctt tccatcaatt ttatatgttt
     9901 taaataatgg ttcctgcatt acaataattt caccgacaat aaaatcttta tcagtttcaa
     9961 aaatcttttt acgaataatg ctatttaact tgtcaacaga tttattcgta aatgccatta
    10021 cgcgattttc aaacaaatca tctagtgatt tgacgattga aaaataattt accataaaat
    10081 cgcgtaaagc ggtatcacca gtaaatccac gtactccatg cccgtcaaca actttatcat
    10141 aattccactt accgttgcga acgtcagtag ctacatcaat aataggagca ttactgcgtt
    10201 taacttcagt gagttcacac tgataaaaat ctttatgtgt aaagaatgga ctgatataag
    10261 cagtattttc tcctggttca acaggtctga tttgcttatt atcccctatt ccaattatag
    10321 tacaccaagg tggaatagtt gaaagcagaa ttttaaatag ctttctatca tacattgaca
    10381 cttcgtcgca gattaatact ctgcatttgg ctaaatcagg tacttctttt tgttcaaaaa
    10441 gaacattttc ttcatatgtt actgggttaa ttttaagaat actatgaata gtactcgctt
    10501 ctttccctga tagttttgaa agaatctttt tagctgcatg tgtaggagct gctaaaataa
    10561 taccagttcc acccgtagat attaaagctt caatgatgaa cttagtaaga gtagtcttac
    10621 cggtaccagc aggtccatta atagttacat gatgtttctt ttctttaata gccttcataa
    10681 caatgttaaa ggcatttttc tggccttcgg tcaaatcatc aaatgtcatc gtaaattccc
    10741 tgcaattggt atactaacaa tacgcccagt atctaaaatt cgctgatata atctttgcgt
    10801 gtctacgtca ggcttaacat gtttaacttc tattttatta aaccaaaatt tacgtggagt
    10861 ctcaactaat cttggaattc ccttacctaa agctaatcga tactgctctt taagagtggt
    10921 aaatacttta tcagcaatct tccattcaaa aaatacagca ggacgatgtt catcaagcgg
    10981 aactggcgct gtaaatccgt ctttgtctcg gtaaactatc gcatatacat aaaccatatt
    11041 atcctcggat aagtttaaaa attgaacaat ttagcggata tcctcttttc agtttaagtt
    11101 tatcaataaa agacaaattt tgataccgct ctacaccttg aataatttta tcacacatat
    11161 catattgcat ttctgcttct gacaactttt tcacaatttt ccaatccgag cctttaagaa
    11221 gaacgttcaa tttaacaact tcagcgcctt ctgctatgcg agaaccatca atacgtgctt
    11281 taagtgctat aattctcagc ttaatgtcag aggtctgttt tgatttagaa agctgagaaa
    11341 tgtgttcaat tcgattttca cgttttttct gtatagcttt aatttgatta taagtctttt
    11401 tgattttagc ccatttcttt tcatctaaat ttagtttatg aacttttttc gcagatgaac
    11461 gaccaattcg caaagcaaat aaatcacgct tttcaatcaa ctcttctaaa gtataatcag
    11521 aacgaaatgt attatacttt ttctttactg caataacatt ccctttaatg tatccaacgt
    11581 tattatcaaa acgttctaat gataatttct ctccttcaat acgattatca aaaggttctc
    11641 ccgagtaagc acaaactttt tgatctaaaa tgttcttaat gtaattgaag tctaagttaa
    11701 aatctttaga acgtcttttt gcagatgcct gagtatgctc taaacgacgt ttaattttac
    11761 gaatttggtt attagacagc ttcatatttt tctcacatct tacggacggt taactactta
    11821 tactataaca tttttacttt aacttgtaaa caactttatg aaaaatgctt taaaactttc
    11881 atggtataat gaatctaagt ccttccatta tagattaaat ccttcaaaat caagagtata
    11941 gatagtgtat gttgaacact ttttatactc atatctatct gcaattctaa atacacttcc
    12001 agctggtatc attacttctt gttcatctga aactaattcc atattacgat aacgatgact
    12061 atccggaaac ttaaagtttg gattgtattc tttacagcgt agagctttta tagcatactc
    12121 ctggaaattg aataccatag gagctttgaa ttcaaaaata acttgtgtgt tatactctaa
    12181 accagaagca aaatgtagag ctatattttt atcatatgaa gctgatacga ctttatcaaa
    12241 tgtaataata tcaattcctt gatttaatac ttgtttagtc tcagctggaa cacctctcca
    12301 aagaggttta tcgtttggaa ccaaacgaga tttgattatt tcatttaacc aagaatggtc
    12361 atctggttta ttagtaatac aatgaattaa aagttcaatt tcagataaat taaacccttc
    12421 agaaagtaat tcttcacgaa tagaagcacg caccgatgca tccattgatt ttattttaaa
    12481 atcttttagt tgcattactg agtatttcat tcaactacct caatatcata aactttaaat
    12541 gttccaaatg aatcgtgtaa tttttctttt gaaatagaag ttattttata ctttccaatt
    12601 ggaatcatcc attcttgttc acgcacaatc atcattaagt tatcagtacg ctctgaatct
    12661 aatccatcag tatcttcata cgtgtactta aactcagtat taggagaaga aagtataata
    12721 tcgctgatat ggtcagaata attaaaagct ttatcagttt ttaaacgaag tattgtttca
    12781 gtgaaatatt cagcataaga aaaagaacac gctgtatgca aactagtagt aaatgaatct
    12841 accctgttcg ttgaaaacac ttctccaact tgtaaatctt taatgagttc ttttgtcgat
    12901 tttgatatac cacgatataa ttgataaggc gatttagtta aatgcttttt aatgatttca
    12961 tttaaatgct tatgaagagc ttcattcttt ttggcttcca tacattgcca aagaacagac
    13021 tgctcaaagt cagtaaattt ttcacagacc tttttataca tatcatattg aaaatcaacg
    13081 ctttcagctt ttatagataa ctgttcaaca tctgcaagat taataatcat gatagcctcc
    13141 gtatacttca gaagctatca tatcatcgtt agaaaggaaa gtaaacaact ttttgaatta
    13201 ttttgcccag ggagcccaag gcggagggtc aagatggtat gaagctagtt cttctagaag
    13261 agcatctggg gcttcaattc cataattctg taatactata cggtactctt tcttataatc
    13321 actagaatca ttctggttat tcgtagaatg attatcttct aacatctcaa ataaatccat
    13381 attaattcct agcgataaaa accaaattta cgattagttt caatgatctt tctttcttct
    13441 tcggacattc tccagcgtag tccaacatca aaatgagccc agaccatcct aacaaatgca
    13501 tttatatctt taatatcttc aataatgaat gttttacttt tagaaggttg actcgctaat
    13561 ttaactttat cgtcttcaaa catgtcaaaa agaccatatt catgagctct tttatagcct
    13621 ttaatagtta aagcttcaga agaagaaaat ggtgaatctg tattctgcaa aatatcttca
    13681 gtatgcttta taattagaat aatattttct ggatattttc tttcttttat atctttaatt
    13741 aaaaaatccg gattttctgc taaaggaata attaatgagc aatttttatc aagtgtattt
    13801 actgatttac cttctttaga cataaattct attgaatata attttgctac ttcaatcatg
    13861 tgatttcctt ttgcctacta atggaccgtc aggaatttta ttttcctgga tatatttctc
    13921 attttcttcc atcattttac tgccaatttt aagaagcaaa tccattgctt catttgcttt
    13981 tgctttagct tcttctaacg tcatatcttt gttcatgatt tatcaccata gatgtctctc
    14041 atcaatttaa gcgctgagcg ttctagtttc ttttctttct cagcactaat cattgatttc
    14101 atccattctt ctgattcatt ctgcatttct ttatttgctt gttcaaccca accgtcatca
    14161 atatacattg agtttggtct attgaaccat tcaagcatct tcttcagaac tttcattcgt
    14221 tttacctaaa acaatagtag gagcatcgtc aaatttatga atttttagca aatttggatt
    14281 taaattattc cataaagagg taataaaata tgatagcgca ctttcgtccg taattataaa
    14341 tttatttcct ttatctattt tccaatcata tattgaatca tatgaataga aggataacgg
    14401 tttattatta taatatgctt cagcaacatc aatatagtta gatttagtaa atgcttgaat
    14461 tgccataaat ggagaatttt gtacagtttc aataattccg atctttttaa gttttatttc
    14521 aacatcttct ggaattggca ttgaaataaa atcttctact agatacatat tattgtcata
    14581 tcttttatca atcattactg ctacagtaat tggaacatcc ttgacaaacg ccatactaat
    14641 actattgata gacatttcaa acaaaattgc ttccataatt ttcctcaatc acaagatgta
    14701 gatgaacaac tagaatcaca agaacttcca catgaatcac ctgcccatac atgaacagga
    14761 acattagtat catatgaatc agaactagac tgtgtattct gtgtgttaga tgatgtagta
    14821 ggtgttgacc agcgccaagg atttttataa tattcttggg cttcttcata agtcatagta
    14881 actgcttcta ctgttccatc tcccatataa acatattcaa ctacagttaa aggaaggtag
    14941 tcatttgaaa taggaactac accttcccca ggagttgtag agaaaaaatc cgtaaagaaa
    15001 cttttaaacc aattaaagat aaacattaca aaaagcctct tttgaattcg acttgcttct
    15061 caccataatc atatcgaatc tctacattaa attcgacaga accatctgcg tacatcataa
    15121 atgaatgcac aacaacttct gtagaccatg gttgtagttc atatttcttc attacatgtc
    15181 gtgaaatgat aatatctaaa tcttcatttg gtttaatcca acgatttaac atagtactct
    15241 cctctataag ataattctat tataccatac tcattttgga aagtaaacca tttaaatgaa
    15301 aaaaggactc ccgaaggagt ccttgagtta ttaaccagtt actttccaca aatcttcatt
    15361 tgcagcaatc cattcagtac gttgattttc ttcatatact gtagaatatg ctgctttttc
    15421 tgaagggaat gtctggtaat gagcgccaga aattttgtga acgtcagaat aaagagggaa
    15481 agctacagaa atttcctttc cttcaatttt cttatttcca tctaatttct gctcaaatgt
    15541 tttgatatta acataaccgc gagtactagc catgtaattc tcctttattt aaattacatg
    15601 attatttata catcttcttt tctgaataag taaattaaat tcttaagagc cgaacttgtt
    15661 acatcatatt ttcctttaag cgcctttaca accgggcctg ttgctggttt acctaaagaa
    15721 acccataact cgtgtatttc gcttttaagt ggttcatgcc aatgcggtgc ttttctttgc
    15781 gcccttgaag ttccttctga aatcttttta tttccgccat tcgaataaaa ctttttcatt
    15841 acttcagatt gccgagcttt tctttctgcc ctattttggg ctatacgttg tgaattcttc
    15901 atccgagttt ttgtttcagg attgtttaat ctaagtttat gttctaatcg ttgttgctca
    15961 gtccattttc ttccttctcc accctgacca ccaggagaaa tattaatgca agtatctggg
    16021 tgtttacgtt ttaatgcaga tattagctca cgttcaactt catatgattt ttctctagaa
    16081 ccatggcatt ttgaccatcg tattttataa ttaaatccat acttacgata tatgttccat
    16141 agtattttac ctgaacccgg atatttatca ttatatggat ttacaataaa tgattcatgt
    16201 ttcccagcgt accaaaagac gcctttcggc gtcctaactt ttactatata tgttctataa
    16261 aatttttgtt taatatccat tatcttgacg ttcaaaatta tgtttgttct tcagataata
    16321 aagtttaaag atttcttccg cattcattcc aaggccaaca aacatattta atacgaaatg
    16381 aaatatatcc acaagctcaa atttaatttc gagctggtct tcgggggaca tttcatcaat
    16441 gcgtttttct tgcgcttcaa tataacgtgc tttccatttt ttccatacag cagaagcttc
    16501 tttttcacca cgtgacattt caccaagaga agtcagaagt tcgcggaatt catcatcaat
    16561 acagtctttt tgttcacgca tccaagaaac aacatcaccg gcagtttcta atttatctgg
    16621 atgatagcag tattcgcgga cattagccaa acgaatctgt aaaaaccgct gcatatcaag
    16681 cataacttgc agcggatctt tttcatcacc gagaatatcc cagtattcat tttgagcttt
    16741 atcaacacct tcgatcaaat gagcacattc attaaagtga gccattagtt ttcctttcaa
    16801 ttcattaata agttaaataa ttatatcatt tgagtatgta agcaattaat taaaaatata
    16861 tacttcatca gttccattct tttctttgga atgatatatg ttaaagacgt attttttatt
    16921 aagatgcttt acattatatt ttttagacca ttctttaaga agagtgtttt cctttccgtg
    16981 gtgttctaaa acattcgact gcccaaattt tattcctcta tcatttaaag aatctaaaag
    17041 atttaaaagg tctttttctt catcttctga ccaaaattta ttataatcag caactgttat
    17101 gagatacgga ggatctacat atacaaaatc gccgtctaaa attttaacat ctttaaaatg
    17161 caatgaacta aagattattt tatcacaatt ttgtttaaag tgattatatt gtttttcact
    17221 atttttgttt atagttcttt ttccaaacgg agtagtaaaa tttcctttat cgtttatacg
    17281 aatcatatta ctaaatccgt gaaaatgaag aacataaagt aaaagaggat ctctagtttt
    17341 attataatct tcacgtaatt tcaaaaactc ttcttttgat gtttttgata gtttgtattg
    17401 ctttattact tttaaaacgt catcccatga tacattaata agacgcttat acatttcaat
    17461 aattggttct tgaatatcat tggccaatac agggccatta acattcaaag acactgataa
    17521 acctccacaa aataaatcca cgaatctgtt atattttgga aagtgagatt tgagttcagg
    17581 taataatgat tgtttattac ctgtatacgc gatagctcct agcattatat tctctcattt
    17641 attgcagcaa aaatgaatta tacaattctt catcatatgt atttgatagt aatactaaca
    17701 cgttttgcga taaatattaa tttaaaggag gatatatatg gtacaaaaat taatggcact
    17761 tgttaatgcc ataaaaggta ataagaaacg tatagctttt actatttcta ctatggtagg
    17821 aattttactc tggaacttta ttttatcacc tgttgcaatt gcacatggtg ttaatattcc
    17881 agtagttact cttgatacat tcgtagattt agcatttgct ttagttgggt taatttaaat
    17941 cttagcatat ttagatagcc gcattttagc cattaacccc tgggcaatat tatttttcat
    18001 atattccata atttgttcag gggttgcacc ttcctttcta atcatatcat taacatcttt
    18061 tgatttccag ggagatttat cccaaaacat aaccctttct cctgcatcaa ctaatttagt
    18121 cattcgttta atagtgtcag ggtgacgagg ttcattatct aagacccaca cacgtctatc
    18181 tttaaatgga acaacttcta ggtctaattg accgcccgta atagctatac cattttcaat
    18241 aaaaagtgaa tctataggtc cttctagaac atatacatca ccatctttaa ctcgttcgac
    18301 tccatagatt tttgttgcct caggataagc ttcgatggtg atatattttt gaggagcatc
    18361 tttctttaat gcacgtcctt gaaaagactc agcttttcca ttagcattat aaattggaat
    18421 aacaagacga ggctcagaaa tttccttttt gtatgttccc ggtgctatgc tattaactaa
    18481 tttaggccat tcggttgtaa accaaagata tttccattta tcctttggaa tacaacgagc
    18541 ttttacgtat tttataattg gatggtcttc cgccagttta tctaatctaa cacatgacgg
    18601 aagagattta attattttct tctcgggttg tttaggaagt tctttaggtt tttctattgg
    18661 acgactttta cctttttctt ttcttatttc aaagatatac tcacgatata aatcgggttc
    18721 aaactccttt aaatatattc cgattggtgc atgatagtta cagttataac aatgaatatt
    18781 tccttcatta ttatcaccat aataccatcc acgggcttta ttctggtcgg tttttgaatc
    18841 tccacaaaca gggcatctaa accgtaattt aaaagttgaa ctattattta cttgtgtgaa
    18901 tttaggtaaa tgagctaatg cacggtatgc aaactcatta tcaatccaag gtattgatga
    18961 catttttact cttctttttc tttagattcc tcttttttct ttttaggaat ctgttcagga
    19021 cctttattta ctacagcgcc tgatgttgtt ccaatagaga tattttcagg attaccacct
    19081 gaatctccag cgaccatatc ttctttgata aattctttaa atgttttcat attaacctct
    19141 attcataaaa gcattaaaaa tttggtcatc aatagaaaca tttactttag gctgtttttc
    19201 agatggcaat tcatatccac atattacaat tttatgatca atatcaaaat acacagaagc
    19261 aatatgatta atgatatttt cagtaaagtc taaatcaaca tcaatatctt tttgaccaaa
    19321 gcccaaagga taaataatgc gagtaattcg attatcttta acaaagattc caccgacata
    19381 ctctgtgctg cgtttaaagt ctacacgccg acgaaatgaa aaatattcag gctctttatg
    19441 agctcggctc ataggacaca acgaataact agaataagag atgtcaaatc ctacgccttc
    19501 aatatgaact aaattgtcat gattaaacca attataatca tatgccaagt ccattagatt
    19561 gtcatatgtg aaaagcaccg gattaacatc attggtcaca agcatataat tagcaactgc
    19621 tataatttca ttatttttaa cgaatacaaa ccgtgattga tgcgaatggc ctggacctgc
    19681 gttttcacga ttaatgatat aacactgggc acctttatat ttgtacgtgt ctttacactt
    19741 gtgcatttga taaagcatta ttcacctacc acttcagcga tgatattttt gttattaaag
    19801 tttttatcgc aatacagaac ataattatac tgcattacac caccagactt aagctgtttt
    19861 tgcacttcag ctttcatttc aggacgatca cgcttaacga tattcataat atctgcttca
    19921 atttgagttt caacctcagt ctgatccgca gtcatagacc attcgcacaa atctttatca
    19981 taacctgcca tagcaggctg agcagcacaa gaagctaaag caaaaattgt agcaaagatg
    20041 aattttttca tgataatctc ctcagtagtt tatgtttata tagtatctca atttccaaca
    20101 aaagtaaaca gttattttaa aatttctgcg taatcacatg ttacaaactg tttctctaac
    20161 ttgacgattt tacgaaagta tcttttgcat tggcgaatct gcctcttcgt agggcgaaca
    20221 gcaaacttaa taaattccac tcgaccaaat ggagggcttt cttctgctgg aatatctaac
    20281 accaattccc acgtatctgc aataagtgct ttgaattgcg tatttttcct gacgttatac
    20341 ggagtaggtt taaataaaac aatatgcata ttatcctcgg caatccactt cacatacttt
    20401 cttgtcatca atgaaagctt taactaatgc tttattaact tcagcatatt gagtagtagc
    20461 ccattgaacg tcatctttca tcattgtgat ttctttagta aacatgcttt cattcttaaa
    20521 ccaccccata aaaactacct ttaccaattc cataacaatc tcctcattta accgacaaga
    20581 ctactatacc atagtcttgt cagcttgtaa actaaaattt taattcattc gccaaagcat
    20641 ctaactgagc tcgagtcgat tcatttcttt gatagcgatt ctgctcagcc tgaatctgtt
    20701 gtgaacctgc tacttcgttc acttcagttg gagtagaatc ttgttcaatt tctacccatt
    20761 tttgatttcc tttttgaaca cccatcaaaa acttattcca cttattctta tcaccatatc
    20821 gtgatttgat ttgcttaatg agttgttgtt cagcagctgc tagctcctcg gtttcaatga
    20881 ccgcaagcat aaaatcggct gttgctggaa gaccggcaga ttctgcaata tcgctcatgt
    20941 taacatcgga agagtcccaa gcttgtttac caacctgtgc tgcagtccaa agaacagttt
    21001 cggtttcaac agccagagca cgtaattcct ctgcaatagc tttaacagtt gtgtaactat
    21061 tttctgaata aactctaatg cggcaagatt tacaaatacc tagatagtcg acaataatga
    21121 ttgttggaac aaaattcttc ttgagcttca attcgtttaa aagtgatcga aatgtattag
    21181 cgtctgctcc accagtagga tactgtttaa cgattaaacg accaagagta gatttctcac
    21241 gccatttttc catttttcct ttatactcag cgtaagaaat atgcccatca tcaatgtcat
    21301 caagagaaac atcaagcata ttagcgtcaa tacgtttagc acagacttct tctgccattt
    21361 ccatggaaat gtaaagaaca ttatgtccga gctgtaaata atctgccgct aatgaacaca
    21421 atcctaatga tttaccaacg ttaacgccag ccattaaaac gttcagtgtt ccagtttcag
    21481 ctccgccttt cgtaattttg ttcagaattc tgagtttaaa tggaacctta cgagctttat
    21541 tcatataaga tagccaacgt gcttcgtagt catccatcca atcatgacca acgtaactat
    21601 caaatgaaat tgataatgcc tggcgcatga tgtcaggaat agcaccaaca tccggcattt
    21661 tcttatttcg tttttccgga ggaagctcag cattagtttg aatttcgatt attttagacg
    21721 tagcattaaa catcgccctt tgctgaacat atttttctgt ttcttttact aaccagctgt
    21781 ggtcttccgg agaatcagcc agttttgaaa taagtgtttt tacaccagaa tattctgttt
    21841 cagtaaatga actattttct aatgcaacat ttaacgcatt aatagatgga acgctatggt
    21901 actcattaac atgagattta attaatttga atgtattttt agctggacca ctttcaaaat
    21961 attctgaatc catatatggc caaacttttg aaaaataagc ttgatcaaat atgagatgag
    22021 aaagaataat ttctaccaca cttactcctt aaaagaattt aaattttttc tttgaccttt
    22081 tattaaatgc atcttgcagt tgcattgtaa tacatttttc tacatgagga gctaactcag
    22141 cttttctttc ttggtcaaga acagcaaagt ccattacaac ctttccatca acccaatcca
    22201 gtttagttac atacactata tgcgtagaac catcttctag tttaatgaca atctcctgga
    22261 taacattttc catagcagat ttaattatct taagagactc attaaaaaga cgttcttttc
    22321 tttcttcttc cccctccgaa gagggggatt catcgataat ttctagatct aaatctaaat
    22381 catctttatt cattaaattc ttccatatca cttagctgtt cgaggtcagt ttctaaatca
    22441 gcagctgatt tacttttact ttctggagat ttaaattttt caacctttga gttaatcaat
    22501 tcatcaactt cagcttcaac aatttcatta ctatcaatag cacctaactg ataagcacgt
    22561 ttaatagcat ctcggaatgg ttgatgctta aataaaggac cccagaatgt agtgcagttg
    22621 gtatcttttg cacgccaaga tttttcttcg cgaatcatct cgccagtttc ttcgtcaaga
    22681 aattcacgag cataccagcc atttttaggt tttaccacga atcctaattc tagagccata
    22741 tctaacaatc cagaataagg atcgatacca ccgtcaaatt taacatcaat aaagaattta
    22801 cttttttctt taacggtacg agatttttct acatttagaa caaattgata cccctgaaga
    22861 tcagaaccat ctttaatctg gcgtttaccg ataatgaata cggtatcagc cgaatacatc
    22921 ggtccagtac cacctcccat aactgtttta ctaaacattt cttgtgtttc gtatgtatgg
    22981 ttaatagcaa tacatggaat atttttagta ctaaaatagg gagttacgat acgaaataag
    23041 cttttcattg ttttagctct agtcatatca ctaacaactt tttcatttaa agcatcttca
    23101 gtttctttct tagaagctaa gttaccaagt gaatcgataa aaacgactac cttttcgccg
    23161 cgttcaattg catccaattg attaaccatg tcaatacgta attgctcaag tgattgaacc
    23221 ggagtatgaa ttactcgttc tggatcgact cccatagacc gcaaataagc aggagtaata
    23281 ccaaattcac tatcataaaa caaacatact gcatcaggat attgacgcat gtaagatgac
    23341 accattgtta atccaaagtt tgatttaaat gattttgatg gacctgccaa aattaacaga
    23401 ccagattgca taccaccagt aatttcacca gaaagtgcaa tattcatcat aggaattttt
    23461 gttcgaacta catctttttc attaaagaat ttagatgctg ttaattctgc agtcaattta
    23521 gaagtagaag ctttaatcaa acgagatttt aaatcagaca tataatacct tatagtagtg
    23581 ttcttgttcc acgaaatact tcgagcattc ttgcataaga tttatttgga aatccagctt
    23641 caattgctaa ttttttaagc ttaatagcac cggattttcc agagttttcc catatttctt
    23701 taatcttttc aatgttatcc cacattattg ggtcacgttt atgtgatggt ttatttctat
    23761 tataaccata tggattatta agcaaagctt cttttcgttt tgctttagtt tcttctgact
    23821 gctttttgcc tagctgggct ttccggcaaa catcactaaa tccaagatgt tttggttttc
    23881 ctttttgagc ttttgaaatt ttttctttgg tttctgatga aactctataa ccaattcttc
    23941 taccaccctc tccaccaatt tttaaattat aagtcatagg atcatttacc acatctattg
    24001 ttactaattc tctttcagca tcacgggctg atttaaaatc tttataaaac ccaagaatgc
    24061 ttaaattaaa atttttctta ccatactttt tcttggcttg tgctaataaa gttcctgatc
    24121 ccatataacc atcatttaaa tcatcggttg aatgagttcc atagtaaatt ttattattaa
    24181 ctaaattagt tataacataa gtataattat atttcttttc tttatgtctt ttcatgtcat
    24241 taatcaactg ctattcgatg aacttctctc ttttctaatc aatataacaa aagaagtccc
    24301 aaaaagcaaa cagacctaaa ccgataataa gcaataaagg tcctaacatt tattccaccg
    24361 gttaaagata aataactttc taataatagt tcataatttt tataaatcaa tagctttttt
    24421 gaacgcatct tgccattcgg ctttctttgc acgggtttta tttaaaatat catgttgaat
    24481 agaaagcatc tctttacgca aaacatcact gtgttttaac tcattgactc tatcaatgag
    24541 ttcagcacga ttatttacat aaaaacgagc atcattaata attcgatgtt tggtatcaaa
    24601 ttcttcgtca attagcatca ctgcatcaga tgccattgtt tcccagacgc gtaaggtaat
    24661 aaagttgtca ttataattct tgtcaccaat aattaatgca gcaatagctt gactattctt
    24721 ttcagatacc atgttcatag gaatttttcc agtgaacacc ggagctttgg tccaaggata
    24781 tttaggattt ttaaactgtt tttctcgtgc attgccaaaa aactcaatat ttaaaccggt
    24841 gtcaaataag aattctacca tcttggattc gcgttgaccg gaccgaaatg aaccgccata
    24901 aataacatcc aaagttttct tggtaggctt agataattga aaatcgttca tatgaatttt
    24961 atattgttca ataggaaaat attcaaattc aataacatta tcaactttct tatgcgcagc
    25021 cttagcaatg tctaaattta taccttggga aatcacttta attggtgatt taattaatag
    25081 ctcttcttca gtgtacaaat atgcccatgg tctattttta acatttggcc aagactgcga
    25141 aaacggcaaa cgtatatctg taaataaata ataaatttta cttttgtatt ttgccataaa
    25201 tttttgcgca gataaaattg ctaaattagg tttaccgcca aaaaagttaa tagaagaatt
    25261 aacaactatc aaacggtcat aatcattaac atctacttca tcaaaagatt tagtgtaaac
    25321 accattttta agagaaataa tgtcgacatt aagacccatt tcagaaataa ctttaaaaag
    25381 ataaatagtt tcagaagatg gaacagtttt aaaattaata acattattac ccatattaat
    25441 tatagcaatt ttcatattat tccttttatg ttaaacgatt aagcgtattt tcctacataa
    25501 tcttttttcg aaatatgtgt ttcgccagtt ttccaccaat gatcaaccaa ataaaaatga
    25561 cgagaataca catgtaggct tccaacattc catataatgg aacctgcttt atactggcga
    25621 gttgaatcac ctgcattcaa atcagatact aatttatcta atacgtattt ttgccatgca
    25681 taatcattac ggaatccgaa gaccacgtca tttgagcgca tgttaacaac cgcattgatt
    25741 ttcttgtcac gaatcaggta ttgtactgta ttcgtgcaca tgaaatctga cataccatct
    25801 ttattatagt caaactgcat agatggacga gtataaatca tgataccacg tcgagaatca
    25861 ggattttgac caagttcagc taaacacatg tcatactgag catagttatc ttctgaccag
    25921 atagcccaac cataattcga gttaatttca cctttagaag atgctacttg ttgccaaatc
    25981 ttcggtgttt cacccggaat atctttaacg aacaagcttt tagatttata ccattcaagt
    26041 tcacgctgaa tgtattcatc attaagagcg ccaaaaataa acggttcatc tgctacaaat
    26101 gatgcgccaa taatttcaat agttttaaca cctgttttat caactacgaa atctttttct
    26161 tttaatgcaa gccccaaatg aagacggatt tcttcaactg tcatagagtc actaatcatt
    26221 taaacctcaa ttgatacatt catatttaac ttgtaacagt aataaactcc aacctaaaat
    26281 aatagttgga atcataagag gaaccgttac actatagtat atacttatta taatcatcaa
    26341 gattaaaagc aatgctgcta taattttgct tttcattcct tctctctgat gataattacc
    26401 tgatttggct gcgcagactt tttagtttca cctgcaattg accaaataaa tgtaataaac
    26461 caaccaataa ttgaccagtt aaacagtaaa gatgcgaaaa agattcctac tgtcgatttt
    26521 gacccacgca tcaaggcgat aaaccatgga agcatgtata taataatagc caacacgcct
    26581 gaaactaaaa ccataaaaat tgaacctgct actaaagttt ccatgttttc ctcacttagg
    26641 tcaaattttt tacacatgaa ttataagaat tcactacata ctccatcgga gcgtttttac
    26701 ctgtacgcca ctggtaatta ttagcccaat ttgcccaaag ctcagcgcag tagttttcaa
    26761 ttttttcttc gcgtgtaatt acatctgaat tacgatatgc ttgagcagat tcatctggac
    26821 gaatagcttc gtcaaaattc gcctgcattt gttctactgt ctgttttgga gcttctttat
    26881 aacacttgac attaggatta taaaatttgc ttgaacagtt tacaattttt cctacatcag
    26941 actgatttac taccggtcct tgagctacac aaccagcaag acctaatgca ataaccaaaa
    27001 tagcgatttt catttcattc tccaaatccg tatcagtagt tgatagttgt atagtaccat
    27061 ggaagaacag tcttgtaaac agttttgtga aaaaattttt agggaatcca aagggtccag
    27121 aatcatctct ttttcataag tatagattta tattacttgt atgaaaaagg gacctggagg
    27181 tcctagattt attctatcag ccaaacagga agtctaacga agctttttct tcatagtcca
    27241 tgccagccga ttcacacata cccgcaagcg gtttaacaaa cgatttttgg aacaaagttg
    27301 agtggtcaat ccaagatagc acatcagaac gaatttcttt tggaagttct gtacccgatg
    27361 gccaagcaat gcacttgtca ccaaatggat ttccttcacg taatggaaga accattactt
    27421 tatttccatc caaaattgga gctacaccta aaccgctaac agctcgacga taagttagca
    27481 caccacgaat atggaacggg catttaaatc ctggccaacc tttatcatca tatttcgcta
    27541 tatcgttcgc agtttttact tcagcaataa ctttatagtc aagttgacga tattctttct
    27601 cgaagttctt gtagtattct tggacagact cttcaccttc ctgaagaata cgacgaatac
    27661 tttcttcgag agcttcttgc actgcttttg gtgttgaact ctgctgagtt tccataccca
    27721 tgatttttag atgcggttca gcaaatcgct tatcttccat atcataaacg ttcagagcat
    27781 aacgcttttt cgctttccaa aatccaccaa cgccctttga accaagcgga gggcaagaaa
    27841 tagcttcacg gtccatatgc atcagatgct cgcggttatt catataatca cataactcac
    27901 gatatgcaac atcaatcata ggttccatct ttttcttacc gaactgattc atgaattcaa
    27961 ccaaatcgtt ctgctctttg aatcggtcaa gaccaacttt ttcaataact ttatctacgc
    28021 aaacatatac cgaatcagta tcacctgctg caatgaaatc ttcatcatta gttccgcata
    28081 ctttattcag atattcatta attttacgag caatccactg aataccgact tggccgaaaa
    28141 ttgtgatagc agtagcattt cgcaaatcat agtaacggaa atgaatatta ccaagagcac
    28201 cataaagact gttaatgaga attttacggt tcagctgatt tgtattagca agtgtagctg
    28261 ctttttcaca ttcttcaatc agactattga gaacagattc ggtgtaattc gatagttcat
    28321 ttaagaaatc atcactgaac ttaacatatc gttcaacttc tggtttagtt gaacaagacc
    28381 ctgcgccttt cataataatc tttttaatag cttcggcatt catttcttca gcgaacattt
    28441 tctttttcca gtctttacgc tggaaaaata ctttagcgat ttcctttgga atgatacctt
    28501 cttgatgttt atcatacatc catccattcg gagaacaaga atattcatca ctcggtttag
    28561 gagctgttcc tgcgatatat tcatgaattg gatgaacttt aaactgacca cgaatagttt
    28621 caggactaat gttaacctgg cgaataatgc tcggatacag agacgtcaag tcaaaactca
    28681 taatgtatcg acgtgcaatt ggtttaggtt caaacacaaa tgcacccgga aaactctgtt
    28741 taacgtgcga accttgttga ggaataacct tatgttcacc tttcaatgag ttaaaaataa
    28801 tagcatccca agttttaata ggactcatta caccagaaaa aggcatttta gcgtaataag
    28861 acatacttaa aactagatcg ataaacccac gaattttatc gattgcttga actgattcta
    28921 cgtcaatgat gttataacta atgtatcgtt gatgattagt ctcacgaagt ttattaatag
    28981 gaccgtcgta tggtaattta ccttttttgg tttcatgttg agcaactgat tccaaagaga
    29041 atgacggcaa attagtaaaa gcgaatttct tgtacaaatc taaataatca agaatagata
    29101 cgccatcaat agaataaatt tctttgctac cgtacatatt ttgaattagt ttagatttta
    29161 cccgaccgat tggagagaaa cgtttcatac tacgttcacc cagaatcatt ttaacacgat
    29221 tcatgatata cggaacgtca aacccctcaa tattccaacc agtaaaaata gcaggtcgtt
    29281 tctgttccca aagattgata tattccatga gcatatcacg ctcattatcg aatggcatat
    29341 aaattactcg gtcaagaatt tcttgaggaa cttcatcacc accttcacag tcaagcttag
    29401 cagctaactt tgcatcccat tttgatactg aaccgtacat tgaattcaaa aggtcgaaaa
    29461 cataaaaacg atcgtcaatt gaatcgtaat gagtgatagc atcaatttca tattctgctt
    29521 tcattgggtc aggaaattta tcaccagtaa cctcaatgtc acagttagct acacgaacaa
    29581 attttcggtc ataaacaatt tctgaaccat atgtatcact tatataagcg agtttaaaat
    29641 cgttcatacc gagagcttcg agaccgatgt cttccattcg cttcatccaa tctcgagcat
    29701 ctttcattga tggaaatttt tgaggagcgc agtttttacc atagatgtct ttgtattttg
    29761 actcttcctt acaatgccta aacatagttg gaagatattc tacttcacgg gtacgttcct
    29821 ttccattttc atcaatataa cgttcaacaa tgttatttcc gactgtttca atagagatat
    29881 aaaattcttt catagatatt ccttagttta tagcccgagt tattaggctc ttgatatatt
    29941 atactccaaa taaggggccg aagccccttg cttaattacc aatcgtatat ttaggaacga
    30001 gcttccattc atgtttttgt ttaaaagaaa taactcggaa gttattagtt aaatctttca
    30061 taaaagttct ttgaccagga acgatttcaa ttagtcccca atcttctaat agccatgcaa
    30121 tcgaatcacg acgaacttca tcttcttctg tcatttcaac ttgacgacca tccatacgaa
    30181 gcatttcttt aaaatgaacg atatagtata gtcctttttt ctgaagaata tgacaggact
    30241 gatatagaac tttatcttta ttattagcaa ttcccatacg agtcaaagtt tcttttactt
    30301 tcagaaaatc ttcaggtttt ttaagagtaa tttcaatcat tttaccattc caatgctagt
    30361 tttttgagtt gtttctgttc ttttacgttc ttagtcactt ctttcaaaaa atcatccgtg
    30421 actaaacctt ttagttcttt taatactaaa ggaagttttc catttttagt aagaattgat
    30481 ttatagttaa ttgcatcatt tgtattaact tgataccgct tagcaagtaa cttaataatc
    30541 aatacttcgg tggaatcttc aaccagtttt gcccatttac catatctttt accacgagga
    30601 actgcagcca ttagataatt aaaatgagct tcatcactta agcctgatcc aattaaattc
    30661 atagcatata cagctggcat acactctgga aattgtgata atgcattttc aaccatgaat
    30721 tttgaataat ctttttgagc aatagagcat ttagttttat tattaatagc tccaattatt
    30781 tcaaaaaatt cattttctgc tttttcttta aaagaatcag cagcggattg gacagctgtc
    30841 caatcttttg aataccaagc aacttgatgc tcgtttaatt gaatatcatc tttaaataag
    30901 ctcatatcac ttccactgca tttcgcatgc taattgaatg aaaagataag ctaaatgcaa
    30961 ttcagtatta gctgcaatac catgatactg attattttcg ccgacaattt cgtacatacg
    31021 aataatactt tgtggagtta cacgtgaata gatttcttcg gcaagtttac ccacgaacca
    31081 cgaataatca gccgcatatt ttggtgctaa agctctgagt tgtttaacat ctttattttt
    31141 gagagactca agaacatcat caatagcacc acgatcgtta gtaaccagtg ataaaatacc
    31201 agcatccaaa acacctttag acgaataact atcgagctcg ccaatagttt tacgaaaatc
    31261 aggaaaattc tttttaacca aagctgctac aactttcata tcagctatag caattccttc
    31321 atgcttgcag atttcagtca atcgacgaat catctgcttc atcatttcaa ttttatcttc
    31381 atcagttggt tgaccgaatg taataactcg gcagcgtgac tgaagcggtt taataatacc
    31441 atcaatatta ttagcagtaa taataatact acagtttgaa ctataagctt ccataaagga
    31501 acgaagatgt cgctgagact ctgctaaccc tgaacggtca aattcatcaa taacgattac
    31561 tttttgacga ccatcaaatg aagcggcgct ggcaaaatta gtcaaaggac cacgaacgaa
    31621 atcaatttta caatctgacc cattcacaaa catcatatca gcatttacat catgacataa
    31681 tgcttttgct acagttgttt tacctgttcc tggagaagga gaatgaagaa taatatgtgg
    31741 aatcttacct ttacttgtaa tagatttaaa ggtttcttta tcaaaagcgg gaagaataca
    31801 ttcatcgata gtagatggac gatatttctg ttcaagaatg tgttcttttt catttacagt
    31861 aatcataatt tcctcattca agttttagtg taaattataa aggccgaagc cctctattaa
    31921 aaatcgtggg tagaatcagc ttcaagagct accacataat tcgcgtgttc accttcaaat
    31981 ttagcagcac cttgtttacc ttttgcccaa agcagaagtt tataatttcc tggttgcatt
    32041 ttcatatttg ccatattgat aatgaaatta aatgtatttt caccatcata atcaccaaga
    32101 gtcaaagaat atttaacacg ggtcagagca gaatcttcta ctttattaaa accgttaatt
    32161 acgattttac cttcttttac cgtgatagca attgtatcaa tttgcagacc acgagataca
    32221 cgcaacagct gttgaaggtc ttcagcttta atttcagtaa cagcagatgc taccgggaat
    32281 ggaattggtt tattaggagc aactactgta ctcggatcgg ctgctggcca aaaaattgtt
    32341 gagcgggcat cagcaatttt aatatttcca tcttctgact gggaaatttc tgcatcatca
    32401 ttaactaaag acagaatacc gagaaaaccg ttcaaatcgt aaattgctac atcaaaatca
    32461 ataacgtcag aaatatttgc ttccgcataa gttgtaccat taactgcgcg agtcataata
    32521 aattgaccgg atttaagcat aataccagag ttaatagtag cgaaattttt aagcagagca
    32581 gtagtatctt tagacagttt catgtaattt ccttcaattc aaatgagatt taattttata
    32641 actaatttaa taaagcaatt aacgattaaa atcagccgca attgtttccg caacaatttg
    32701 agcagcaaca attagacgtt catctgcatt accgcaataa tcatcttcaa ggcgttcacc
    32761 acatgaagtc ataataaatt tagcaccggc gtttagggat tctgtagtat gtttgcgcat
    32821 tagttcaatc catttattac ttacttcacg atcgatagct tcataatacg catgacgagc
    32881 aggtgcagat ttaattttgt tctgaataac ttccattgcg ttatcagaaa gagacaaaac
    32941 ccatgctcga cgaattttat tttggttttg tggatttgat tcagaacgca cgtgttttgg
    33001 ctgaatatct tttacatcaa cagtataatt cacagtaatt ttagtcataa tacaccttta
    33061 gtcataataa tcagtaacag tccaagcttc atttctattg gacattattt ttgtatattc
    33121 tgctttaaat gcattcctaa gcatagattc agtaactata tgctcttcat tagaaaaatt
    33181 atttctcaga atatatcgtt ttatttcagg aatagttaat agatgctgtc cagttgaata
    33241 ttccatgttt ttcctccata gagattatac tctaataaat taaagcataa tctcttataa
    33301 attaaaccat tacagtaaat cgaccaactt tcttcatttg aagatgctga ccatattctt
    33361 gcgggtcatg gtctttatgc gaaattataa aaacgttagt gtttttcatt gaatttataa
    33421 tattagctac acctttaata ccttcggcat caaatgaccc atcaaacact tcatcaagaa
    33481 ttaatgtact aatactaaca ccagatacga tagaagcaat atcacgccaa gtaaataaaa
    33541 gagcaatatc gattcgtgcc ttttcacctt cactaaatga agcataacta aaatcttcac
    33601 gaccacggga tttaattgtc tcattaaatt cttcatctaa tgtaaacaca taatccgctt
    33661 ccattatttt aagataatgg ttaatctgct tattaaataa tggaatgtac tttttaataa
    33721 tagcaccttt aataccagaa tctttgagca tatcagtcaa aattcctcgg tggtattttt
    33781 ccattactaa attagttttt gtcttaacaa ttttatcaag ttcttcttga agcagtgcta
    33841 tttcatcagc atggtcaata aactcagaag atgctttttc tatagccgct ttaacttttt
    33901 tagctttatc tactgctgcg atcagagatt gctttttatt gcgaatatca tttgccaacg
    33961 actgctgggt tttaatatta tctcggtatt catcaacaag aacttttaaa ttatcacgat
    34021 gtgttgaaag ctgttcaaac gaatgtgtgc attcagaaac tttatcttta attttagaaa
    34081 caactttatc accggaactc aattgtgaca aacaggttgg acataatcca ccttcgtgat
    34141 acatattaat gactttatta tacgagtcaa tttttgattt aattaaaaat gcttcttgac
    34201 cgattttatt aaatgcatca gtcgggtctt cgtccaaaac aatattaact aatctttcgt
    34261 tagcttcttc tatttccgat tttagcgttc tagcttcttt tgccaaatca tcatacatat
    34321 tttgtagacg agtaaggttg tcacccgtta attttttctg gcgttcaaca ttatcattat
    34381 atattttaat ttgttggata atactatctt ttttaacatc aagcacttgg ttctgcgaat
    34441 ttaattcacg tattagtgct ttattaagct tatccatttc agctaatgtt cctacctcaa
    34501 gcaggtcttc cacaagcttt cttcgcgcag gggtcgacaa acccatgaaa ggggtatacc
    34561 ctgctgtacc aaggacaaca atctgcttga aactggcata tgacattccg ataagctgtt
    34621 caaattctgc ttggaaatct ttactgctgg cagattcatt aagacgtgta ccgttaacgg
    34681 tgatttcgaa aacgtttggt ttttgtcctc ttttgatata gtactttttc tcatcatatt
    34741 ccatccacag ttcaactaaa agttctttct tatttgtgct gtttattaat tgacctttct
    34801 ttacatcgcg aaatggctta ccaaaaagcc caaatgtgat ggcttctagc atagtagact
    34861 taccaccgcc atttcgtcca gtaataagag ttttttgaac cttatctaat tgaatgtcaa
    34921 tcccattttg accaactgac attatatttt tatattttac tctattaagt ttaaaattct
    34981 tcacaaaaga ttccttttaa tgtatctttt agaccattct atcatatcat cataatctaa
    35041 aaagtattca tcaaattcag ccatgcaaac aacgccttgt gctgtttttg atgtgatata
    35101 aattattcca acatatctag aatcttcttc ggtataatca atatttgcta tgaattcatc
    35161 attaatgtca aatgtcgaaa acttcacagt atgcatcctt aatacaagat acagccatat
    35221 ctcgtaatga tttaggtgtg tcattatcta aaatgttgaa gttaaaagat acagcccagt
    35281 cagtgcagac agtaaccttt ttaatacaat tatcttcaac ctctaacggt tcaaaccagt
    35341 attcaataat ttctttatga ccaatatcat cttttacttc acatttaaaa tgctgactca
    35401 tcataacatt tttaaattca tcaaaagtca ttgtgttgcc tctacatata gctgatttgc
    35461 atattgaata agtgcttcac ggtcagaatc agtgatgtct ggaattgcat taatatactc
    35521 ttccattaat gtctgaagcg attgaacttc aacttcttca ctgtcatctg actcgacaga
    35581 gttatcaatc tttgacacaa ctcgtaatga atgcacaact ttttctagtt cagattcgaa
    35641 cttcgtcaga tttttgtcta cttcagttac tataacacgt actgatagat ttgtaaaatc
    35701 tttatagtca atttttcctt taaatggata atgaattcta cgatgccagg tagtattgtt
    35761 tggaataaat tccgttcgtt ctgtttctgt atcaaacatc cagaacccac gagggtcatt
    35821 ctcgtcacct gcggttagtg tccatggtgt cccaatatat ctgacgtttg cagcctcaga
    35881 aatagtatgg aagtgaccag accacacttc tttataagtc ttaaggaaat cgggttcaag
    35941 accatgagat ttcattcctt tataaaaata aaatccattc agttcccagt gaccaacaca
    36001 aaaagaagca gatgaagttt tgatatgctc aagaatttca ccagtatttt cttcgcacat
    36061 ccaaggaatc aaatcaatca aacacccgtc aaaatctact gtagtaggct tatcatacac
    36121 tttaacatta ggatatttag ccaaaagctc agtagaagca tttggatgca ttacattttt
    36181 atagtggaga tcgtgatttc ctacaatagt gtgtaatgta attccagcat catcaagcgt
    36241 ttgaactatt tcacgggcaa actccatagt tttatgtgtg atcgcttttc gcacatcaaa
    36301 aatatcaccg tattgaatcc aggtagtaat tccatttttc ttagaatatt ctatcgcttg
    36361 cttaattcca tcaatttgaa taccgcgaat ccactcatca tcagctttaa cgcctaaatg
    36421 ccaatcacct aaatttaaaa ttttcatata tcaagaaccg tcattgaaat gcaaaataaa
    36481 attattgaaa taaatccatc tggagtgcta aagaacccaa tccaacatgc tctagtgaat
    36541 agataaaatg caagaaaaag tatcacatat ccaagaaata tcattatatc aaactccgta
    36601 taaagctaaa gggccgaagc cctttatttt gtaataatgt caaactgttc tttaaagcag
    36661 aagcttgaat cttgatgctg atacaaaaat tcatatgctt tttctcgctc acggtcataa
    36721 agagctcggt cagatgacag ttctttaata cgttcaaatg ttgattccat atcattttca
    36781 tcaaaccaaa tgataccgct atcatgcgag gtcaaaggag tattatcaac acggaatttt
    36841 aaattttcgc cagtagattt ccaaaatacc ggaattgttc cacatgcacc aagctcgaga
    36901 tgagtatatt cgagtgagcg ttgtaagtat ttctggttaa gtttactcaa ctgatatcca
    36961 aagccagatt tactcattcg ttcaagcatt tcactattaa tataacaatc taggatttgt
    37021 gccggttgat tcggcgcgag attcatttta tcaatctcac gattaccgta atattcatac
    37081 ggaatacctt tttccttaat tgcaataaaa gcaggggaac gttccagacc ttccattaca
    37141 gtggatttac cagcaggttt taagaatttt tcatgaaaat caaacatctg gtaaaaacct
    37201 ttccatgtag tcgtacgacc aatccaacgg ttgatattca tgttaatttc agaaacatct
    37261 ttccaataag ttgaccgaac cttcacaata tccataggag gctgaaaatt atatactgtc
    37321 ggtgcttctt caatatcatc aaacagagaa acagtttctg gataccattc tttcatcaga
    37381 actttattaa aatcaccatt atcagaatgg ctaaaaataa catcagctcg acgaacagtt
    37441 tcttctaatc ccaaatttcg acgcaaagaa agaacagaat gatcatgctg ataaactaca
    37501 acacgaatag aaggtttaat attatctaaa agttttttat agttattaat cgtagcttct
    37561 tgaacggaag tagcaggaac agaattaata attagaatat cacaatcatt tactagctta
    37621 agtgctttat cgtattcttt agctaaaata actggaattg aaaatgattt gtggtcatga
    37681 gaacttgtac gagtaaatga tttatcttta gcataaacca aagttacttc atgaccattt
    37741 ttaataaacc aatcacgttg ctcgagtgag aattttgtta caccacaacc ttcaagacct
    37801 cgagccataa aaatgcaaat acgcatagtt ttcctctttt catttaataa atcatgtaaa
    37861 taatatttta ttttctataa aacgctacga ataggcccaa acatatccat aagcaatttt
    37921 gctttttcca gatatgcact ttttaatatt agacatgcat cctttaacgg atacagctgc
    37981 gtctttaatt ctaggaaata ctcgtaataa ttttccagta gtatcatatt gaaatactgg
    38041 cacatttctt ttctgagtta tcccacgttt agatttagac attttttgtt tagttgcatt
    38101 agacatccta gagggctttc ctatgttatc agaataataa tatttccatt gaaatcctcc
    38161 agcggttttc cttttaccat ctacacattg tttaattgaa gttgaacagc tatatgacat
    38221 atcttctgca gcatctgtaa tacatctata tttgcgaata aaatttccat ttaaatcata
    38281 ttgataaatt ggttttccag catttcgtct agcgttagac atgtattttt tattatcatc
    38341 atctttccag aactctttca tgctttccga tattgaagaa gatacagctg ttttaatcca
    38401 tccatacatt ttattattta gtcttgttcc gtcagaacta taacacatca tacgaatagc
    38461 taaagccaat ttaggaagtc tataaatttt aaataataat aaatgcgcgg taaaatgttc
    38521 ttctggtgtc aaaagaacta aattagtttt atcatctgta ccacccatac atctaggaat
    38581 tatatgatgt gtttcagtat agtatgtcaa aagactttta tcattgcctc tgtttagtcc
    38641 tttttcgatc agtaaattat atatgtttaa ataattcatt ttagtttatt ttaccaaaaa
    38701 atttataaag caatatagga gccgaagctc ctatccacat aatacgccat acagaggctc
    38761 gttagaactt ttaaatttta tgcgcttata tgttatagtt ccttctgctt tagctttatc
    38821 atgagcctct ttaaagcgtc tcatcatttc ctctctagag gaacgaattt tattataatc
    38881 tatttcagaa gtcggatgtt catctttcac agttgccacc attttttgac ttgataagaa
    38941 tcaacccaca ctttcatatt agggtctgct cttacaatag gaggattaac ttctttgatt
    39001 gaactatcac ggtattcttt ttcagaaatt ttcacgcaaa gatgaccatt caaagattca
    39061 gtaaatcctg cattaatttt aagacgcttg aattttacgt gtgtaagcat caatcatatc
    39121 ctcaatctgc gatctagtag tcttccaaag aatactgatg agttcatcgt tatatggctg
    39181 ttttagaata tcccgacttt tcttgatagc atattcgtat tgagcaaaat tattattttc
    39241 agctgcgatc tgagcgtgct tataaagacg attcagttcg cgtttgtttt tagacaataa
    39301 cttatttgct tttctttctg cttcaagacg gttcttttct tcaatagaag aaataagctt
    39361 ttccacttca tcattaattt cgggtttatc agtcatatta tttctctaat ataaaataaa
    39421 aatcatcatc tgttaaatga taccgatagt ttaattctac accattagat ttaaaagcgg
    39481 tatcatacgg attttctgga tcaatatcaa tgtcaagagc taaaacttcc ctgagataca
    39541 ttttaagtaa atagggaata gcttcaactt caggtatttc ttccaagaat ccggagaggt
    39601 taatcgttag cctcatataa aaaatccaaa ctaggagaat catctacaac acttttcttt
    39661 tcagcccccg gtgttctata ggttgattct tcgtaatgcg tcattttatc atagatgtct
    39721 tgaataaaag tttcatctac taacgcaacc atatcgtcgt cacggctgtc atagacattg
    39781 tgaacgaagt aactatattt ctttgcaact tccttacgtt cttttttaat acgttggacg
    39841 aatgcattaa aacaagcttg agttatatac gcatgtgggt ttttatattt cgtttcatca
    39901 aaattgtgaa gccccttaat agaagcttct ataccatctg caatcatttc ttgtttccaa
    39961 gactgggtgt atcctgaaaa gttgaaacgt ttagataagc cttctgcaat aagcataatg
    40021 gctaatccga tagtatcatt ctgacgaact actttatttg ggtctttatt atttgctaat
    40081 tctgttttcc aatcaataat agcttgtaaa agctctttat tgtttacgta attatattta
    40141 ggcttagttt ctgacatttt cacctcttag ctcaattcat agatctatta tatcataata
    40201 tttgaagacc tatcttaaag catagaggat gaatcaattt caagcacttc atcagattag
    40261 ccgctccaag agctgcatct agtgaatcaa attggtcaac atattcaatt aattcgccgt
    40321 aattagcgta taaccaccat tggctaaatt catactcaag gatgaatcca tttccttcaa
    40381 tttgagttaa accaatgcca tttgtattta cttcataccc agcgagacgt aaatcgttaa
    40441 taagagcttc gttcataatt ataccttagt aattttcagg tctgcaaatt ttttcttgcg
    40501 ttgatttttc atgcgacgaa tagttttatc ggaaatttca tgcttttgat aagctttaga
    40561 ttctacacca aaagctttaa catcaaattc tgacaagata tattgaacca acaattcacg
    40621 gacagtattg cgtccaatct tctgatcatt ctgtttcatc gtttgatgaa gctctttttc
    40681 ccatttatcc aaaatttgag gagttacaat atcgcctttt tctagcaaag aaactacttt
    40741 atcatatgcg taagaattga tggcgttttt aatttgaata gtcatacatt atcctcaatt
    40801 acgttaaaat tttattatcc aaaaaggccg aagcccttag gctaaacttt ttggcaccct
    40861 tccagccttc gtacatcatt gcgactgaca atgacaaagc tccttcacat gctgcatact
    40921 tattattcca gaaccaattt agaaaaactt catcctcaat accgttgtgt ttcatgttct
    40981 ggaaaaattt ggcgcgttct tcagcaattc gctgcgataa tttagattca ggattcattt
    41041 aaatttccca attgccattt tcatcaataa atttaatcca gtcatttact gaccacttgg
    41101 tcgtatcgcc ttttggagta acatttaaag tgtatagccc ttgcttaaaa agcatgcgtt
    41161 tgatattcat attttcctca gctgtaacga taacactcgt ttgatttacg tttagcaact
    41221 cgttgagaag tattataatc aaaatcatca tcaatgtaaa ctgatttttt caactttctt
    41281 acttcaccgc gtaattgacg atttaactca tctttaactt ctgaatcaat acctttcatt
    41341 ctacgccatt tatctgagcg aaaaatgttt tcaaccatat ctttatgact taccccatca
    41401 ggagctttac gctttccgaa atagtcataa tcacgcactt ttaagtcttt acgacgatac
    41461 gttttaccca tggagtttaa tttccttagc aactgaacta aatacagcac gatcacaaat
    41521 catacgttta tgtaacttga gtataagata gtaaacatca aaaccattta cataagtaac
    41581 acgaacaaca ttaccattca cgagataata ctgtcccttt ttaatctctt tatcaaccac
    41641 aaccatatca attcctcaaa ggtaattcat atgttaataa taccacggtt tgaacttgtt
    41701 gtaaacaact ttgtgaaaaa tattttaggg aatgataaga aaggaacgat agcttagaat
    41761 ggtaatatac agaatgtgag aaagaaaggc ccagagggcc cgtcttaatc ttctatgata
    41821 tctctatcat atccaagtga aatgagagtt tctttgaagt gtttaatgtt cttttgtcta
    41881 gaatcattaa tgaaaatgac tggataacga atgttaagag atgtgaatcc agcgcgttta
    41941 gcaagagata caatcagcgg acgatcatac tcaatcttac cattatttgt aagaacttta
    42001 tagaaagtaa aaggagcatt gagctccttt agaagttttg taactgattg acatccagga
    42061 caacgaccta cttcatctgg aattccatag acttcaatct tattttgttt cacaactatt
    42121 ccttactaag agcagcattc agcttgttag taattttatc cagacgctca ttgaattcac
    42181 tagaagataa gcccttttct ggagaaatca aactaatcac gaaaaatata gcaataaaag
    42241 gaataaggaa aatagctcca actgccataa acagaaagaa tgttacagtt gtaagaaaat
    42301 cagctaaacc tttacgaaat ttatacattt acatttacct ttaattgatt aaccaagcat
    42361 tgataagcac taaactatac tgcgaataaa attctggacc aaaatgaaaa tcatatcatt
    42421 tatagtatcc ataatgtaat tcaatttaat catgtttcca caccccatcg gtatttgacc
    42481 aaagtcgctg attatctgat cctcgccaca gctttttggt cggaagattt ttctcatact
    42541 tcccatcaat aataacatca acatatttaa gcatttctag ttgtttaata tcttcaaact
    42601 tatatcctgt ccacaaccag atatctttct ccggaaatct tgctttaacc caagaaacta
    42661 aatttgaaat ctcttctcgg ttctgtggat aaagtgggtc accgccggtt aaggtaaggc
    42721 cttggatata cgatttgctt aaatgggacg caagttcttt aacggtattc atagtgaata
    42781 actgtccgtt acgagcattc caagtactac gattataaca accttcgcat ttatgcaaac
    42841 atccagtgac gaagagaacg accctacatc cagggccgtt aacgaaatcg catggataaa
    42901 ttctatcata attcatcttt atatttccaa gtatatccct tatgaataga ttgaattcct
    42961 ttgcaacatt tataaacagc agaatgaaaa aatcctgcat ttcttatttc agttgctcca
    43021 gttagttcta ttgtatttcc gtctggtgaa tagccaataa ccgttttggt gttaaagcga
    43081 tttctagaac tatttttgat atgctcttta tgattagtag acaaagttct tcctgttagc
    43141 ccatcagata tcctttttcc aaaatcatca ggaagagtta ctttagacct agctatgctc
    43201 attagcttct tagttttatc gcttcttttt gcgccacgct gattttcaaa tttcttagct
    43261 tttgcatacg cgtattgtga agaagtaact tttctatgct tactattact cattatccaa
    43321 tatgcatcat acatctttcc accatatatt ttagccaata aatggtgagc agtatagtgg
    43381 gccttataag ttaaaaatac taagttgtct aaatcatctg aaccacccat acttcttgga
    43441 attatatgat gaagttcata cccggcttta gtttgacggg gcttagatgg gtgttcagca
    43501 gaattaacta gatttgaata gattctgtca taattcattg gtgcttaacc ctatgcatga
    43561 tttctttatt tttaccgaga ttaaatccgc gttcgttcgg atttcccaaa taaccacatg
    43621 ttcttcttat ggtattcatc tttttaggat cagtttctcc acaaatagaa caaacaaatc
    43681 cgttttcagt aggagtcatt tcatgggtac ttccacatgt aaaacattta tctactggca
    43741 tattaacacc aaaataatct aaatgctgtg cagcataatc ccacacggcc tcaagacctt
    43801 ttaagttatt tttcatatca ggaagttcaa cataagaaat gtgaccacct gtcgcaatga
    43861 aatgatatgg cgcttcacga gaaatctttt caaacggagt aatattttct tctactgaaa
    43921 catggaaact gttagtgtac cagcctttat cggtaacatc ttttacgctt ccatattttt
    43981 ctgtatcgag tttacagaag cgataacaca ggttttcagc aggagtcgaa tataaactaa
    44041 aagcaaatcc ggttctttca gtccactgtt taagatgagc attcatttta gttaaaattt
    44101 ctcgtccaat atcacgaccg acaagaatat tcaattcgtg aataccaatg tatcctaaag
    44161 acactgaact tctaccgttt ttaaataact caattatgtc gtcatcaggt ttaagacgaa
    44221 ccccgaatgc accttcttgg taaagaatag gagcaacagt agctttaact ccttttaagg
    44281 aactaattct acacatcaaa gcttcaaaac ataaatccat tcgttcatta aatagctcaa
    44341 caaatttctg ttcattgaac tgtgttccaa tataagaatc taacgcgatg cgaggaagat
    44401 tcagtgttac aacaccaaga ttattgcgtc catcaagaat ttcattgcca gtcgaatctt
    44461 tccatacgct caagaaacta cggcaaccca tcggagaaac aggaacagat gaaccagtga
    44521 tagctttatt gttcttagct gaaataatat caggatacat ccttttgctt gcgcactcta
    44581 gagcaagctg tttaatatca tagttcggat cgtctttata aagattaaca ccttcttcaa
    44641 cgaacataac aagcttaggg aaaataggag ttatcccatc acgaccaaga cctttaatac
    44701 gatttttcag aattgctttc tgaatcattc gttcagtcca gtcagttccc gtaccaaatg
    44761 taattgttac aaaaggagtc tgtccgtttg aactgaataa cgtgttcact tcatcaatgt
    44821 gttcagtaga gttcgctact tctctacccg tttatatgaa acaatgtaat ttggataatt
    44881 gtcatctaaa cacaaatctt taatacgact tgggtggagt tttaaatctt tagcagcatc
    44941 cacaaatgat ttatagatat tgtcatttat tttaacatat tctgggacgg gatgaattgt
    45001 tatttttata tctataacat ttggatgatt actaacctgt tcttcagagc atttaagaaa
    45061 ttttgcagct gatttaaaac ttctaaattt atttccggat tttaaagcta tagaaacagt
    45121 ctttttagcc gttctactac caatattatt tttaacatga gcttcacttc tactattatt
    45181 tttataatgc tcaatcaatt tctctcgtat cttatcttta tgttttaaag ataagatttt
    45241 acctttatgg gcattactaa gtttttgctt atgttcttct gaatccggat atttgttaaa
    45301 tttatatcca cctatagatt tattaagaat aaattcgtta ttaaaatatt tcctaataag
    45361 catttcttca tgtttaaggg ccgattcata agaatcaaaa acttgaagaa ttatccactt
    45421 agctttataa tctttaagct tttctttaac aagcttagat gacgaattgt attctttcca
    45481 atttgtatct ttaccatata tagttttgaa ttttttaaaa cctatataaa aagacttatc
    45541 aggaaatctt accatatagg taaatgctac agaattggca atttttaagc tttttcttaa
    45601 tttccatttc atcgtttcac ctcgtattca tatttatacg aggataaaca gctgcatgtc
    45661 accatgcagt tcagactata tcttcaactc ttagagttgt ctgccgtttc gggtcgcttg
    45721 accctactcc cttacattca tcagggatag tcgttgggca tttacagcta ctgctgattt
    45781 agcaacggat tgtctcagtg agagtttccc gttttaggca gattttacat gagcttgact
    45841 tacgttaact cataagcttg gaatgcatcg tatacgtctt tttctgtttt agattgagca
    45901 taattcaacg catcagcgat ttgccatttt tctgcatcct caatatgttt tgcataggtg
    45961 cgtttaacat aaggagaaag tactttatct acattcgcaa aagtcgttcc gccgtattgg
    46021 tgagaagcaa cttgcgcagt aatttgtgcc ataattgcag tagcaactcc aattgattta
    46081 ggagtttcaa tctgcgcatt accaagctta aatccgtttt caagcattcc ttttaaatct
    46141 actaaacagc aattagtaaa tggaagagca ggggaataat caatatcatg cacgtgaata
    46201 attccgcttt catgcgcttt cataataaaa gacgggacca tatttttggc aatgtgttta
    46261 gacacaatac cagccataag gtcccgttga gttggaaaaa cacgagaatc tttattagca
    46321 ttctcgttta aaaggtcttt attagtttta tgaattaatc cttcaatttc tttttcaatt
    46381 gtcattttaa actctttcta agctgcttct tgaatgaagc tattaattgt gttttggtgt
    46441 cagattcatt atattcaaat cctctttgaa gcatctcggc catcatttcc tcttttccta
    46501 aacgagaaaa ttcctttgat ttatctccaa caaagttagg gtgaatatta ttttgggtgt
    46561 aatcggattt taaataagta agtaaatttt ctaaccattc aagataatca acaccttgtc
    46621 cctttaagcc agaacgatta aatttatgct tcatttgacc ttctgcagca ttgcatagat
    46681 tacaaagcaa tccacgcacc tttcctgctt ttggtccatt taattcatgg tcatggtcga
    46741 ggtgattagc ttgaacatca ggatttagtt ctcgttggca aattaagcat ttaccgtttt
    46801 gtgcatcata aaatttctgt ttttcttctt tgtataattt gccagtcaat aacataataa
    46861 acccttacct taaatagata agggtattta ttattttcaa gtattgtaaa acatttgatg
    46921 caatcgctta tattgctgaa tcattcggtc agaaaaagaa atttgagttt caagccattc
    46981 aatgtactct gcggcagctt gcattaaatt tccttcatag ccatcgttat tttcttgtgc
    47041 agctaattta gctaatgcgt atgaaatacg ttcaccttga aaatcggctt taggcttctg
    47101 aacaacttga ttagttcgct ctacaacttc ttcaatttcg ccattttcta ctgattcagt
    47161 attccacaaa caccaatacg taattggctt atcgtagatg ttaataatct ttccatcaga
    47221 aagttcaatt tcaataattc cagtgtcagg ctctatatca tcttcacatt cttttacaag
    47281 ttcacgaact ttaaagacag tacctgcact aagttccggc cagtaattac acagccctgt
    47341 atcagcacga ttaattctaa accatttatc tactgtaatc atgtcccatc tccatatcaa
    47401 ttaagtcatt tatcgttggt tcattataca ccgtttcttc atcagtgtaa accggttctt
    47461 ccggctctgg ctctacagtt tcccatctag ccgcccacca aggttttata gcgtaatcca
    47521 ttctcgtact gtctgagtta ctacacgttc tcgaagctca accagttcaa cagtaggaac
    47581 tgcataatac cagtcagaat ggtaagaacc tgagcgagat tcatttacag ccacatgtac
    47641 attatgtttt ggactaaaat aaacacactg acgatattgg catttaccat cttgcaccca
    47701 gtcttctatt tcgataggtt taagatagtc ggaaaaatcg aaatcatagt tttccgaaaa
    47761 tgcatcatgg tcttcaatga tttcgctcag aactgcatca acatctaatt tattttcaat
    47821 attcattttt cacaccacca actgcttact tcaaaatcgg gttcgccatg ttcccagaac
    47881 caggggccga taggaatcca cttaccttca tcggtgacgt catattcttc ggatttaagc
    47941 ccaacgtatc gccattcgac ttcataagcg gtaccaccga ttacaactgt gttctcgcca
    48001 tacgggttag acacaacaaa gtctatacct tctgctttag ctaaccaaat catgtattca
    48061 tagagtttat attccaggtc gccttctgtt ccatcgccta gaaaaataat ttgttcattt
    48121 aattctatca tttaaagtat tcccgcaatt ggtcaaatcc accaatatga cttccatcag
    48181 gagcaaatac ctgaggcatt gttaagccga tttgagtatc acgacctagt ttagtcagaa
    48241 gctcagcaat tttctcatca tcaaaaacac ctttttccgg cataatgttg ataaattcaa
    48301 acggctgttt cttcacagtc aaaagacgtt ttgcattatc gcaatacaca catttatgaa
    48361 tgttgctatc ataaccatat actttaaaca tattattcct taattcctag tacttgttta
    48421 aaagtctcgt cgtaatcaag actttggccc gtttgttctt tatgcttgta tataatatca
    48481 cttacttctg atagcatatt tttatatgaa cgagttaaag cagatttaag cacgctgtat
    48541 ctatcaggaa atttaccgtg ttcattataa taagctattg ctaattcacg gactgccttt
    48601 tcagcagtct ccatatattc tttacgcttt gtcattttct tctcggtcaa atcggtgttt
    48661 acaatggcga catttataac gaagattatt agtctgccaa tggaccaatt gcacctgttc
    48721 agttccacat tcagggcaat taggaacgtt tttagaagcc ctttcgcgac gttcaaccat
    48781 gaccattaca gaatcccaat taacaggagg gctataatca tcacaaccat aaatctttcc
    48841 acgcatttcc agatcgtctt cttcaccagc cataataatt ttaattagac tagaattact
    48901 tgaagctgca atgtcttcta atagacgctt tttcatttca atacctcaat agcattacgt
    48961 aaaccatttg ctttggcggt taaatcctta agaactttag tatgctcttc aatctgtttt
    49021 tcaacttcaa tcaaacgggt actgagatat tcgcgttctt ctttcatagt atcattccca
    49081 tgattgggct ttggcgtagg tttaaattta ttagggtcct ttaacttaat aacaacttta
    49141 gtttcaaaca gtgaaagacc ataattcgta ttatcatcaa aggattcaac tacgtccatt
    49201 ttagacaata acgtacgaag tttataagtc aaagaacgaa tcgttttatt atgtttatta
    49261 gcttcacatg gtttcatata tggaagattt ttatatattt catgcggagc acaaacaata
    49321 attaacaatt caaatggtcc attctgagat gatggaatga atttagccgt aacccaatct
    49381 tttacattta cattaatagt acgatcatcg ccatgacaaa acagtctacg agaatgctta
    49441 aaaagcatat tcacattatt attaaattcg tgtgaaaact cactggcaaa tttttcttta
    49501 ctatctttag aaaaccattc ttctaaataa gttcttttca cgtcgttaat aatattaaat
    49561 gtaacaacat tatcatttga tacattagtc tcaatgtagc ttggatacat aaatttttta
    49621 acattattaa cagctatcac agaagatagt aatcgggaac gtttgaacca ctcgagcaaa
    49681 gaaccaagag aatgtgaata cgcattttgt gtatctttac aaatatggtt ttcccatcca
    49741 atatagtcta aaaaatcacg aagaatatta ttgattactt ctctatgtcc tttctgataa
    49801 tcacgatgtt tagtaataag actgtcaaaa taatcaatat aatgtttacg agttttcatg
    49861 ttcttctcac ttggttaatg atttatactc cgagccatcc ttggctttaa attttactta
    49921 attaactgca aagcttgttc tagacgatca agacgattaa cggattcttc ccaaatcttt
    49981 ttagcctgct catattcttt ctgcgcttta ttagaaattt ctagaacttc tttataagct
    50041 ttttctagtg caataacttc tggacgaatt tctatcggtt caggtgaatc atcaagacat
    50101 tccattagtt cctcaagggt agtttcttct ttaggagtat tcacaatttc atcacatttt
    50161 tgttggtaaa tttctttact agtaggtgaa taagcacatt tcacttcacg aaggctaatt
    50221 acgagtttat atccttccca accgcatata ttcttaaaag gatatgtatg aatattttct
    50281 actgtttcca tacaaagtaa tgcggtctct aattgacgag ttatagtgct agcaattgag
    50341 aaaaatttat taatattctt ttggttagtt tctggtgtaa aaaatccata attcacaaaa
    50401 atagatactt tatttttatc aagttcatat tcttttatga taatcatatc agaagccaaa
    50461 ggatgaattt gacgataatc gccataacat aatttagaag ctgattttag aatttgcttc
    50521 ttgaaaagtc tgaaattact aatccaacga cgagtaaaaa tattctcagg gtcttcttta
    50581 ttattgagat gataagaatt aacatcaccg aaccaattat atcctactac atctttagtt
    50641 cgtttaattt ctttcccaaa attaccaaga atatcccgat taaccaaata tgaaagaaga
    50701 cgagactctt taaaggtttt cttgataaca tctttatcta cacggctaga aattttacga
    50761 atttcatgaa taaatttagt agaagaaaca atacttgcat caacactatt gagccactga
    50821 ttgataatag aaagaacgct attttggcca aacatcggta tagctttatc atcaataacg
    50881 ctattgaatg atttgatata ttcgttacga gtcatattaa tctcctcagt agaaagtaag
    50941 aacattatac cacatccttg tggcaaagta aactagttca gtgcatttag tgcattgttc
    51001 agtttagaac gttgctttgt cagattttga acccttgact gagcttgttc taacgccttt
    51061 tcagcttcta gcacttcatt ggtcgcttta actaattcag catctactgc cttaagagac
    51121 ttctcaatcg catccgcgtg ccatttttca acaggtttaa gacttggatt ttcaacagga
    51181 agaaaattca ctttattgaa tttccatgca tctttattac ctgagctata catccaaaat
    51241 ttaggatcgt ttgataagta attagataaa tttaagttat cttgcacttc ttgctttttc
    51301 tcttgtgtga cttcgtcctt tctcaaaaat tcatatttaa atgaaacgat catatcaagt
    51361 tcatatgatg ttgtatctaa cttaaatcgt tcaaaacgag gtaaaatctt agattgaaca
    51421 gcagcaacaa catccatata cttaaatgct tctgtcaact gcgatttaag gcattcgcaa
    51481 attgaaagag aattttttgt attaggttta aagctaattc gtgcagttct attattttct
    51541 tttaacggtc ttacttccat ctgaagagta taaccatcaa atttcagatt ctttaagtta
    51601 atgtcagagc cttttaatcg actagcagta gacaaaattt gctttaattg tctacggaac
    51661 agagcaataa atctccattc aatacgataa tgatttggat tgaaaaatcc agatgataaa
    51721 tcgaccttac tttgaccaac gccttgaaca aatagaggat ttttataatc aatagtttta
    51781 cagaaatcgg tgagctgttc acgagcagtc atttgagtaa tataccctgc tttactaaaa
    51841 ttacgcaccc attcactgct attcgtatac ttaaagtgat gaataacacg attaacttta
    51901 tcagggtcta aattattttc acacaaaaat gtcataacat cacgagtata gctggcatta
    51961 cgaaccatat cttcaatttg agaacgagtt ttcatggtgt tccttaagat ttaagtaaat
    52021 caacaatttt aattaacttt tcacgctcag atttagcttt actactcaat ccagatagtc
    52081 tgaaaatttc atcatcatat tgttgaatag aaatatcagc tcttcaattt gcttattaaa
    52141 ataatcaatt tgttcagaat gtttttcgtt actacgaact ggtacaggtt ttgtaggcaa
    52201 tttagttgaa ctggattcat tcgggcgata aattaaaatg caatttgaac caatcgggca
    52261 tttagcacca gatgaatatt ctaacgttcc agcttctttt aaaacttcaa aagctaaaca
    52321 gagatgatgc cccatattaa cataatcagt agagcgagct ctgatgtaat aatcatctcc
    52381 acgagtgcta aatttaaagc atttaaggtc ttctgtatta ttagttttaa aaatcatttg
    52441 tttatctaga cctttagcca atcgagcacc taatgctaat aatcgtcgtt gattttccca
    52501 caaatctgcg atcatttggt caaatgataa tttcggcatt agccgaccat aaaggtcata
    52561 tcctttatta taattgcgaa ggatttcact cgcattaata cgagacaacg ctccaatttt
    52621 attaagggct ttcataatac gattagataa actcattcca gacccgtttg ttcgctgtaa
    52681 atgtttttct aatccaaatc caatatcaac tttaaattta tctaaaattt cagcatgaac
    52741 atctctgtca ataacattca aatccaaagt tgggttaaat ctatgaaaaa atttatctgg
    52801 ctctccacga cgtaaaacag tccattcatt catcattttt ttattaacta aagatttaat
    52861 tactgcgttg acattattaa ttactactga catattttcc tcactcaatt ttaccaatta
    52921 cgcggaataa gattgaacag actatataag taccacatat agattgaact aatgccattc
    52981 caaagaacca aacaatatta tcaaaccatg tctgttttac gtcgaaagga cgtaaactta
    53041 cagtaatatt atcacctttt tctattgaag aatacgtctc tggggaaata tattcactaa
    53101 atctataacc gtctttgagt tcatatacag caataaacga taaactagac ccctttcctt
    53161 gagttcctgt aagggtatta actacagtaa catcataatc tttataatgc atataatcat
    53221 taattgcgta ataaccatat gcaattacta tacataaaca acatatcaat aaattcaatc
    53281 ttttaattat caactgtttc ataataatct caattaaaag ggcttagaac cattatacca
    53341 tccttggtat aaagcggtta tgcgagtacc gtatttaacc gttcttcaaa cttccgaaga
    53401 gtgttctggc gttcagctct ttgctttttg taagtttcaa tacgctctga aatgagagtg
    53461 tatcgttcat ttactgattc tttcataaaa tcaggaattt ctcgagaagc tttaatctcg
    53521 tcaaatttat caataacagc ttgctcttca gcaattaagt tatcatacat caaaatatct
    53581 ttcttgatga actcaatatc ttcttgagtt acacgagata atttagatgc tttatccttt
    53641 ttgtactgtt cgttagtatc acgagaccag tgtaatgtac gatttttatt cgtattcttg
    53701 taaatttcta caataccaat ctcatcgata ataacgatcc aattccaacg ggatttgtaa
    53761 atttgtcctc cattaacagt gatttcacct ccgattgaga tgtcattaaa gaacttgctt
    53821 tgtgcttctg atttaaattt accatcgttg taatttacca ggttgaaaat atctttagcg
    53881 ttcattttgt gttcctccgt agttgatagt tgtatagtac cacagaggaa cggtcttgta
    53941 aacaactaaa agaaacttct ttcacaattt tttccactga accaagcgct cactgctttc
    54001 ttagtttcag gagcagtgtt atccataaac cattcaaagg cagccttttt atgattctgg
    54061 agggcttctc gggctttaat ctgctcacgg tctattaaca ctaacatatg agcctttctt
    54121 gtcaccaggg gcttcttatg attttttgaa tactcccaat catttgtcca tcgcatcgtt
    54181 gttgcgaatt gaaatacagc ttctttaatc ttagtttcgt aaatttcacg agcctttgag
    54241 tataacatca ttacctccat ttaccagttt aattctagtc atctttttga tggcagtcca
    54301 tataatctat ttctgaactg cctttttgtc ttagaaggcc tcttatgaat ttatttcaga
    54361 agagtaaccc gtagcgattt cttcccaacc gtttttgtcg gtcataataa agtcagcaag
    54421 ataaagtgca gtacgcagtg aaacattacg taaacggtta acattgactt tcatccatga
    54481 taatgcttta taagtttctt catcagaaag accacgcttt tgcatcatgt cggttgaaag
    54541 aataacatct tcaaccctga ccataatttc ttcattagtg tgaacaccca aatccaaata
    54601 aactgagcgg gacactaatg cttgtaaatg tggagcaagt ttagtaccac ggtctaattc
    54661 gcggtcaatg tcaacgtttg tgataaaaac aattgttcct ttaaattcga gctcacgctc
    54721 aatgcctttt tcttctaagt aagaagatgc agtgctccag cagactttac gggtctctcc
    54781 agtgtccaga gcagctttca gaagattaag aatgtccata tcagagaaaa catccacatc
    54841 atcaatcaaa aggacagaat tctcttcacg attattccaa agctgttcat aaagaccgat
    54901 accagagatt ttaccgttaa tgcttttata ctcaatgtat ccaatatcat ttgctttatt
    54961 caaagcttta tctaaagaat atgttttacc aatacccgcc gcaccagaga taattaatga
    55021 acgaatattt ccgttaataa taccattcgt catcattccc ataacattaa atcttttatt
    55081 aatgcgggtt ttcatatctt catatgattc tttaacttct tcaactttta caccatcata
    55141 tgaaatgtct gatttgtaaa cccaaacacc gcgacgttta ccgtcaattt caacaaaaac
    55201 tttaccatct ccttgtgcat ctaccggagc attatcaggg aaccattcac ctaagagctc
    55261 aaaagttcca gagatttctt taccgaagta cataccctta ttgatagtta cagttttcat
    55321 tttattctcc aaatccgtat cagttgatag ttgtatagta ccataaagct ttatgcttgt
    55381 aaaccgtttt gtgaaaaaat tttgaaataa aaaagggagc ccgaaggctc cctatcattt
    55441 ataataactt cgatggtttt caagataaac cctctcaagg aagtcatccc agaaactcat
    55501 gtctactttt tgctgcatac cgttcttaga agcttcagta gatgctgctt ctacttgatc
    55561 gaccacatct tccaaaaact cttgaacggt tttaaatgga tgcttaccca acttcacgtc
    55621 gagaataaat ggagcatctt ggagtggata aaccaagtca ccagttttgt aaatttccaa
    55681 tagttgaagt ccaccacgac aagcatggct cagagctttc cagtcaatgc cttcattggc
    55741 ttcggcctta cgagcacgtt cgccgtattc agcatctaat ttgttcagtg actgcttaag
    55801 ctcaataaga gaaagcgttg tctgatattt acgacccaac actgtgtaaa acgtttgtgg
    55861 gcctgttttc tcatgattat ggaacaccca ttcacagaat tcgttttctg gaagacgatg
    55921 cttaatatct tcaactttag tacgacgctg cttaatggaa ccatcttctt ggtaatcaac
    55981 ccattgctca gggatttgat taactacttt caatacatcg cgtaatgcag ccaaacgaga
    56041 acccttgacg ccgtatttag aagcttgctt gcggacatat cctaaatatg atttcatgtt
    56101 agtcgtataa aaacgagaac ggttgtcttg aataaacttc camacatcag gcaaatcgga
    56161 tttaaccact agttcaggtg gagtgtgaag catatccaat gctacaggtt caccatctgc
    56221 tgctaattta aagaaatact taagactata caattcgtgg tcaatattat ctttagtgtt
    56281 tttagatgat gtgttgttgg tatttttact catgtgctct ttgacgtttc caataagaat
    56341 atcgcgagca ggaggaacaa agatttcttt aaaatctaca tcagattctg gagtagaagt
    56401 tccataaaga tgactaccaa aataagactt aactacagtt ttcattatta gacctttcat
    56461 aatcttcatt aaattgtaca atcaatcgat gataattaga ttttggatat cctaatttac
    56521 ttatataagt tccgaatgac ccacgtttag gtctatttaa tttaatccat aacttataaa
    56581 gtaagtcata gtcttgccaa tgtttaccag ttctttgtct aattttagat gaatttgatt
    56641 gtttcttttt agcttcaaaa ttattcaaag attttttgac tgcagcagag tgtttttctt
    56701 taactcccgg tcgtttaaaa gcagctttca cccctttaga tattttttct ttaacttccg
    56761 gtttgttttg tgcttctaac tgggattctg aaattttagc ccttatttca ggaagactta
    56821 atgttatcga acgtttttct ctgtattcat tagacttcca catttctttc attgtattag
    56881 aatgtatttt tgaaaatttt tctctaacta actgatatcc tcttgaagtt aatttgagat
    56941 ttcttcctaa agaatcttct ccaaaattat aaaatgacca ccatgcataa attaatccag
    57001 gcgaattgta atgaatttta gctaaaagcc aatgggctat aaaatgctct ctagctgtta
    57061 ataaaactag attatcagaa tcatcattac caccaataca agatggaata atatgatgct
    57121 tttccgtata aaaatttaat ttagatttat ctaattttct gagttttcct ttcttaatta
    57181 aattattata tactttagta taattcattg gttcttcgtc tcatttaatt ttgctttgca
    57241 tttataacac atgtctgttc cacttgaaat aaacatattt cctcactttg aaatcatagt
    57301 tggaataaca gaatcaagat aagtctttag tgcaatagct tcctctttct ttaatgtaat
    57361 gatatgtgat cgaaaatcat caatttgacg aatagatact acatctccct cttcatagca
    57421 ttttgaaaca tttaaaatag tttcatcatt ctgattacag gagttagtaa taatagcatt
    57481 acatttttta aaccatttta aattatgttt tcttttagta gaatcataaa aatatttaat
    57541 gttagttata aaattatccc aattattaat tgataagcac attgactcgc ttttaatatt
    57601 aaatcctggg catgaagaat aaaaatgaat tttatgctca tcattaatgc ttacaatttt
    57661 atcagtgtaa gcatattcaa tttgggttaa acgaacaatt tcgctaggcg taaaatataa
    57721 catgtcatct tcttgcgtca aacgatacat gttatttact ttttctatag ccaattcacc
    57781 aaaaagtgga ctaacttcta atactagtcg tttcgcctcg ctcatcatta catactcctc
    57841 tgaatcatat taataatgtt attcaccaga ttataagtaa acattgggta attatattga
    57901 atcatcacat atataacaaa caaaactttc attctcttct ccttggcagt tgacaagatt
    57961 actataccat aatcttgtca acttgtaaac cattaaatga cgttttcgat aaaattttga
    58021 agctttgtat gagcatcaac catgattttc atttcttcct tggaaaagct gtgcctcttt
    58081 cccgagaaga acattcatag tcagaaactg cattagcata ttcttcaatt agcttcatta
    58141 aaaacatctg tttttcagtt ttcattattc cacctaatca tttcaagata ttgaactaac
    58201 ttagctttgg atttatccaa atccctttta gctgcttcta taccgtcgta tgaatatcct
    58261 tcacaatgct caactgctaa ttgatatgaa tctatttcaa tatcatgcgc taatttaatg
    58321 attttttcaa actgttcgcg tgttagcata cttaaactct cgtattatga tcgataattt
    58381 catcaagaaa catatctaac gcttctacag cattattaac tttagcttca aattcttcaa
    58441 tacctgataa ggcaaagtta atgcgttcct catctgcttt acgaattaaa gctaccaatt
    58501 ccttaatttt atccgcttgt tcgatactaa tcattattcc accacatatg aaagagagaa
    58561 tattgcacac gccatgtgag ttgcaacttc atcacacata ttataacgtt tcttaagaag
    58621 ttctacaagt tcttcactag taacttcatc catgtcgacg aaaaaatcac cattaatgat
    58681 gacgtagata tttccttctt gattgagtgc ttcaattttc atgatgttct cctctttatc
    58741 cgatggttgt atagtaccac agctcaaacg gaaagtaaac cggtaaaatg aaaaaaagtc
    58801 tcccgaagga gactaatgtt attcgaggga aagaagatac ttactctggt aaaacattcc
    58861 agtaatatca tctatcgtgc tttggatggc tggaggcatt tctttataaa tgctgttaga
    58921 ttggtctagt atgcgatcaa tcattttaat tgtgtcggta ggaagtttac tggcatctgg
    58981 aattgaaggc gtgtattttc gaccagaata ccccaaatat tgctcaccaa atttatcaat
    59041 caaatctggc aactcggaaa aaataaaatc gtatgctttg tgtctagcat aacttttagt
    59101 ttcaaaatgt gcagaatgaa aataagcttg tgcagccatt aataaaccta agtattcatc
    59161 tgcctttgaa ggttttccac tttgtgaaaa gtcgctgaat ttcattcagt ctccaattta
    59221 atgttcataa ttctagcgta tgattgtgcc atctccgcgc ctcgctctat acattcaaaa
    59281 tcagaagagc acgggtcatt tttataggtc gttctcataa aactatagaa ttgttcagac
    59341 gattctacgc ttttattttc aaaaagcata taaacgtgcc taataccaga ttccataaat
    59401 ttatcaaaat gaggatcgac attcgcttca atcgatggag ataaaacaaa tgacaatcct
    59461 agcatggcaa aaagtgctgt tgcttttaag gccataaagg cctcctatca tttttgtcct
    59521 gtatttactt tgtgccgatg cacggcctta actttatcaa ggtatttttc aaaatttcgc
    59581 aatctagtat agtctgccgg agattggttg agtgatactt ctcgacgcaa agctgaaatg
    59641 atatttccaa cttccctacg aatttcatct aattgaagaa cagtaagatt gcgaagttgc
    59701 ttttcagtta attgtagcat atatacccct ttagttagat aaacctattt ataacttttg
    59761 cactaaccga gctttttagt taattcattc caatgttttc tacacaaaga aacataaatt
    59821 tcatcaccaa tacaaatttg attaccttct ttaactggtg ttccatcttc cattaatcga
    59881 gctgtcataa tcgctttttt accacaatga caaactgctt ttagttcaat aagtttatct
    59941 gcaatcgcta aaagttcttt agaaccttca aataattttc cagcgaaatc agtccttagc
    60001 ccataagcca taacaggaac attatatgta tcaacaattc ggctcaattg atgcacctgt
    60061 tcagttttta aaaactgagc ttcatctaca aatacgcaat gaatatcttt ttgtgcttca
    60121 gcccatttat agaactcgaa aatatccata tcatctgtaa taatattcgc ttcctgctta
    60181 attccaatgc gagaaacgac ttcacagaca gaatcgcgag tatcaatagc aggcttaaga
    60241 actaatacac tcattccacg ttctttataa ttatgtgcag caatcaaaag agaagcagat
    60301 tttccagcat tcattgctgc ataagtaaaa attaaactcg ccatcttagt ccttagttaa
    60361 attttctaaa tatgtttcta aatcattttc agctttatcg atagatttta ctaattcgta
    60421 atatgtttcg gcatctccat attcagaaga tatttcaaaa gacaaatcct tttctaaact
    60481 aataatttca ccaactaaaa ataatatttc gttcttttgt tcgcgagtaa tcataaggaa
    60541 tttatataat caatgagttc ttgttcttta ttatcgaatt ctttagaaag ttcttcgtac
    60601 tcgtttgcgc taaaaggacc gcattcatta caaacttttt ccaattcact atttttatcc
    60661 ataacttcgt ggataagaga aaagagtgtg tctttttgtt ctttgcttaa actcataacc
    60721 atgtcacctt taagcagtat tcttctacat gctgtttacg acctttctta tcaataaagg
    60781 tatattcaac gaatgttcca atgtagtctt tatctacatc atgtggacta ttaattggac
    60841 atttagtgcg acaaatgcgt tcccattgac gaataattac tgccttattc tttgggtcat
    60901 atggatgtgg ataatgtata ttcataataa tggttcccaa tcaacaatca caatttctaa
    60961 tttagaggaa tatgtatcta aaatcccctc aataatatcc cagttccctt tacctatgcc
    61021 tgcaccaatc ctaggcatat agattgtagg tttaatcagt ttattttcac caaactcatt
    61081 taattctaac atacaattca ttaaagcgga atactcaaaa tttggccctg gttgaaattg
    61141 agtataaaga ttgaagcagt aagctttatg agtcctaaag tatttttcat agactgagta
    61201 agaaccgagt ttagttacat caccccattc agtctgtaat ttatcagctt ccaaaatttt
    61261 agggaaagct ttggttaatt gacccgctac gcctgaaccc atagtatgaa aacaattaca
    61321 tccatgtgca atatttttac cttcagcgaa aagggcgaca atatcgccct tgatatattt
    61381 tacaatcatc tagtactcaa tcctcgatta taagaatcta ccaaacggtc aaccattgaa
    61441 tgacaagcgg ctttatcttt ctcctccgca actgaacatt ctaaggtatt ccacttttta
    61501 gcatatcgtt ttaacaatgt atcgtttttg tatctgcttg atttatctct ttctccgtct
    61561 ttatatgcat atattaattt ctgtgcaaat tcagcttggc atgccttatt tttcccacaa
    61621 taatctgccg cagtgcggtt tacatattct ctaatttcag tatatgatgt atctgctgac
    61681 gcagaagcag aaaatgaaat taatcctata cataaaacca aaattttagt catttactat
    61741 ttccaaaagt ttattatttt taaggtaatt agccttttct aggacttcag aagcatattt
    61801 agaacctgct ttaacattcc atcccgaatt ataagaggat attgcttttc ttatatcgcc
    61861 cttatgtata tttaaccaat aagaaagttc aatgtacgcc caggaagctg aattggatcg
    61921 tttattcaac attcttttta tttcagcatc ggtcatatta taaccaagtt ccttaactct
    61981 tgctcgcata gtaggcaaat aattttggaa cattccgtag gcgtgatgct ttggtttaga
    62041 ttttaaatta actccgccag agctttcttg ccataaaatg gcagccatta tatgacctaa
    62101 tccgctcttg tggatatttt tgtgtgtttt atattttcca tccttagaaa attgttcccc
    62161 gaattgatac gcgtaacgca tgttatcgag ttggacatta ctgaaagtat gctcggagct
    62221 atgtgccatc attgaaatgg ccaatagacc agcgagtagt gcttttctca tgcttacctc
    62281 attgagtttt aattactgct ttagaagcct ttcctggtaa acgacgactg ttgataattg
    62341 ccatcctaca ttgaagtgac gggtctttga acttctcgtt aggtttacaa actgtaaatc
    62401 caagccaaag atttccatct gtgatttcta aacgtccagg acgatattca accccatcaa
    62461 taaaatcctc gtcaatgtca ggacgcggag gcatactcag gaattcatta acttctaaaa
    62521 catggtcttt tattttatgg aataattcaa aaacgtatgt ctcatcaatc tcccgttgaa
    62581 ttgcgcgatc aagaagatgt tgagaatatt ttagatgaaa cgatgagact cctgctgctt
    62641 ttgatgcctc acgaatctca ttgttaattt gacgaaactc cgactcaaag tgacgacgaa
    62701 gcttatttcg acggataaaa acttctgtat tgatagtcat gttattctcc tcttaactga
    62761 tagaaaaatt ataccacagt caagaggaaa agtaaacagt tattctttaa atctaatcaa
    62821 tttattcata gactttgaaa cttcggcacg aacctcatgt agatttttga gctgttcaag
    62881 acgctgcgta tagtaagcaa tttcatcttc ttcgagacag tcctgcgaat cttctttaag
    62941 ataacgtgca tagtcctgga aagcgttacg gactacttcc tggaagtcat caagactttg
    63001 aattttctta ggagcaacag atacacgacg aggggcagta taatactcat aaccaaaccc
    63061 tgcgcttaat tgagccatta gtatttttcc tctggttgga acactgcacg acaagcccac
    63121 atactggctt ctttgagttt cgttttagca atagttaact gatcgagact ttcagcataa
    63181 ttcttcgcga attcacagtc ttcgcaatta tctagtgctt cccagaattc atcatataaa
    63241 gcatcaaaga taagtcctaa acgaacttca gcgtctttaa tagcatttac tttaccgatt
    63301 ttctcttcag tatgtggttt ataaccctta atatcttcaa tcatatttga cttcctcacc
    63361 agtacataat acgtattcaa ctaaacgaat aggttcatga atgccatagc cttgaacaga
    63421 aatttctgtc gtaggataaa ttccatcaat atcacccata ttccacgctt cattaaattg
    63481 ctgttcgcct gagttactaa accactcgcg aaagcattta gcacatcttc agaaccttca
    63541 ataattatct ttgccattac aaactttcag taaaggtacg agcgataacg tcgcgctgct
    63601 gttccggagt cagagagtta aagcgaactg cataaccgga tacacggatg gtcagctgcg
    63661 gatatttttc cggatgctta actgcatctt ccagagtttc atgacgcaga acgttaacgt
    63721 tcaggtgttg accaccttca attttaactg taggttgtgg ctcaatttca atttcacggg
    63781 catgcaaacc atagaaaatt tctgggtcta caaaagagtc ctctttaaag gttttagaga
    63841 caataattcg tgcttgaata ccatcttcaa aataaatagt acctttatgt gtgccttcaa
    63901 gaatttgata tgctttcata taaacctcaa ttagaaaata aatttatcca agattgttct
    63961 ttaattaaaa atggctcaga atcatatgcc attaaacttt gcgtaattaa tcctttaaaa
    64021 ggtccatcaa taaattccat ggtaaaatat ggaattttat tcattagccg tgcattagga
    64081 gcagtgcaca aaactctgca tcctttgaat acgccttttt gtaatttgta ttgcttggga
    64141 taaaattcgc tcaaaatgtt attttttgcc aaaatttcaa aatgattcac caatttattt
    64201 ttaatagttt ttggcgaaaa ataaagatat tcgaaaagct gagtgtctgt catcattgca
    64261 ttccgattac gaaaaactgt ggacgagtaa taccaccaat gcaacattta ctattacagc
    64321 agtagtgtac ggtgtcaata tggacactat aaatcttatc catatcagga gatttgacag
    64381 gctcatcaat tatatacaaa attcgcgaaa gctttaaacc tctgaacttg cttcctttat
    64441 taccaataaa actgcgtaca gaatcagtaa ataaacgaaa acgtatatca tcattagaat
    64501 aacgcgaaaa ttcctttttg atgttatttg cagaaatttt agcataagct gaagtattag
    64561 aaagaacaat aactgttccg ccatcataca accaattagc agcaaagtta gtcacagcaa
    64621 ttgatttacc ggattgacgt ccaccatcta gtcgaagtgt acaatactgt ttaagtaagt
    64681 cttcaaatgg cgggatatat tcgtttttac aaatttcttc tactctagca tcagaatggt
    64741 gtgtaaaagc attcatcagg gatagataag gaccagttaa aaatgttctc atttcttctc
    64801 tataagctct ataagtttgg gccattccgt ggcacatgaa ttgtccattt ctgtatttac
    64861 ccattaccgc gcttgggctc gaccttatta caggttggcg ggaatccctc atataatcat
    64921 gaggtccagg ttgttccctt atgcataaat cgccttaccg tagtatttgt accaagtagg
    64981 acgttgtgca attttttcat ctaaacgagc ttgtgatata gcaatagaag cttcatgggg
    65041 aatataatca ccacggaatt cctgaggaat atcactaata tcctggactg tagtatcctt
    65101 gatattaaaa ccacgtttta aacattcagc tataagctca atttgacgtt tacgtaagaa
    65161 ctcgagctta tcgtaaaaga atgtaacatg acctgcgcca aggataaaag taggactgat
    65221 tttaaaatca cgaacacgtt taccgttagc aacatgctta cgaactgcac caaaaacacg
    65281 cggcaattca cgatattcag ccattaagtg ttggtcagcc aattcagata ctaaagtaag
    65341 gttgatacga gtcattttag tgttctcctg tagttgatag gtctatagta tcatacctac
    65401 aggagatgta aactgttatt tatctttaat tgctttagct gcttcgatag ccgcttgctg
    65461 aaggtcatcc atagacatgc cgaacttaga agcaaagtta tcaattttct tttcgacggc
    65521 attcaaaggc ttggcctgtt taccttcatt agcgccagga agagcgagaa tacgctctct
    65581 gtcaatataa aggcttacaa gtttcttacg gtctttatcg ggcaaatcat gaaatgaatg
    65641 ggccttttta tttacagcgg cttctaattt acctgcgccc actcgcgctt cggcaataaa
    65701 ttcttgatat gttttcatat gtttccttta aatgtaaata tttttattat tctatcctag
    65761 aattgtgata atatattcac aattctagga gttgtaaact gcttttattt aagcgtccca
    65821 agtataagct ttattaagaa ttaccacggg ctgcattagc aacggcgtaa gcgtactgaa
    65881 tattagcgtc tttaaactta cctttagagg tatctatttc tgccttaaag ccgcctttag
    65941 tcataacatc ggcaaattct ttacggaaag ccattgcatc aagacctttc catgatgatt
    66001 tatgcttggc aaattcaaga cctgcgaagt tgacagcttt agccaattta ttatcaatga
    66061 cccatttacc ggctttaggc acaaacttcg ggcctttctg tttagagaac agttttaaat
    66121 tccagcggcg aaggtctgca tcagctttaa caaattctga gtctaagtta ctagcaacaa
    66181 catcttcaat atgagcaaat ttaagtccgt caacttcaat atttaaatcg gtacgccagc
    66241 gaagtccttc ccaagcgaag gctttaaagt cggaagcctt tgtagctaag taccgttcaa
    66301 taggagctgt tttagggtca aagccgtttc ctgatcggta ggtccactca tctttgttaa
    66361 tgcctttggc ctttactaca gaagcttcgg caataaattc ttgatatgtt ttcatatgtt
    66421 tcctttaaat attttaatta gtaattgtct attcaagtaa ttgtgaatat actatcacaa
    66481 ttccaagaga aagtaaacag ctttatagat ttttatacgc gtcccaagtg ccagttctaa
    66541 acgttgtaat gactcgtttt gcgcgattag gtgtttgatt ataccatata cttttagcta
    66601 agttaactgc tgcttcatcc cagcgttttt gttgaagcat acgtaaagag ttagtaaatc
    66661 ctgccacacc ggtttctccc atttggaaaa ccatattaat caatgcacag cgacgaaccg
    66721 catcaagaga atcataaacc ggttttaatt tagcatttct cagaattccg cgaacagcag
    66781 catcaacatc ctgattaaag agtttttcag cctcatcttt tgtaattaca ccattgcaat
    66841 tacgcccaat agctttatct aattcagatt tagcagcatt aagtgatgga ctttttgtaa
    66901 gcaaatgacc gatgccaata gtgtaatagc cttctgtgtc tttatagatt ttaagtctaa
    66961 gacgttcatc tatacgtaac atttcaaata tattcataat acctcctaag tatttataga
    67021 aggtatttat aaaattaaaa gaggttgttc attattcggt aaagtgaagg acccatcaca
    67081 tattgccact gagtacgagg aataagagca aaagcgtcca tctctggaat cataacgcca
    67141 tctttatttt caaaataaga ctcgcaacgg caatttctga acatctcatg ctctactgga
    67201 atcgtgtaat aaaataactg taggtcttta ttactagaat atttaaatac acctaggtct
    67261 tctagaaggt ctggattata attgctaaaa ccagtctctt ctaaacattc tcttcgtgct
    67321 gcatctaatg cgcttaaatc agaattttct acacggccct ttggaatatc ccaacgatgt
    67381 gccatcattc cagtcttacg agaaccagta acccgaccca taaataaatc tttatcttct
    67441 gtcataaaga taataccagc tgataatgtt ttcattttaa tttcctgcat tcagtgataa
    67501 agttatttaa attttgagca tatttctttt catcaaaaat cttttgctgt ctgcgtaacc
    67561 gccatggcat ttcaatgaac atacgccata tccctagata ataccgctgc tgtaaaaata
    67621 ttaacaagta tagttaaaag aatccaatcg cctattctgt ccattggatt tttataaaaa
    67681 agtaaaatac gaatgatgat ataggaagac taatgatata ccacagaaga accttcttat
    67741 ctgtgaacca atcagcattc gttaacttag cgcgaccatt ttgaatacac acgaatttat
    67801 catctgttac agtaaatggc ttagctgctt gatatcccat tctaaactcc ctaattaatc
    67861 gtttctttgt atcttcggaa caaccattcc aatcaactct atcaactgga atgccatcat
    67921 ccccatcatc taaatcatac cagcgagttt ttaaaatcat ttaattttcc tgcaatcaat
    67981 cacaaactct ttcattgatt cattttcaat ataagacatg tagctattat attcttttaa
    68041 ttgtattttg taatcctttt ttctttgcca atttatttta aaattatcat aatgaaaata
    68101 taaaatgata ccaaagaatg aaaacaatga aataatttta gtataacaaa gctcgctcca
    68161 aacttctatt atatctactg taccactgat ttttaaaata aaacagtcaa ttaatagtcc
    68221 aataagacta cctgtaagag ctgcagccaa cgccacagca aaaattaaaa atgactcaga
    68281 aaacgaatat ttgactttat ttagctttgg cttttgcatc gtgattcctt aacaaatttc
    68341 ataatttcat taaattcata ctcagcaagt ttaagctggt gttccttttt aatctttttg
    68401 cactgggctt tccaatcacg tacgcgttta cgataatgtc ttccttgata ccagtatcct
    68461 atccaattta cgggtactaa taaaaatgga actaccaatg gaagagttag cattaacata
    68521 attattacgc cagaatcaat atcagtcata acatctaaaa cacctccaat aatcaataga
    68581 attacaaatg atatagctat cacaggacct attaatacat cagtagaaat tatctggcgc
    68641 tttaattcat acttcaaagg tttacttgga aggtatagtg atggctttga catattctct
    68701 acattcctta acaaattttt ctagtaataa atcactttca aaattaggat tttccactaa
    68761 tttatcaaaa agatcatcaa caatattcaa gatatttctt ttactaagaa tacgtttatt
    68821 ttcatgcttc gtttcagaat caactataag agtaaagaaa tatttctttc cctgaaattt
    68881 taccgtagta tcaatataaa ataaatttga cttttgtaaa ttacgtttaa accatgcgtc
    68941 acttaaacta taaacaccga gataatcaaa atcgtcgttt aaataacaaa ctgaccattc
    69001 aggagaaatg aaatcagtaa attcaacatc aaaatcacat gtcaatgaat gaattgattc
    69061 aatactgtta ataagtattc caggacgtat taaagacttt ttacctctgg aaaatcttcc
    69121 agaaagactt tcatcagttt catatgaaga accccaataa taattacgtc cttttgccat
    69181 atgtttaaga gcatttagta attggtctgg aacatcaacg tgtctttgga actcttcaaa
    69241 cattgaattg aaatcacttt gcattttcat tcctatttac tccaagtaat aggggccgaa
    69301 gccccttatc attatttcag agaattaata tattcctgaa catcggcaga ggtagtttca
    69361 accccagaaa tattaccatt aaaggtttca actcgagcaa gagtatcttc aatatcaacc
    69421 ttagtcagtg ctgcaatttc aactacatca tcagcagtac taattccaag ggcatttgct
    69481 gcacgagttt cacggatata ttccaattta actgcaagtt cttggcgagc atcatctaac
    69541 tcaactactt tcttggcgat ttcaattcgc atttcagcat aaccatcagc tttagtagtc
    69601 agctgttcag ctgttcgacg atatagcaag ccgagtttag catgcattgt tacatcttga
    69661 ccttcggaaa gaagcttgcg aatttcacgc tcttttgatt cggcctgttt attcttttca
    69721 acaataagtt cacgaatacg tttttcttca ttaatagatt taacagaagc agtttttagg
    69781 tctttaattt tatcaagtag ttttgctgct gcagcagtat actgttcttc aacagataga
    69841 tttttagcca ttgcagaacc aagtttagtg cgaataaact caacaatttt cttcagtgtg
    69901 ttcatagtat ttccttaggt tggtataatt agataatata atatcacgtt tctaatagat
    69961 tgtaaactta ttcttcgtct agctcgtcga taaaggcgtt gatggcctcg ataatggcat
    70021 cattgatagc caataaaata aaatcatcgt cagtaccttt agaagattct aaagcattga
    70081 tatatgcttg gttgacgagt tcccaagcct ttttaaaata aggagcttca tcatcaggac
    70141 aaatatcccg cacgccttca aagatacgtt tggcataatc taacacccat tgtacaggca
    70201 tgttttgaga acgttcgtta aactctttaa agtccttaga ttcaaaaagc tcttcaggat
    70261 aattatttct attacaaaaa gctttactaa agttacgttt cataatgttt tcctcatttg
    70321 tataggctca taatatctca atcatsagcc tatgtaaact tatttcatat tattgaaata
    70381 ttcttctgcg atttcgtcgt tatcatggta aactttagaa gacagtttaa cataactttc
    70441 agcagtgaac atgttaatca caacctttac agtataccac tgaccgtctt cattacccat
    70501 tactgcgtaa gtttcaaaca tcggatggtc aggaccgata actttaatat cattcaccgt
    70561 acgaccgaaa tcttctgaaa cacatttcat aaagaagttg aaaagttcac cgtaattatc
    70621 cattttattc tccaagttat tttctgtatc agtagttgat agttgtatag taccatggaa
    70681 gaacaaggat gtaaacagtt ttgtgaaaaa atttttaaaa agttttaggg aattctaggg
    70741 cggagagggg caattaaaag ataggataat atattataaa gggtataaac taaatgatgc
    70801 ctagagaggt ctggaaaggc ttagatacca aaaagcccca acctttcggt cggggctaac
    70861 cgttgcggca accttgtcgg ggttccacct gccaaggcaa gtgtttgtac gaaacgccgg
    70921 gattcgaacc cggttattaa gtagttgacg ctactcaata tttttaaaag gccatatctc
    70981 aaccatatcc gaacgttccg tcaaaaacgc tactcggctt acggcaaaga tatttcctcg
    71041 aatcgataat ttggtgcgcc gtttctgctg tgatgtaaga gggcatcaat aaacgcaaag
    71101 attattaacg caattcctta ctcagggaac catcagtccg acgacttacc ggtagcgacc
    71161 cggtttctca tttggtatcc cgccctggga tcgaaccagg accgcaaact tagaaggatc
    71221 gtatgctatc cattacacca gcgggacgta atttaaaatt tcatttttcg acctttaaac
    71281 catccttctg gaattgggtc agttttctta atacgtttag aaactttttc atctaatgaa
    71341 tgaatccaca tcataccgaa ttgggaattc ttttcacctt tctggtgatt atttttggcg
    71401 tgagattctt tcattttatt aatagtttca ggagtatgat gcttatttag aaatctgcta
    71461 ttatttaaaa atttttccct gtattcagga gttgaccaca aacgtttaaa tacatttgaa
    71521 ccaattttac gatatttttc ttgaagtaaa atatcatttt caaaacgtga cttaaacgat
    71581 ttagctcctt ttaagctagc atctttcttc tggtttagca ttccaggaat atttacatga
    71641 tcccatccac cttcaccgcc aagttttaaa ttatacacat ctggtctatt taaaaactct
    71701 tctgtgacaa tatttttctc ggcttcaagc atagattctt tatcgtcaaa atactctaat
    71761 atttctttag aaaaattttc tataccatat ttatcttggg ctctttttaa taatttacca
    71821 gaacccatat atccatcatc taaattttcg gtagaatgca caccaatata aattttatta
    71881 ttaattttat ttgttatttt ataagtgtaa tagaacataa atatctccta tttctaagag
    71941 tatttatgtt ctcaaaatat gacccagacc agatttgaac tggtaacctt tcccttatga
    72001 ggggactgct gctaaccatt gagctacagg gccttggtgc tgattgacgg aatcgaaccg
    72061 ccgacatcct cattacaagt gaggtgctct acctactgag ctaaatcagc aaaattacgg
    72121 aggcgatagg atttgaacct atgagtcgcc ggagcgactg ccggttttca agaccggtgc
    72181 attaaaccac tctgccacgc ctccagtctc catacaagga tttgaacctt ggacctcctg
    72241 atcccaaatc aggcgctcta ccaaactgag ctacacggag taaattaaat tggagcggat
    72301 aatgagaatc gaactcacat catcagattg gaagtctgag gtaataccat tatacgatat
    72361 ccgcaaattt ggtgcgagaa gtgggactcg aacccacaag gaaatcattc cgcagcattt
    72421 taagtgctgt gcctttacca atttgaccat tctcgcgctg ggaataaagg actcgaacct
    72481 ttgcatctag cagtcaaagt gctatgcctt accaacttgg ctaattccca attattaaca
    72541 aaggctctct aacaagaacc cttgatgata gagggtatta atcagtgcgg tatgagttaa
    72601 taataacaaa taattcttaa agcatattta ccatttatga tgatacgtat ttacgataca
    72661 ttcaagaccc aaaggattct tgaaaatatc atattcaaga ggaccttttt ctgtttcaat
    72721 aaagaaatca aaatttactg tattaaattt acggtcttcc tttactaatt taacttgaga
    72781 agatgaacga tcaatgtaaa ccttttcaac ttcaaaacac gttaaaatgc cataatcatc
    72841 aatcaaggct ttagctgctt cttgatcata tttatatcca ttttcaacgg atgatacttt
    72901 cgcataaaga atcatcatca acctctatca acaatagcat gagtatgggc atttacgatt
    72961 tgccaccagt cgaaacgatt ggaaccataa tctggtttat tttcattttc tttaatgata
    73021 tcacgcagtt tatcttctgt ttcagcatac gcaattaaat catcatatcc accacaagga
    73081 taataattat cacctgcgaa taaaagaaaa tttaccttag atggatttac gtaataatgg
    73141 tctttaggat atttagttcc tctccaatca gttacttcaa cataacggta agaaaatcca
    73201 tttttacttt caatccaact ccacgcttca aaaggagtat taaaaacttt atcaggtatt
    73261 aaattacctt caaaatgaga aggatttgca taatccccgg cataaacata atattcgtta
    73321 atactcattt attcaccttt agaaatttta tccataacga tagcaattaa accaattaaa
    73381 aatgctacta caagtgaaaa cacattttct gctgtagtta ataatccgca tataaatcca
    73441 acaaacattg aaaaactaaa agcagaagca gaaattgcaa tagcaacatt tcgaattaat
    73501 tcacagcgtt tcattttatt ctcctcagta gttgataggg taatagtatc acagctaaaa
    73561 ccctatgtaa acaactttgt gaaatattta ttacaaaaga tttttagcaa taatcttgag
    73621 atgtgccgca gaaatgtgtt tagctttaaa caacgcagtt tcttcagcag gagagataac
    73681 gattgtagca ccatcctttt tagcagacca cccatcacct aggtaaacag tacctttgat
    73741 ttcttcgcca tcaaccagac taatcattgg tttaccttct cgtcctttat ttgctttaat
    73801 aacttcagaa gtaagagtag cttcggtaat ggtagaaacc ggggtagttg tagaagtaaa
    73861 ttctttaaat gttttcattt ttattttcct aattaatttt gatgaggtaa tagtatcact
    73921 acctcatcag tatgtaaaca actttgtgaa attattttaa atcatctgcc caatcgagtt
    73981 taagaggctc tttgtattca cgatctaata cgaccggaat ttgtacatca ccgctaaatg
    74041 ataagggccc aacattataa gacaatgtta tatgcggtgt gtaatcatca aaatcatgtg
    74101 tagcacctag tgcccgcgca tacatgtgtc gacagcgcag atattcagaa tctagcacaa
    74161 gtacaagagt cgatccatct tgtgttttcc atacttctaa atgtccagaa gaagctactt
    74221 caaaacttcc actcgatgga acatatggaa catttactct tgaataacat atagtcgaat
    74281 gaattttttc tctaggaact ggattaggaa cacgtaaaga gcgctgaagt tcttccagcg
    74341 catcaagtgt taattctgaa aacttagctg ctacataaag acccgttgaa aagtctttaa
    74401 attccatcat tcttcatctt ttgcttcatc tgcagattca gcagtaagat ttttgacagc
    74461 ttcaacgatt tcttcaactt tgatagtatc gccagtgata cctactgcac gagcaatttc
    74521 agccaaagtt ccttgcagaa ttttggattc ttccatcaga cgagcagctt gatcctgcgt
    74581 atcaagaatg cgagatttca gagttacgat ttcagcagac agtttttgtt caacagtttg
    74641 ttcagacatt atagtacctt tagtgtattt ttaattttag aaaaaagttc ttcaagagaa
    74701 ccatcgtttg taattactaa atcgccatca cgaattggca atccagcttc tgtaatatgt
    74761 gtatcattgg atttttgacc aggacgaact acatgaatta ctgtagcacc catcgcccta
    74821 gccgcatcca tttcatgatc ttgacgggta tcaggaacga tataataatc ataacctgag
    74881 ttaaatttat caagataatc taaagcaaat aattttaccc agtacatgcg gtcgaagtta
    74941 ttaacaatca aatccgtacc tagggcttgc atcagacgac ggactgacca ttgatcttca
    75001 atattattta taacgtcagt aatcttatta aatgctacga aattaactga ttcttttcct
    75061 tcgtcatcaa aaacaaacac acctttaatt gggcttttac cattaagata acaaaatgct
    75121 tgttccataa tcgtgattac ttctaattta gtcagattta aattagtctc acgatcatag
    75181 tcaattcctt caaactcttt acgagttaag caaggatagt cagtgtttgc tgcaaatact
    75241 ccccatgcat aagccaatgc atccttaata ggaccagcaa gttggtattt aactgcagaa
    75301 taattgctca tgataaaatc agcagtagta tcttttccac tacgctttac accgcttaaa
    75361 aagattagtt tcatgtgttt ctcctcaaat ttaattaaga ttataacaca caaaactgaa
    75421 gcattaaact tctgctataa ttttaccatc tttttctact tgaaaatagg tgtaaggaat
    75481 tgttgcagta catactaaag ccgggtctga atcttccgtg tagctaaatt ctacttcaga
    75541 taggtcagaa acccaaggct tataaaaatt tattgacatc acgatttcag ttttgctatt
    75601 atctaagatg taaagcgtaa tgtactcagg acctgttttt tgggcagtat tttcacctgt
    75661 aagatagttg ctagttccta gcatccattc atacattcct atccacgact taagttcttc
    75721 atcaactata aatctcacaa tgagtggatc atactcaaat gtaacacctg gacgttgtgc
    75781 tcggcccagt ccaaacggcc cagtcacggt atcagtaaca ggtattctaa ttcctggaat
    75841 aggaactgac tgagcattta aagtaaaagc agatgtagta ttactatgtg gtattgatac
    75901 tacaaagtta gttgtatttg cttggttaaa aatttgttgc agagcttgcg acatatattc
    75961 ctcataatgc tttataactg ttggtggtat aatgggtcta agtcccttcc attcaattcc
    76021 atttagaaca aacaacagaa aagaatggaa gataatagaa ttagatattt gaccagactt
    76081 tgtttgcaga gaaacgtttt ccttttgaaa cgaactgctg aagtggcatc aacacaacgt
    76141 tcgcccagtc tttcggggcg atttcaacaa ggctacccat aatattacca ggtatatatg
    76201 ccttaatcat ttggtctgca cccctaaatc ctttcacttg actccaatca atttttaatt
    76261 tcgttttatt agtaatagta ggtgtatttg catattgctt taaaagctct tctaggaatt
    76321 gctgacgagc tttaggtgga atatagtgca agtttaatcc gtacattaaa ttatgcttac
    76381 ctaaaccaag gtaaattatc aaaggaaatt tatcccagta aggaagagtt tccttgtgtt
    76441 tagcatcata agcaaaagca tatattcgtc ccggctgcgg gcgaacaact ttatgtcctt
    76501 ttacttgctt aatagtttca gcaaaccact ttctggtttt attattaatt gctgcgcctt
    76561 cattacgaat tttatcacgc aatgtttgtc tgaatgaatt tatcataagc agttgtcttt
    76621 cttgcttatt gagtttattc attggttttg attcaagttt ttgaatcttt tcagccgttt
    76681 taattcctga agcatatttt gacattgctg aagtaaacgt agagtatttg attcctcttt
    76741 cttcagcaaa ttgctttcct gtcattcctt ttgctttggc ctttttatat tcaagaccta
    76801 tctgaatcca tttcttttcg tttaatgatt gcttaacctt tggaacttgg ggagtgcttt
    76861 cattaattat ttgaaaaata gccattatgc ccccttaaag ccaagagctc gtaatccatc
    76921 ttctgttaga attctaaatt ttattccacg cttttcagct aaagattgtg ctgctttcca
    76981 tttgtcagtg ttcacagacc aggtataaat ttcattcata aatcttttct tcgctgcggt
    77041 cgttagatgt gctggtttaa ctggtggttg tgtttctttt ttaggtttta tttcaataaa
    77101 aaattcttgt ccagaagaat ctttcatcca aatatccatg aagtatctac gttttttccc
    77161 ttctgcatta caaaaataag gaattactgc tgtttcacta ccccatgcaa taatttctgg
    77221 atttttatct aaccattcaa aaaagaattt ttcccaattt gatctatacg taattttttt
    77281 agggtcacct ctatactttg atatattttt aggaacccat tttccagaat atgccattgg
    77341 attctcctta taaatagata atatatttat aaacaggagg gcccatgctc tttacatttt
    77401 ttgatccgat tgaatatgcg gccaaaacgg tgaataaaaa cgcgccgact attcctatga
    77461 cagatatttt tagaaactat aaagactatt ttaaacgcgc tcttgcggga taccgcttac
    77521 gtacttatta tattaaaggt tcaccacgcc cggaagaatt agcaaatgct atatatggaa
    77581 atccacagct gtattgggtt ttattgatgt gtaatgataa ttatgacccg tattatggat
    77641 ggattacttc gcaagaagct gcttatcaag catctataca aaaatacaaa aacgtaggtg
    77701 gagaccaaat agtatatcat gtgaatgaga acggtgaaaa attttataat ttaatatcat
    77761 acgatgataa tccatatgtt tggtatgata aaggcgataa agctagaaaa tatcctcaat
    77821 atgaaggagc gcttgctgcg gtcgatacgt atgaagctgc tgttcttgaa aatgaaaaac
    77881 ttcgtcaaat aaaaataata gcaaaatcag acatcaattc atttatgaac gaccttatac
    77941 gtataatgga gaaatcttat ggaaatgata agtaataacc ttaattggtt tgtcggtgtt
    78001 gttgaagata gaatggaccc attaaaatta ggtcgtgttc gtgttcgtgt ggttggtctg
    78061 catccacctc aaagagcaca aggtgatgta atgggtattc caactgaaaa attaccatgg
    78121 atgtcagtta ttcaacctat aacttctgca gcaatgtctg gaattggagg ttctgttact
    78181 ggaccagtag aaggaactag agtttatggt cattttttag acaaatggaa aactaatgga
    78241 attgtccttg gcacgtatgg tggaatagtt cgcgaaaaac cgaatagact tgaaggattt
    78301 tctgacccaa ctgggcagta tcctagacgt ttaggaaatg atactaacgt actaaaccaa
    78361 ggtggagaag taggatatga ttcgtcttct aacgttatcc aagatagtaa cttagacacc
    78421 gcaataaatc ccgatgatag accgctatca gagattccga ccgatgataa tccaaatatg
    78481 tcaatggctg aaatgcttcg ccgtgatgaa ggattaagat taaaagttta ttgggatacc
    78541 gaaggatatc cgacaattgg tattggtcat cttatcatga agcagccagt tcgtgatatg
    78601 gctcaaatta ataaagtttt atcaaaacaa gttggtcgtg aaattacagg aaatccaggt
    78661 tctattacaa tggaagaggc gacgacttta tttgagcgtg atttggctga tatgcaacgg
    78721 gacattaaat cacattctaa agtaggacca gtctggcaag ctgtcaaccg ttctcgtcaa
    78781 atggcgttag aaaatatggc atttcagatg ggtgttggtg gtgtagctaa atttaacaca
    78841 atgttaactg ctatgttagc aggagattgg gaaaaagcgt ataaagccgg tcgtgattca
    78901 ttgtggtatc aacaaacaaa aggccgtgca tcccgtgtta ccatgattat tcttacgggg
    78961 aatttggaat catatggtgt tgaagtgaaa accccagcta ggtctctatc agcaatggct
    79021 gctactgtag ctaaatcttc tgaccctgct gaccctccta ttccaaatga ctcgagaatt
    79081 ttattcaaag aaccagtttc ttcatataaa ggtgaatatc cttatgtgca tacaatggaa
    79141 actgaaagcg gacatattca ggaatttgat gatacccctg ggcaagaacg atatagatta
    79201 gttcatccaa ctggaactta tgaagaagta tcaccatcag gaagaagaac aagaaaaact
    79261 gttgataatt tgtatgatat aaccaatgct gatggtaatt ttttggtagc cggtgataaa
    79321 aagactaacg tcggtggttc agaaatttat tataacatgg ataatcgttt acatcaaatc
    79381 gatggaagca atacaatatt tgtacgtgga gacgaaacga aaactgttga aggtaatgga
    79441 actatcctag ttaaaggtaa tgttactatt atagttgaag gtaatgctga cattacagtt
    79501 aaaggagatg ctaccacttt agttgaagga aatcaaacta acacagtaaa tggaaatctt
    79561 tcttggaaag ttgccgggac agttgattgg gatgtcggtg gtgattggac agaaaaaatg
    79621 gcatctatga gttctatttc atctggtcaa tacacaattg atggatcgag gattgacatt
    79681 ggctaatata cttccaatga gcgctgattt aggagaatcc atggaaggtt cttctatcga
    79741 cgtcaccttt accgctcaat tagaaacagg tgaaacgtta gtatctataa atataactag
    79801 ttacgaagaa actcctgggg ttttagtaga agaaaatcgc ttatatggaa catatgaatc
    79861 tgtatttggt ttcggaaatg acgcgttgaa atatcgttta ggcgatgaat ttaaaactgc
    79921 tgcttcatgg gaagaacttc ctactgattc tgatactcag ttgtatttgt ggaaagctcc
    79981 tcaaaacctc cagaagacat tcacttacga agtaacatta atatatgact accaagaaca
    80041 aagtgaatct gggggttctg gcagtaattc taggtcatct tctgatacta ctgaaccgac
    80101 agatcctcct gctccagtaa gaaaaactct agttaaaaat tatactaaaa ctatagttgg
    80161 aaattggagt cgttgggcta ataaactgag aaaatatgcc tatgcaagac cataaatatt
    80221 tttatttgta ttcaataact aataaaacaa cagaaaaaat ttatgtaggc gtccacaaaa
    80281 cttcaaattt ggatgatggg tatatgggtt ctggcgttgc cattaaaaat gccattaaaa
    80341 aatatggcat agataatttt tataagcata ttataaaatt ctttgaatct gaaaaagcta
    80401 tgtatgacgc agaggcagaa atagtcacag aggaatttgt taaatctaag aaaacttata
    80461 atatgaaact aggcggtatc ggtggcttcc caaaacataa cacagcgggt gctaaaaatg
    80521 gattttacgg taaatctcat tcgcgtgaaa ctagattgaa aattagcatt aaatcgtcta
    80581 gaaaaagagg gcctagaggg ctagaggtaa aactctgaag atgtgtggcg ccaataaccc
    80641 aaggtatggc aaaatagccc ctaatgctaa atctgttatt atcaacggcg ttttatataa
    80701 aagtattaaa atcgcagcta aagctcttaa tataaattat agtaccttaa aggggcgagt
    80761 taaagcgggg tattataaat gtcaggatta agttatgata agtgtgttac tgctggccat
    80821 gaagcgtggc ctccaacagt tgtgaatgct acacaaagta aagtattcac tggaggaatt
    80881 gctgttctcg tagcaggcga tccaattaca gaacatacag aaattaaaaa gccgtatgaa
    80941 acacatggcg gagtgacaca acctagaact tctaaggtat atgtcactgg aaagaaagct
    81001 gttcaaatgg ctgatccaat atcatgcggt gatactgtgg ctcaggcatc atctaaagta
    81061 ttcattaaat aggatttaaa atggcaaata cccctgtaaa ttatcaatta acaagaacag
    81121 caaatgctat tcccgagata ttcgtcgggg gtacatttgc tgaaataaaa caaaacctca
    81181 ttgaatggct taatggccaa aatgaatttt tggattatga ttttgaaggc tcaagattaa
    81241 acgttctgtg tgacctttta gcttataata cattatacat tcagcagttt ggtaatgctg
    81301 ctgtgtatga aagctttatg cgtactgcta acttacgaag ttcagttgtt caagctgcac
    81361 aagataacgg atatttacct acttcaaaat ccgctgcgca gaccgaaatt atgttaacat
    81421 gcactgacgc attgaatagg aattacatta ctattcctcg cggaactcgc tttttagcat
    81481 atgcaaaaga tacttctgtt aatccatata acttcgtttc tagggaagac gttattgcta
    81541 ttcgtgataa aaataaccaa tattttccgc gtttaaaatt ggcccaggga cgtatagtaa
    81601 gaactgaaat catttatgat aaattaacac ctattatcat ttatgataaa aatattgata
    81661 gaaaccaggt taaattatac gttgatggag cggaatggat taactggacg agaaagtcaa
    81721 tggttcatgc tggttcaaca tcaacgattt actatatgcg tgaaactatt gatggaaaca
    81781 ctgaattcta ttttggtgaa ggtgaaattt ctgttaatgc ttctgaagga gctttgaccg
    81841 ctaattatat cggaggtctt aaacctactc agaactctac gattgttatt gagtacatta
    81901 gtactaatgg tgctgacgcg aacggagcag tcggattttc atacgcagat acattaacaa
    81961 atataactgt catcaatatt aatgaaaatc caaacgatga tccagatttt gttggggcag
    82021 atggaggcgg tgatccagaa gatattgagc gtattcgcga attgggtact attaaacgcg
    82081 aaacccaaca acgatgcgta actgcgactg actatgatac attcgtttca gagagatttg
    82141 gttctattat tcaagctgtt cagactttca ctgattctac taaacctggg tatgcattta
    82201 ttgctgctaa acctaaatca ggattgtatt taactaccgt acagcgtgaa gatattaaaa
    82261 attatctcaa agactataat ttagctccta ttacgccatc aattatttct cctaattatc
    82321 tttttattaa gactaattta aaagtcacat atgctttaaa taaactgcaa gaatccgaac
    82381 agtggcttga aggtcaaata attgataaaa tagatcgcta ttataccgaa gatgtagaaa
    82441 tttttaactc gtctttcgct aaatctaaga tgttgacata tgtagatgat gcagatcatt
    82501 ctgtcattgg ttcatcagcg actattcaaa tggttcgtga agtacaaaac ttctataaaa
    82561 cgcctgaagc gggtattaaa tacaataatc aaataaaaga tcgttctatg gaatctaata
    82621 cgttttcatt taattctgga cgaaaggttg taaatcctga tactggttta gaagaagatg
    82681 tattatatga cgttcgtata gtatcaacag accgagattc taaaggaatt ggtaaagtta
    82741 ttattggtcc atttgcttct ggcgatgtta cagaaaatga aaacattcag ccgtatacag
    82801 gcaacgattt taacaaatta gcaaattctg atggacgcga caaatactat gttatcggtg
    82861 aaataaatta tccagctgat gtgatttatt ggaatatcgc taaaattaat ttaacatctg
    82921 aaaaatttga agttcagacc attgaattat attctgaccc aaccgatgat gttatcttta
    82981 ctcgcgatgg ttcactgatt gtatttgaaa atgacttacg tccacaatac ttaactatcg
    83041 atttggagcc tatatcacaa tgacagtaaa agcaccttca gtcactagtc tcagaatttc
    83101 caagttatcc gcaaatcagg tgcaagtacg ctgggatgac gttggtgcta atttctacta
    83161 ttttgtagaa atcgctgaga caaaaacaaa ctcgggggaa aatctcccga gtaatcaata
    83221 tcgttggatt aatttaggat atacagcaaa taatagtttc ttttttgatg atgctgatcc
    83281 attaacaaca tacattatta gagtagccac agctgcgcaa gattttgagc agtctgattg
    83341 gatttatacc gaagagtttg aaacttttgc tacaaatgct tatacatttc aaaacatgat
    83401 tgaaatgcaa ttagccaata aattcattca ggaaaaattt actcttaata attctgatta
    83461 tgttaatttt aataatgata ctataatggc tgcattgatg aatgaatcat tccaattcag
    83521 cccatcgtat gttgatgttt catcaataag taattttatt attggtgaaa atgagtatca
    83581 tgaaatacaa ggttctattc agcaagtatg taaggatatt aaccgagttt atttgatgga
    83641 atcagaagga attctatatc tttttgagcg ctatcaacct gtagttaaag tatccaatga
    83701 taaaggacaa acctggaaag ctgtaaagct cttcaatgac cgtgtaggat atcctttatc
    83761 taagacagta tattaccaat ctgcgaacac aacatacgtt ctaggatacg acaagatttt
    83821 ctatggccgc aaatctactg atgttagatg gtcagccgat gatgtcagat ttagttctca
    83881 ggatataaca tttgctaaac ttggcgacca attacatcta ggatttgatg tagaaatttt
    83941 tgccacttac gcgactttac cagcgaatgt ataccgcatt gcagaagcta ttacttgcac
    84001 cgatgattac atttacgttg tcgccagaga caaagttaga tacataaaaa cgagtaatgc
    84061 acttatagat tttgatccat tatctccaac atattcggaa agactttttg aacctgatac
    84121 catgactata accggaaatc ctaaagcagt atgctataaa atggattcta tctgtgataa
    84181 agtttttgct cttattattg gtgaagttga aacattaaat gctaatccta gaacatcaaa
    84241 aataattgat tccgctgata aaggaatata tgttttaaat catgacgaaa aaacatggaa
    84301 aagagttttt ggtaataccg aagaagaaag aagacgtatt caacccggat atgcgaatat
    84361 gtcaactgac ggtaaattag tttctctgtc ttcgagtaat tttaaatttt taagtgataa
    84421 tgttgttaat gaccctgaaa ctgcagcaaa atatcagtta attggcgctg ttaaatatga
    84481 atttcctcgt gaatggttag ctgataagca ttatcatatg atggcattta tagcggatga
    84541 aacatctgat tgggagactt ttactcctca accaatgaaa tactacgcag aaccattctt
    84601 taactggtct aaaaaatcta acacacgttg ttggataaac aactctgata gagctgtggt
    84661 agtttatgct gatttaaaat acactaaagt tatagaaaat attccggaaa catcaccaga
    84721 tagattagtt catgaatact gggatgatgg tgattgcact atagtaatgc caaatgtcaa
    84781 attcactgga tttaaaaaat acgcatcagg aatgcttttc tataaagcct ccggtgaaat
    84841 aatttcttac tatgatttta actatcgtgt gagagataca gtagaaatta tttggaagcc
    84901 aactgaagta tttttaaaag catttttaca aaaccaagag catgagactc cttggtcacc
    84961 agaagaagag cgtggattag ctgaccctga tttaagacca ttaattggca caatgatgcc
    85021 tgattcttat ttgttacagg attcgaattt tgaggcattt tgcgaagcat atattcagta
    85081 tctttctgat ggatatggaa ctcaatacaa taatttacga aatttaattc gtaaccaata
    85141 tccacgagaa gagcacgcat gggaatattt gtggtcagag atatataaaa gaaacattta
    85201 tttaaatgct gataaacgcg atgctgttgc gagattcttt gaatcacgta gctatgattt
    85261 ttattctact aaaggaattg aagcatcata caagtttctt tttaaagttc tttataatga
    85321 agaagttgaa attgaaattg aatctggggc tggtactgaa tatgatataa tcgttcaatc
    85381 tgattctttg actgaagatt tagtaggaca aacgatttat acggcaacag gaagatgtaa
    85441 tgttacttat atagaaagaa gctattctaa tggtaaattg caatggaccg taactattca
    85501 taatcttttg ggacgattaa ttgctggtca agaagttaaa gcagaaagac tccctagttt
    85561 tgaaggcgaa attattcgtg gggttaaagg aaaggatttg cttcaaaaca atatagacta
    85621 tattaataga agtagatcat actatgtaat gaaaattaaa tccaatttac cttcttcccg
    85681 ctggaaatct gacgttattc gttttgttca tccagtagga tttggattta tagcaattac
    85741 ccttttaaca atgtttatta atgttggttt aactcttaaa catacagaga ctataattaa
    85801 taaatacaaa aactataaat gggattctgg attgcctact gaatatgccg acagaatagc
    85861 taaattaact ccaaccggtg aaattgagca tgattcagta acaggcgaag caatttatga
    85921 gcctggccca atggctggtg taaaatatcc tcttcctgat gactataatg ctgaaaataa
    85981 taattcaata tttcaaggtc aattgccgtc tgaacgacgt aaattaatga gtcctttatt
    86041 tgatgcatct ggaacaacat ttgcgcaatt tagagattta gttaataaac gtctaaaaga
    86101 taatatagga aatccaagag accctgaaaa tccaacacag gttaaaatag atgaatgatt
    86161 caagtgttat ctatcgtgcg atagttactt caaaatttag aacagaaaaa atgttgaatt
    86221 tttataattc aattggaagt ggtccggata aaaacactat ctttatcaca tttggaagat
    86281 cagaaccgtg gtcatcaaat gaaaatgagg tgggctttgc cccaccttat ccaaccgatt
    86341 ctgtattagg cgtaactgac atgtggacgc atatgatggg aacagtaaaa gttcttccat
    86401 caatgcttga tgctgttatt cctcgcagag attggggaga tactagatat ccggatccat
    86461 acacatttag aattaacgat attgtagtgt gtaactcagc tccttacaac gctactgaat
    86521 caggcgctgg ttggttagtg tatcgttgtt tagatgttcc tgataccgga atgtgttcaa
    86581 tagcatcttt aactgataaa gatgaatgcc ttaagttagg tggaaaatgg actccttctg
    86641 ctaggtcaat gactccgcct gaaggtcgag gagatgctga aggaacaatt gaacccggag
    86701 acgggtatgt gtgggaatat ctatttgaga ttccgcctga tgtatctata aatagatgca
    86761 cgaatgaata tatcgtggtt ccttggcctg aggaattaaa agaagacccg actagatggg
    86821 gatatgaaga taatctcact tggcaacaag atgattttgg attaatttac cgtgttaagg
    86881 caaatactat ccgttttaaa gcatatttag attcagttta ttttcctgaa gctgcattac
    86941 caggaaataa aggatttaga caaatatcaa taatcacgaa tcctcttgaa gctaaagctc
    87001 atccaaatga cccaaacgtt aaagctgaaa aggattatta tgacccagaa gatttaatga
    87061 ggcattcggg tgaaatgatt tatatggaaa ataggccacc tattattatg gcaatggatc
    87121 aaacagaaga aatcaatatt ctgtttacat tttaaattaa gggagcccat gggctccctt
    87181 tttctttata aatactataa actcataagg aaaccgctat gttcattcaa gaaccaaaga
    87241 aattgattga taccggcgaa attggtaacg cttctactgg tgatatctta ttcgacggtg
    87301 gtaataaaat taatagtgat tttaacgcaa tttataatgc gtttggcgat cagcgtaaaa
    87361 tggcagtagc aaatggcact ggagcagatg gtcaaattat ccatgctact ggatattatc
    87421 aaaaacactc tattacagag tacgcaactc cagtgaaagt tggcactaga catgatattg
    87481 atacctctac tgtaggtgtt aaagttatca ttgaaagagg cgaactcggc gattgtgttg
    87541 aattcattaa ctctaatgga tcaatatcag ttactaatcc tttgacaatt caagctattg
    87601 attcaattaa aggtgtttca ggtaatttag tagtaactag cccatatagt aaagttactt
    87661 tacgctgtat ttcatctgat aattctacgt cggtttggaa ttattctatt gaaagtatgt
    87721 ttggacaaaa ggaatcacca gctgaaggta catggaatat ttctacatct ggatcagttg
    87781 acattccatt atttcatcgt actgaataca atatggctaa attgctagtt acgtgccaat
    87841 cggtagatgg aagaaaaatt aaaacagcag aaataaatat tcttgtggat actgttaatt
    87901 cagaggtaat ttcttctgaa tatgctgtca tgcgagttgg gaatgaaacc gaagaagacg
    87961 aaatcgctaa tattgcattt agtattaaag aaaattatgt aacggcgact ataagttctt
    88021 caactgtcgg tatgagagca gcagttaaag ttatcgctac gcagaaaatc ggggtggctc
    88081 aataatgaaa caaaatatta atatcggtaa tgttgtagat gatggtaccg gtgactacct
    88141 gcgtaaaggt ggtataaaaa taaatgaaaa ctttgatgag ctttattatg aactcggtga
    88201 tggtgatgtt ccatattcag ccggtgcctg gaaaacttat aatgcttcat caggacaaac
    88261 attaacagca gaatggggaa aatcatacgc tattaataca tcttctggaa gagtgactat
    88321 aaatcttcca aagggtacag ttaatgatta caacaaggta attagagcta gagacgtatt
    88381 tgctacatgg aacgtcaacc cagttacact agtagctgct tccggcgata cgattaaagg
    88441 gtctgcagta ccagttgaaa ttaatgttcg attcagcgat ttagaactag tgtattgtgc
    88501 cccaggacgt tgggaatatg tcaaaaataa acaaattgac aaaattacca gttcagacat
    88561 tagtaatgta gctcgcaaag aatttttagt tgaagttcaa ggacaaacag actttttaga
    88621 tgttttccgt ggaactagtt ataatgtaaa taacatcaga gtaaaacatc gtggtaacga
    88681 attgtattac ggcgatgtgt ttagcgaaaa cagcgatttt ggctctccag gcgaaaatga
    88741 aggagaactg gttcctcttg atggatttaa cattcgatta agacagcctt gtaatattgg
    88801 tgacactgtt caaattgaaa catttatgga tggtgtatca cagtggagaa gttcatatac
    88861 aagacgtcaa attagattgt tagattcaaa attaacgtca aaaacttctt tagaaggaag
    88921 catttacgtt actgatttat caacaatgaa atcaattcca ttttctgctt ttggattaat
    88981 tccaggagaa cctattaatc ctaactctct tgaggttcgt tttaacggga ttttacagga
    89041 attggctggc acagttggaa tgccattatt tcattgtgtt ggtgccgatt cagacgatga
    89101 agtagaatgc tctgttttag gtggaacttg ggaacaatct cataccgatt attcagttga
    89161 aactgatgaa aacggcatac cagaaatttt acatttcgat agcgtatttg agcatggtga
    89221 cattatcaat atcacctggt ttaataatga tttgggtaca ttattaacaa aagatgagat
    89281 tattgatgaa actgataatc tctatgtatc gcaaggacct ggagtagata tttctggtga
    89341 tgtaaattta acagacttcg ataaaattgg ttggccaaat gtagaagcag ttcaatctta
    89401 tcaacgcgca tttaatgctg tttcaaatat ctttgatacg atttatccta ttggaactat
    89461 atatgaaaac gctgttaatc caaataaccc tgttacatat atgggattcg gctcatggaa
    89521 attatttggg caaggaaaag ttttagttgg atggaatgaa gatatttcgg accctaactt
    89581 tgctctaaat aacaacgatt tagattcggg tggaaatcct tcacataccg caggtggaac
    89641 aggtggttct acttctgtta cattggaaaa tgctaatctt cctgcaactg aaacagatga
    89701 agaagttcta atagttgatg aaaatggatc agtcattgtt ggtgggtgtc aatacgatcc
    89761 agatgaatcc ggtccaattt acactaaata ccgtgaagct aaagcatcta ctaactctac
    89821 tcacactccg ccaacatcaa taactaacat tcaaccatat attacagttt atcgttggat
    89881 aaggattgca taatgagttt acttaataat aaagcgggag ttatttcccg cttagccgat
    89941 tttcttggtt ttagacctaa aactggcgac attgatgtaa tgaatcgtca atcagtcggg
    90001 tcagtgacaa tatctcaatt agcgaaagga ttttatgaac caaacataga atcagctatt
    90061 aatgacgttc ataatttttc tataaaagac gttggcacaa ttattactaa taaaactggt
    90121 gtttctcctg agggtgtttc tcaaactgat tattgggcat tttctggaac tgtaacagac
    90181 gattctcttc ctccgggttc tcctattacg gtattagtat ttggtcttcc agtttcagca
    90241 acaactggaa tgacggcaat tgagtttgtt gcaaaagttc gcgttgcact acaagaagct
    90301 attgcgtcat ttactgctat caattcatat aaagaccatc caactgatgg tagtaaatta
    90361 gaagttactt atttagataa tcaaaaacat gtattaagca catattctac atatggaata
    90421 actatttccc aagaaattat atctgagtct aagcctggct atggtacatg gaatttattg
    90481 ggcgcacaaa ctgtaacttt agataatcag cagactccta cagtatttta tcattttgag
    90541 agaacagcat gagtaataat acatatcaac acgtttctaa tgaatctcgt tatgtaaaat
    90601 ttgatcctac cgatacgaat tttccaccgg agattactga tgttcacgct gctatagcag
    90661 ccatttctcc tgctggagta aatggagttc ctgatgcatc gtcaacaaca aagggaattc
    90721 tatttattcc cactgaacag gaagttatag atggaactaa taataccaaa gcagttacac
    90781 cagcaacgtt ggcaacaaga ttatcttatc caaatgcaac tgaaactgtt tacggattaa
    90841 caagatattc aaccaatgat gaagccattg ccggagttaa taatgaatct tctataactc
    90901 cagctaaatt tactgtcgcc cttaataatg cgtttgaaac gcgagtttca actgaatcct
    90961 caaatggtgt tattaaaatt tcatctctac cgcaagcatt agctggtgca gatgatacta
    91021 ctgcaatgac tccattaaaa acacagcagt tagctattaa attaattgcg caaattgctc
    91081 cttctgaaac cacagctacc gaatcggacc aaggtgttgt tcaattagca acagtagcgc
    91141 aggttcgtca gggaacttta agagaaggct atgcaatttc tccttatacg tttatgaatt
    91201 catcttctac tgaagaatat aaaggcgtaa ttaaattagg aacacaatca gaagttaact
    91261 cgaataatgc ttctgttgcg gttactggcg caactcttaa tggtcgtggt tctacgacgt
    91321 caatgagagg cgtagttaaa ttaactacaa ccgccggttc acagagtgga ggcgatgctt
    91381 catcagcctt agcttggaat gctgacgtta tccagcaaag aggtggtcaa attatctatg
    91441 gaacactccg cattgaagac acatttacaa tagctaatgg tggagcaaat attacgggta
    91501 ccgtcagaat gactggcggt tatattcaag gtaaccgcat cgtaacacaa aatgaaattg
    91561 atagaactat tcctgtcgga gctattatga tgtgggccgc tgatagtctt cctagtgatg
    91621 cttggcgctt ctgccatggt ggaactgttt cagcgtcaga ttgtccatta tatgcttcta
    91681 gaattggaac aagatatggc ggaaacccat caaatcctgg attgcctgac atgcgtggtc
    91741 tttttgttcg tggttctggt cgtggttctc acttaacaaa tccaaatgtt aatggtaatg
    91801 accaatttgg taaacctaga ttaggtgtag gttgtaccgg tggatatgtt ggtgaagtac
    91861 agatacaaca gatgtcttat cataaacatg ctggtggatt tggtgagcat gatgatctgg
    91921 gggcattcgg taatacccgt agatcaaatt ttgttggtac acgtaaagga cttgactggg
    91981 ataaccgttc atacttcacc aatgacggat atgaaattga cccagaatca caacgaaatt
    92041 ccaaatatac attaaatcgt cctgaattaa ttggaaatga aacacgtcca tggaacattt
    92101 ctttaaacta cataattaag gtaaaagaat gacagatatt gtactgaatg acttaccatt
    92161 cgttgacggc cctcctgcag agggccagag ccgcatttcc tggattaaaa acggcgaaga
    92221 aatattagga gctgacacac agtatggaag tgaaggctca atgaatagac ctacggtttc
    92281 tgtactaaga aatgttgaag ttcttgataa aaacattgga atacttaaaa catctttaga
    92341 aaccgcaaat agtgatatta aaacaattca gggcatctta gatgtatctg gtgatattga
    92401 agctttggcc caaataggta tcaataaaaa ggatatttct gacctcaaaa cgctaaccag
    92461 tgaacacaca gaaatattaa atggaactaa taatacggtt gacagtattc ttgccgatat
    92521 tggtccattt aacgccgagg ccaactctgt atacagaacg atcagaaatg atttactgtg
    92581 gataaagcgt gaacttggac aatacactgg tcaagatatt aatggtcttc ctgttgtagg
    92641 aaatcctagt agtggaatga agcatcgcat tattaataat actgatgtca tcacttcgca
    92701 gggaatacgt ttaagcgaat tagaaacaaa atttattgaa tctgatgtag gttctttgac
    92761 cattgaagtt ggtaatcttc gtgaagagct tggaccgaaa ccaccatcat tttcacagaa
    92821 cgtttatagt cgtttaaatg aaattgacac taaacagaca acagttgagt ctgacattag
    92881 tgctattaag acctcaatag gatatccagg aaataattcg attatcacga gtgttaatac
    92941 aaacactgat aatattgcat ctattaattt agagctaaat caaagtggag gtattaaaca
    93001 gcgtttaacc gttattgaaa cttccattgg ttcagatgat attccttcga gtattaaagg
    93061 tcaaatcaaa gataatacaa cttcaatcga atctctaaat ggaatcgtcg gtgaaaacac
    93121 ttcatctggc ttaagagcga atgtttcatg gttaaaccaa attgttggaa ctgattctag
    93181 cggtggacaa ccttctcctc ctgggtctct tttaaaccga gtttctacaa ttgaaacttc
    93241 tgtttcaggc ttgaataacg ctgttcaaaa cctacaagta gagattggta ataacagcgc
    93301 aggaattaaa gggcaagttg tagcgttaaa tactttagta aatggaacta atccaaacgg
    93361 ttcaactgtt gaagagcgcg gattaaccaa ttcaataaaa gctaacgaaa ctaacattgc
    93421 atcagttaca caagaagtga atacagctaa aggcaatata tcttctttac aaggtgatgt
    93481 tcaagctctc caagaagccg gttatattcc tgaagctcca agagatgggc aagcttacgt
    93541 tcgtaaagat ggcgaatggg tattcctttc taccttttta tcaccagcat aacatggggc
    93601 cgcaaggccc caaaggattt taaatgtcag gatataatcc tcagaatcca aaggaactca
    93661 aagatgtcat tctaagacgt ttaggggctc caattattaa tgttgagtta acacccgatc
    93721 aaatttacga ttgtatccag cgtgccctag aattatacgg tgaataccat tttgatggac
    93781 tcaataaagg ttttcatgtt ttttatgtag gggatgatga agaaaggtac aagaccggag
    93841 tcttcgattt aagaggttct aacgtatttg cagtaacccg cattttacgc acaaatattg
    93901 ggtcaataac atctatggat ggaaacgcta catatccgtg gtttactgac tttcttttag
    93961 gaatggctgg tattaatggc ggaatgggaa cgtcttgtaa tagattttat ggaccaaatg
    94021 cctttggagc tgatttagga tattttaccc agcttaccag ttatatggga atgatgcaag
    94081 atatgctctc tcctattcca gacttttggt ttaattcagc aaatgaacag ctcaaagtca
    94141 tgggaaactt ccaaaaatat gatttaatta tcgtagaaag ctggactaaa tcatacattg
    94201 atacaaacaa aatggttgga aatacagtag gatatggaac agtcggtcca caagatagct
    94261 ggtcattatc tgaacgatat aataacccag accacaattt agtaggtcgt gttgtcggcc
    94321 aagatccgaa tgttaaacag ggtgcttata ataatcgttg ggtgaaagac tatgcaacag
    94381 ctttagctaa agaattgaac ggtcaaattt tagcacgcca ccaaggtatg atgcttccgg
    94441 gcggtgttac aattgatggg cagcgcttaa tagaagaagc cagattagaa aaagaagcac
    94501 tgcgcgaaga attatactta cttgatcctc catttggaat tttggtaggt taatatggct
    94561 acttatgata aaaatctttt tgctaaattg gaaaaccgca caggttattc tcagaccaat
    94621 gaaactgaaa tattaaatcc ttatgtaaat ttcaatcatt ataaaaacag ccaaatatta
    94681 gctgatgtat tagtagctga aagcattcaa atgcgaggtg tagaatgcta ttatgttcca
    94741 agagagtatg tttcccctga tttgatattc ggcgaagact taaaaaataa atttactaaa
    94801 gcttggaaat ttgctgcata tttaaattca tttgaaggat atgaaggagc taaatcgttc
    94861 tttagtaact ttggtatgca agtacaagac gaagtgactt tatctattaa cccaaattta
    94921 tttaagcatc aagttaacgg aaaagaaccc aaggaaggtg atttgatata ttttcctatg
    94981 gataacagct tatttgaaat taactgggtt gaaccatatg atccatttta tcaattaggc
    95041 caaaacgcta ttcgtaaaat tacggcaggt aaattcattt attctggaga agaaattaat
    95101 ccagttctac agaaaaatga aggaattaac attccagaat ttagtgaatt agaattaaat
    95161 gctgttcgca atcttaacgg tattcatgac attaatattg atcagtatgc tgaagtagat
    95221 caaattaatt ctgaagctaa agaatacgtt gaaccttatg ttgttgtcaa taacagaggc
    95281 aaatctttcg aatctagccc atttgacaat gatttcatgg attaataaat attataaact
    95341 aattaaagcc cggattagga gaagtcatgt ttggttattt ttataattcg tcttttagac
    95401 gatatgctac cttgatgggc gatttgtttt caaatatcca aatcaaacgt cagttagaat
    95461 ctggtgataa gtttatacgt gttcctatta cgtatgcatc aaaggaacac tttatgatga
    95521 aattgaataa atggacatca ataaattcac aagaagatgt agctaaagtt gaaactattc
    95581 tacctcgtat aaatttacat ttagttgatt ttagctataa tgctccattt aaaacaaaca
    95641 ttttaaatca gaatttactg caaaaaggtg caacttctgt agtatcgcag tataatccat
    95701 ctcctattaa aatgatttat gaattgagta tctttactcg ctatgaagat gatatgtttc
    95761 aaatagttga acagattctt ccatattttc aacctcattt taatacaact atgtacgagc
    95821 agtttggaaa tgatattcca tttaaaaggg atattaaaat tgtactgatg tctgctgcta
    95881 tagacgaagc tatagatggg gataatttat ctcgtcgtag aattgaatgg tcattaacat
    95941 ttgaagtaaa tggatggatg tatcctccag tagatgatgc agaaggatta attcgtacta
    96001 cttatacaga ttttcacgcc aatacaagag atttgcctga cggcgaaggt gtttttgaat
    96061 ctgtcgatag cgaagttgtt cctcgagata ttgacccaga agactgggat ggaacagtaa
    96121 aacaaacttt cactagtaat gtaaatagac caacaccgcc agaacctcct ggcccaagaa
    96181 catagaggtt attatggaag gtcttgatat aaacaaactt ttagatattt ctgacctccc
    96241 cggaattgac ggggaggaaa tcaaagtgta tgaacctctg caattagtag aagttaaaag
    96301 caatccacaa aaccgtactc cagacttaga agatgattat ggagtagttc gtcgaaatat
    96361 gcattttcag caacaaatgc taatggacgc tgccaagatt tttcttgaga cagcaaagaa
    96421 tgctgattct cctcgtcaca tggaagtatt tgcaactctt atggggcaaa tgactacgac
    96481 gaacagagaa atactgaagc ttcataaaga tatgaaagac attacatctg agcaggttgg
    96541 caccaaaggc gctgttccta caggtcaaat gaatattcag aatgcgacag tattcatggg
    96601 ttcaccaaca gaattaatgg acgaaattgg tgatgcttac gaggctcaag aagctcgtga
    96661 gaaggtgata aatggaacaa ccgattaatg tattaaatga tttccatccg ttaaatgaag
    96721 ctggaaaaat tttaataaaa cacccaagct tagcggaaag aaaagatgaa gatggaattc
    96781 attggataaa atctcagtgg gatggaaaat ggtatcctga aaaattcagt gattaccttc
    96841 gtctacacaa aatagtaaaa attccaaaca actctgataa gcctgaatta tttcaaactt
    96901 ataaagataa gaataataaa agatctcggt atatgggtct tcctaacttg aaacgagcta
    96961 atattaaaac acaatggact cgtgaaatgg ttgaggaatg gaaaaaatgc cgagatgata
    97021 ttgtttattt tgcagaaaca tactgtgcca ttactcatat tgactatggt gtcataaagg
    97081 ttcaattacg tgactatcag cgtgatatgc tcaaaataat gtcatctaaa cgtatgactg
    97141 tttgtaatct atcgcgccag ctcggtaaaa ccaccgtagt agctattttc cttgcacact
    97201 ttgtatgttt taacaaagat aaagctgtag gtattcttgc acacaaaggc tcaatgtctg
    97261 cggaagtttt agaccgtact aagcaagcaa ttgaactgct tcctgacttt ttacaaccag
    97321 gaattgttga atggaataag ggttcaattg aactagataa tggttcttca attggcgctt
    97381 atgcttcctc tcctgacgca gttcgtggta actcgttcgc aatgatttac attgacgaat
    97441 gtgcgtttat tccaaacttc catgattcct ggcttgctat tcaaccagta atttcatctg
    97501 gtcgtcgttc gaaaattatt attactacga ctcctaatgg attaaatcat ttttatgata
    97561 tttggactgc tgctgtcgaa ggtaaatctg gatttgaacc atatactgct atttggaatt
    97621 cagttaaaga acgtctttat aacgatgaag atatttttga cgatggatgg caatggagca
    97681 tacaaaccat taatggttct tcattagctc aattccgtca agaacatact gcagcgtttg
    97741 aagggacttc tggtacatta atttcaggaa tgaaattagc tgttatggat tttattgaag
    97801 taacaccaga tgatcatggt tttcaccaat ttaaaaaacc tgaaccagat agaaaatata
    97861 ttgcaactct agattgctca gaaggtcgtg ggcaagatta ccacgctttg catattattg
    97921 atgttactga tgatgtgtgg gaacaggttg gtgttttgca ttcaaacact atttctcatt
    97981 taattctacc tgacatcgtt atgcgttatt tagtagaata caatgaatgc ccagtttata
    98041 ttgaattaaa tagtactggt gtgtcagttg caaaatcgct ttatatggat ttagaatacg
    98101 aaggtgttat ctgcgattca tatactgatt taggaatgaa acaaactaaa cgcacgaaag
    98161 cagtaggatg ttccacgcta aaagacctta ttgaaaaaga taagcttatt attcatcacc
    98221 gagcgactat tcaagaattt agaacgttta gtgaaaaagg cgtgtcttgg gcggctgaag
    98281 aaggttatca tgacgattta gtaatgtctt tagtgatttt tggatggtta tcaacgcagt
    98341 caaaatttat tgattatgcg gataaagatg acatgcgatt agcatctgaa gtattttcaa
    98401 aagagcttca ggatatgagc gacgactacg cgccagttat atttgtggat tcggttcatt
    98461 ctgctgagta tgttccagta tctcatggta tgtcaatggt ataaatatat taaagcatat
    98521 taaagaggat taaaaatgac tttattatct ccgggcattg agctcaaaga aactacggtt
    98581 caaagcaccg tagttaataa ctctactggt acagcagctt tggccggtaa attccagtgg
    98641 ggtcctgctt ttcagattaa acaggttaca aatgaagtag atttagttaa tacttttggt
    98701 caaccaaccg ctgaaactgc tgactatttt atgtctgcga tgaatttctt gcagtacgga
    98761 aatgacttac gagtagttcg tgctgttgat agagataccg ctaaaaactc atcgccaatt
    98821 gctggtaata ttgattacac aatttctacc ccaggtagta actatgcggt tggagataaa
    98881 atcacggtca aatatgtttc agatgatatt gaaactgaag gtaaaattac tgaagtagac
    98941 gcagatggaa aaattaagaa aattaatatt cctactggca aaaattacgc taaagcgaaa
    99001 gaagtcggtg aatatccaac actaggttct aactggactg cggaaatttc ttcatcttcc
    99061 tctggtttag ctgcagtaat aactcttgga aaaattatta ctgattctgg tattttatta
    99121 gctgaaattg aaaatgctga agctgctatg acagcggttg actttcaagc aaatcttaaa
    99181 aaatatggaa ttccaggagt agtagcgctt tatccaggcg aattaggcga taaaattgaa
    99241 attgaaatcg tatctaaagc tgactatgca aaaggagctt ctgcattact cccaatttat
    99301 ccaggtggtg gtactcgtgc atctactgct aaagcagtgt ttggatatgg accgcaaact
    99361 gattcacagt acgctattat agttcgtcgt aatgatgcta ttgttcaaag cgttgttctt
    99421 tcaactaagc gtggtgaaaa agatatttac gatagtaaca tctatatcga tgactttttc
    99481 gcaaaaggtg gttcagaata tatttttgca actgcacaaa actggccaga aggcttctct
    99541 ggaattttaa ctctgtctgg tggattatca tcaaatgctg aagtaacagc aggagatttg
    99601 atggaagctt gggacttctt tgctgaccgt gaatctgttg acgttcaact gtttattgca
    99661 ggttcttgtg ccggtgaatc tttagaaaca gcatctactg tccaaaaaca cgtcgtttca
    99721 attggggatg ctcgccaaga ttgcttagta ttgtgctctc ctccgcgtga aactgtagtt
    99781 ggaattcctg taacccgtgc tgttgataac ctagtcaatt ggagaactgc ggcaggttca
    99841 tacactgata ataactttaa tatcagttca acctatgcag caattgatgg taaccataag
    99901 tatcagtatg acaaatataa tgatgtgaat cgttgggttc cattagcagc tgatattgct
    99961 ggtttatgcg caagaactga taacgtatct cagacttgga tgtctccagc tggttataat
   100021 cgtggtcaga ttcttaacgt tattaaactt gctattgaaa ctcgccaggc tcagcgcgac
   100081 cgtttatacc aagaagctat caacccggta accggtacag gtggtgatgg ttacgtattg
   100141 tatggtgata aaacagctac ttctgttcct tctccatttg atcgtattaa cgttcgtcgt
   100201 ctgtttaata tgttgaaaac gaatatcgga cgtagttcaa aatatcgttt gttcgaatta
   100261 aacaacgcgt ttactcgttc atcattccgc acagaaactg cccagtactt acaagggaat
   100321 aaagctctcg gtggaattta tgaatatcgt gtagtttgcg atacaacaaa taacactccg
   100381 tcagtaattg atagaaatga gtttgttgca acattctaca tccaaccggc tagaagcatt
   100441 aactacatta ccttaaactt cgtagcaact gctactggtg cagatttcga tgagttaact
   100501 ggtcttgctg gttaatacgg tgcattctaa aggcctgttt cggcaggcca tataaataca
   100561 ctatatcctt aattctttaa ttctatatgc cctaggttaa acatagggat ataaatacta
   100621 cagaggctaa tatgtttgta gatgatgtaa cacgagcgtt tgaatctggt gattttgctc
   100681 gacctaactt attccaagta gaaatttctt atcttggaca aaattttacg ttccaatgta
   100741 aagctactgc tctaccagct ggtattgtag aaaaaattcc agtcggattt atgaaccgta
   100801 aaattaacgt agcaggcgat cgtacattcg atgactggac tgttacagta atgaacgatg
   100861 aagctcatga tgctcgtcag aagttcgttg attggcaaag cattgctgcg gggcaaggaa
   100921 acgaaattac tggtggaaaa cctgcagagt ataaaaagag cgctatcgtt cgtcaatatg
   100981 ctcgtgacgc taaaacagta acaaaagaaa ttgaaattaa aggtctgtgg cctactaacg
   101041 tgggtgaact tcaattagat tgggattcaa acaatgaaat ccaaactttt gaagtaactc
   101101 ttgctctcga ttattgggaa taaaatgaat ggggagaaat ccccatcctg cttaaagcag
   101161 agaagtccat tataaatata actataattc ccatttggag aatacaatga aatttaatgt
   101221 attaagtttg tttgctccat gggctaaaat ggacgaacga aattttaaag accaagaaaa
   101281 agaagatctt gtttccatta cagccccaaa gcttgatgat ggagcaagag aatttgaagt
   101341 aagctcgaat gaagctgctt ctccttataa tgctgcattc caaacaattt ttggttcata
   101401 tgaaccagga atgaaaacta ctcgtgagct tattgataca tatcgtaatc tcatgaataa
   101461 ctatgaagta gataatgcag tttcagaaat cgtttcagat gctatcgtct atgaagatga
   101521 tactgaagtc gtagcgttaa atttggataa atctaaattt agcccaaaaa ttaaaaatat
   101581 gatgttagat gaatttagtg atgtattaaa tcatctatcg tttcaacgaa aaggttctga
   101641 tcattttaga cgttggtatg ttgattcaag aattttcttt cataaaatca ttgatccaaa
   101701 acgtccaaaa gaaggcataa aagaattacg tagattagac cctcgccaag ttcagtatgt
   101761 tcgtgaaatt ataacagaaa ctgaagctgg cacaaaaata gttaaaggtt acaaagaata
   101821 ttttatatat gatactgccc atgagtcata tgcatgtgat ggtagaatgt atgaagctgg
   101881 cacaaaaata aaaattccta aagctgccgt cgtttatgcc cattctggat tagtcgattg
   101941 ttgcggtaaa aatatcatcg ggtatttgca tcgtgctgtt aaacctgcta accaattaaa
   102001 attattagaa gatgctgtag tcatttatcg cattactcgt gctcctgacc gtcgtgtttg
   102061 gtatgtagac acaggtaata tgcctgctcg taaagctgct gagcacatgc aacatgttat
   102121 gaacacgatg aaaaaccgtg tagtatatga tgcatcaaca ggtaaaataa aaaatcaaca
   102181 gcataatatg tctatgaccg aagactattg gttgcagcgc cgtgatggta aagctgtgac
   102241 agaagttgat actcttcctg gtgctgataa tactggcaat atggaagata ttcgttggtt
   102301 tagacaagct ctttatatgg cattacgtgt tcctctttca cgcattccgc aagaccaaca
   102361 aggcggtgtg atgtttgatt ctggaactag cattacacgt gatgaattaa cgtttgctaa
   102421 atttattcgt gagttacagc acaagtttga agaagttttc ctagatccgc ttaaaacaaa
   102481 tcttttgctt aaaggtataa tcacagaaga tgagtggaat gatgaaataa ataatattaa
   102541 gatagaattt catcgggata gctactttgc tgagctcaaa gaagcagaaa ttttggaacg
   102601 aagaattaat atgctaacca tggcagaacc atttattggt aaatatattt ctcacagaac
   102661 tgctatgaaa gacattttgc agatgactga tgaagaaata gaacaagaag ccaagcaaat
   102721 tgaagaagag tctaaagagg ctcgtttcca agaccccgac caagaacaag aggattttta
   102781 atggaaggtt taattgaagc tattaaatca aacgacctcg tagccgctcg taaattattt
   102841 gctgaagcca tggctgcaag aacgattgat ttaattaaag aagaaaaaat cgctatcgct
   102901 cgcaatttct taatcgaagg tgaagaacct gaagacgagg atgaagatga agatgacgaa
   102961 gatagtgatg ataaagacga caaaaaagac gaagactctg acgaagacga ggatgatgaa
   103021 taatgcttct gatccctgaa actcatgaat tagttctcga gaatgtcgaa gcacttattc
   103081 ctgaagcaca gggtcgcttt gacgaattgt cttctgcttt aaataaagac gatataaata
   103141 caattgtcga gaatatgctt gatgatgaaa ctgatttagc ggttgcatta gcttctatta
   103201 atgaaaatat gccgttaaat gaattcatcg ttaaacatgt ttctgcccgt ggtgaaatta
   103261 ctcgcactaa agaccgcaaa acgcgtgaac gaaatgcatt tcaaaccact gggctgtcta
   103321 aagcaaaacg tagacaaatt gctcgtaaag ctaccaaaac gaagattgcc aatccagcag
   103381 gtcaatctcg tgctcagcgt aagcgtaaaa aagctcttaa acgccgtaaa gcattaggat
   103441 taagctaatg aatgaacccc aattactaat tgaaacttgg ggtcaacctg gcgaaattat
   103501 tgatggcgta ccaatgcttg aatctcatga tggaaaagac ttaggtttaa aaccgggttt
   103561 atacatcgaa ggaatattca tgcaagcgga agtcgtcaat agaaataaac gtctttatcc
   103621 aaaacgtata ttagaaaaag cggtaaaaga ctatattaat gagcaagttt taactaaaca
   103681 agctctcgga gaattaaatc atcctccacg cgctaatgtt gacccgatgc aagccgctat
   103741 cattatagaa gatatgtggt ggaaaggaaa tgacgtatac ggacgagctc gtgttattga
   103801 aggtgaccat ggtcctggag ataaattagc agctaatatt cgtgccggat ggattccagg
   103861 agtttcttct cgtggattag gttcattgac tgacacaaat gaaggttatc gtatcgtaaa
   103921 cgaaggattc aaattaactg taggtgttga tgcagtatgg ggtccaagtg ctccagatgc
   103981 atgggtaact cctaaggaaa ttaccgaatc acagacggcg gaagccgata caagtgccga
   104041 tgacgcctat atggctctcg cagaggccat gaaaaaagcg ttataaatat tattatctaa
   104101 acaacaggac tacaaaatgc ttaaagaaca actgattgcc gaagcgcaga aaattgatgc
   104161 ttccgttgct cttgatagta ttttcgaatc agttaatatt tctccggaag caaaagaaac
   104221 tttcggcact gtattcgaag ctaccgtcaa gcagcacgcc gttaaattag ctgaatctca
   104281 tatcgctaaa attgctgaaa aagcagaaga agaagtagaa aaaaataaag aagaagccga
   104341 agaaaaagct gagaagaaaa tcgctgagca agcttctaaa ttcattgacc atcttgcaaa
   104401 agaatggctc gctgaaaata aattagcagt tgataaaggc atcaaagccg aactgtttga
   104461 atccatgctt ggtggattaa aagagctctt tgttgaacac aacgttgttg ttccagaaga
   104521 atcagttgat gttgtagctg aaatggaaga agagctgcaa gaacataaag aagaatcgcc
   104581 tcgtctgttc gaagaactga atatgcgcga cgcatatatc aattatgtgc agcgtgaagt
   104641 ggcattgagc gaaagtacta aagatctgac tgagtctcaa aaagaaaaag tctctgctct
   104701 ggtcgaaggt atggattatt cagatgcatt ctcaagtaaa ttgagtgcaa tcgtagaaat
   104761 ggtgaagaaa tctaataaag atgaaagcac tattactgag agtataaata ctcctgatac
   104821 tgaagcagcc ggactgaatt tcgtcactga agctgtagaa gataaagctg cacagggtgc
   104881 agaagatatt gtaagtgtat atgcgaaagt cgcatctcgt ttctaatttt aaaggttaac
   104941 acaaatgact atcaaaacta aagctgaact tttgaacaaa tggaagccat tactggaagg
   105001 tgaaggttta ccggaaattg ctaatagcaa acaagcgatt atcgctaaaa tctttgaaaa
   105061 ccaggaaaaa gatttccaga cagctccgga atataaagac gaaaaaattg ctcaggcatt
   105121 cggttctttc ttaacagaag ctgaaatcgg tggtgaccac ggttacaatg ctaccaacat
   105181 cgctgcaggt cagacttctg gcgcagtaac tcagattggc ccagctgtta tgggtatggt
   105241 acgtcgtgct attcctaacc tgattgcttt cgatatttgt ggtgttcagc cgatgaacag
   105301 cccgactggc caggtattcg cactgcgcgc agtatatggt aaagacccag tggctgccgg
   105361 tgctaaagaa gcattccacc caatgtatgg tccagatgca atgttctctg gtcagggtgc
   105421 tgctaagaaa ttcccagctc tggctgctag cacacaaacc acagtaggtg atatctatac
   105481 tcacttcttc caggaaactg gtactgtata tctgcaagct tctgttcaag taacaatcga
   105541 tgctggtgcg actgatgctg ctaaattaga tgctgaaatt aagaaacaaa tggaagctgg
   105601 tgcactggta gaaatcgctg aaggtatggc tacttctatc gctgaactcc aggaaggttt
   105661 caatggttct accgataacc catggaatga aatgggcttc cgtatcgata agcaagttat
   105721 cgaagctaaa tctcgtcagc tgaaagctgc ttactctatt gaattagcac aagacctccg
   105781 cgctgttcac ggtatggatg ctgatgctga actgtctggt attctggcta cagaaattat
   105841 gctggaaatc aaccgtgaag ttgttgattg gattaactac tcagctcagg ttggtaaatc
   105901 tggtatgacc ctgactccgg gttctaaagc tggtgtattt gacttccagg acccaattga
   105961 tattcgtggt gctcgctggg cgggtgaatc ctttaaagct ctgttgttcc agattgacaa
   106021 agaagcagtt gaaattgctc gtcagaccgg tcgtggtgaa ggtaacttca ttatcgcttc
   106081 ccgtaacgta gttaacgttt tggcttcagt tgataccggc atttcttatg ctgcacaggg
   106141 tctggctacc ggctttagca ctgatactac caagtcagta tttgctggtg ttctgggtgg
   106201 taaataccgc gtatatatcg accagtatgc taaacaggat tatttcactg taggttataa
   106261 aggtccgaac gaaatggatg ctggtattta ctatgctcca tatgtagctc tgactccgct
   106321 gcgtggttcc gatccgaaga acttccaacc ggtaatggga ttcaaaactc gttacggtat
   106381 cggtatcaac ccatttgcag aatccgctgc tcaggctccg gcttctcgca tccagagcgg
   106441 tatgccttct attctgaata gccttggtaa aaacgcttac tttagacgtg tatatgttaa
   106501 aggtatctaa tctctaacga tagaaacaca attttaggga accttcgggt tccctttttt
   106561 ctattttata cgatagcaat caggcatatc atccgcattt atccaattgc gaatagtttt
   106621 aggactaact ttaaaatgct ccgctgcgta atcaggatta tcaaatttaa cgccctttat
   106681 acatattgga ataaattttt taataccacc aagtttttca gaaatagctt tacgatgtga
   106741 aatcgatata ggtttgtttt ttcgtggatg aacatgtgtt ttataatatt cattgcgccc
   106801 tttaactcgc ttcgcaatag tttcatcaga ttgcttaacg cctgtttttg cctttgatat
   106861 ttttcgttta gcttccacag tcattccttc ttttgttcgt attgataaca tattacgata
   106921 tgaaggatct tgcaaatgaa ctataactgg atttcctctg ccaccaatag cagcattata
   106981 ggtatcagtt ctcataacga attcctcatt aactagtaaa gcttccattt tatacatctc
   107041 ctcagatgag gagaaagaat aaagaatttc ttttttaaag ttatgaatac catatttttt
   107101 gatggatttt ttgatgttta cgccagaacc catataacca tcgttttcgt caagagtagc
   107161 atgagctccg atgtaaattt ttccattgat gatattagta atttgatata ttaaatattt
   107221 cattttaaac atcactccgt ttgtatatga ttataatatc atattacttt ggtcttgtaa
   107281 ataactttat aaatagtatt atatttcaac aaggaaaata caatggctaa aatcaacgaa
   107341 cttctgcgcg aatcaaccac aacgaatagc aactcaatcg gtcgcccaaa tctcgttgct
   107401 ttgactcgcg ctaccactaa attaatatat tctgacattg tagcaacgca aagaactaat
   107461 caacctgttg ctgcttttta tggtatcaaa taccttaacc cagacaacga atttacattt
   107521 aaaactggtg ctacttacgc tggcgaagct ggatatgtag accgagaaca aatcacagaa
   107581 ttaacagaag agtctaaatt aactctcaat aaaggcgatt tattcaaata taataatatc
   107641 gtttataaag tattagaaga tactccattt gctactatcg aagaaagtga tttagaatta
   107701 gctcttcaga ttgcaatcgt tcttttaaag gttcgtctat tttctgacgc agcgtcaaca
   107761 agcaaatttg aaagctctga tagtgaaatt gcggatgcta gattccagat taataaatgg
   107821 caaactgcag ttaaatctcg taaacttaaa actggcatca cagttgaatt agcgcaagat
   107881 ttagaagcaa atggattcga tgctcctaat ttcttggaag atttgcttgc aactgaaatg
   107941 gcagatgaaa tcaataaaga cattctgcag tctttgatta cagtgtcaaa acgctataaa
   108001 gttacaggaa ttactgatag tggattcatc gatttgagtt atgcatctgc tcctgaagct
   108061 ggtcgttcat tataccgaat ggtatgtgaa atggtttcgc atatccaaaa agaatcaact
   108121 tatacagcaa cgttctgtgt tgcttcagct cgtgccgctg cgattcttgc tgcatcaggc
   108181 tggttaaaac ataaaccaga agatgacaaa tatctttcac aaaatgccta cgggttctta
   108241 gctaatggtt taccgcttta ttgcgatact aacagcccat tagattatgt aatcgttggc
   108301 gtagtagaaa atatcggtga aaaagaaatt gttggatcaa ttttctatgc tccgtataca
   108361 gaaggtctcg acttagatga ccctgaacat gtaggtgcat ttaaagttgt tgttgatcca
   108421 gaaagcttac aaccatctat cggtttatta gttagatatg ctttatcagc aaatccttat
   108481 actgtagcaa aagatgaaaa agaagcaaga ataattgacg gtggagacat ggataaaatg
   108541 gcaggtcgtt cagatttgtc tgttttatta ggtgttaagc taccaaaaat tatcattgat
   108601 gaataaaaca aagggacctt tcggtccctt tttatttaac ttaccaactc aatccaagct
   108661 ggacgaagta catcttgtac cattttaact aattcctttt taatcaaaga aggattatct
   108721 gcttgagtta gagtaatacc ttcacgagaa gtttcttcca aaatatcttg aacagttagc
   108781 cccatcacct ttccaaaatc ctttggacca atttcgccaa ttttagaaat aacgttattt
   108841 acgcggttca gtgtaacgta acaagctaaa attcccacca atttgttatc agcttctgat
   108901 agctcaactt tagctttaat aggcttatca gactttttct tttcactaaa tttagagttc
   108961 ttgcatttaa tcgctacacg atttccatta cgaagccaag aaggataaca aggtttcaat
   109021 acatatcctt cagcagtaaa tacttcgcct tttgcttcgg cattccaaac gcatttattt
   109081 gcatcaacta atccagcatg gtctactgta aaattataat cttggacgac agaatctaaa
   109141 tcatttggca atttaataag ctcttcaaat ttaccgcgac ctaaaagtgg agccatttta
   109201 aatttaaatg tattacagaa tgattccatc atataatcat ctacataagt cacatcaccg
   109261 ctttctgtag taacaataat gtcaaataca taaaaatctt tatcacaata atcaacattc
   109321 ttctgaatgc caggtccagc gaattcgcca aagacttgat aagatacaac cgctgaggtt
   109381 tccataatat cttgtacagc tttaatggaa tcagcataat tcttcaaaat aatttcatac
   109441 ccaaagaaat cttcagcagg aagaatcggt ccagtgcgtt tagcgcaagt cactttatca
   109501 cgctcaataa tcaatgagaa atttgtgccg tgaatctttt cacgagctac ccactcccca
   109561 ccagtcaatc ccaagctata aagtttttca ataaatttag agttgtaatg attttcaaga
   109621 ctgctatact ttttaaacat aattaatcct caaaatgtaa tttctaacca atcaccatca
   109681 cgctgatcac tattgacttt aaagctgaat ccttcttttc tcagccaatc accaatttct
   109741 tctgtaatca atttatcacg agcaatacaa taataattaa aatgtgtttt accttgttca
   109801 gctgctttat tagcaagttc tgaaaaatct ttaataaaac actctagctt aaactgttta
   109861 ctttttaatg ctttttcgcg taattgatta gcaaaagatt cattttcata aagatcatac
   109921 tgttccattt ttcacctttt tattgatatg tctttttcta tagacaactt tttctcgagc
   109981 ccataataca gccacttctt ttgcctgtaa gtttaattca cgagcaattt caatgaatga
   110041 ctttccagac tcatgaagag taaacaccac aacctcagtt ctcataatca atctcatgtt
   110101 atcgagttgg tgccattata tacatcattt tctgattgtg ttttgtgtgc tttcaaaatg
   110161 aagaaagggg ccgaagcccc ttatgattat ggataggtat agatgatacc agtttctaaa
   110221 gcagttttat gaatgatgta tccattacgc gattcttgga catcaacttc tggatagtct
   110281 ttcatcatct tctggagagt gtaacgatgc aggtaatatt tactatctgg gtcgtcagtt
   110341 ttccaatctt taccttcttc ggtcattttt tggatttcat ccataaccca ccaaccgcac
   110401 cagatgtaag ctgagctacg gtgtggaaga ggatgaacat aaggtaattc accttctggt
   110461 tctggagcaa ctttagccgt gactgttaca ttaccagttt tggtaacggt tacagggtta
   110521 taatctgcag cagtaacagt tgcagtaact tcaatagttt gacttccaac agatgaggta
   110581 tcgacagtat atacgttagt tgacccttct acaggagaag aatctttctt ccatgagtaa
   110641 gtaatttgtg cttcttctgg agcacccgta acattagccg taaatgtagc cgaagcatct
   110701 tgctgaacat taatagaagg aggagtcaat gtaacctgtg gattcattgt cttcttatta
   110761 accgttaatg atacttcatt agaagtaacg cttagtgcat cataatctgt cgcggttact
   110821 tgggctacgc atttaattct ttttactcca cttgtagttg gagtatagct aaatgtagag
   110881 ttagtttctc caccaacttg tgaatcatct acataccact gatacgtagc agatgctcca
   110941 tcaggttgag aagctaaggc agcagtaaat tgaactgggg ttccaatcac tccagccgca
   111001 ggactagcag gagttacggc taaggtagtc gtctgtgtct tatttttaac tgtgatagtt
   111061 gttgtcgctt cagccgtttc cgggcctcct tcagaaagtg tatttgttgc aactacttta
   111121 atagtctttt gaccggcagg tccttttagt acataactaa aagttgcttc agctccatct
   111181 tgtggaacat tatctacgct ccaagcatat gtaatagttc cgcctccagt ttgaccactg
   111241 ggtgtagcag taaactgctt agtttcatca ataacccctg taggtgtttt aggagttata
   111301 tcaactgtaa aagtcataag ttatccttat tttaatgtta cgaaagaaga gttgcgtgtt
   111361 tcacgaatta aaactgatcc atcgcgatta atgtaataaa ttaagctaaa taaagtttgg
   111421 tgtgctgacg catgttcaaa actagttggg tgagatttcc aatcaggagt ttcagcaatc
   111481 cattgataaa tccaccaagg aacagtacag aatcctagat tttttccaat cagttgaaga
   111541 ttcggactaa agttttccgg aagagtaaat acagacggct tttcagattc aataatctca
   111601 gctacagcct gttcgaattt ttcttcaaca aaaggagtat cttcaatcaa aacatcggta
   111661 ttttcaggaa ttttatccgt ttctactact tcaattttaa tgtcagattt aatcggagaa
   111721 tcaatcagaa gtgctgcttc tggattgact tcttcatcgt catattttaa tccctctgcg
   111781 gcatcagcag catcaattaa gtctttaata gataacccat cagtctctgg cataggttca
   111841 ctagcgagct tctggagggc ttcttcaata tcaacaacga tattatcaaa agatttattc
   111901 tttttgacct ttataccaaa ctgttcagca tattcagcta atttagcttt agcttctttg
   111961 ttatcatcaa gagccttcag ctctgcaata taatctttat ctatcataat atttcctcag
   112021 tataaatata gatatattta ttactcggaa aatagtatgt accactttgt atatgaaaca
   112081 acaaatctaa taaatggtaa aaagtatata ggaaagcact ctactgatga cttgaatgat
   112141 ggttaccttg gttccggtaa ggcaattcag caggctataa agaaatatgg tgaaaacaat
   112201 ttctctagaa caatactaaa agagtttaaa acttccgaag aagcgtacat gtatgaagaa
   112261 gaaattataa ctcctgaact aataaaaagc aaaaattatt ataatatgaa acctggtgga
   112321 attggtggaa ttgttatgac tacagatgtt atagcaaaga tgaaagaatc ttccgctaaa
   112381 agatttgaaa actcaccggg cacggtatta ggtaaaactt gttatactaa tggaactaaa
   112441 aatattttta ttaaacctgg agaacttgtt ccagaaggat ttgtaaaagg gatggttcat
   112501 cctaatagaa agtccagaaa aggatgtaaa gtcaaaccga ctaccacagg aactttttgg
   112561 gtcaataatg gcgcaataaa taaattaata caaccagacg gtattattcc cgacggattt
   112621 attaaaggtc gtctcatgaa aagagattct aaaggcaaat ttagtaaggc ataattatgg
   112681 atattaaagt acattttcac gacttcagtc atgtacgcat cgattgtgaa gagagcacgt
   112741 tccacgaatt aagagatttc ttttcgtttg aggccgatgg atatagattt aatcctcgct
   112801 tcagatatgg caactgggat ggacgaatcc gtcttttaga ttataatcgt cttcttccat
   112861 tcggcttagt cgggcaaatt aaaaaattct gtgataattt tggctataaa gcctggattg
   112921 acccacaaat taacgaaaaa gaagaattat caagaaaaga ttttgatgaa tggctttcta
   112981 aattagaaat ctattcagga aataaaagaa ttgaaccgca ctggtatcaa aaagatgcag
   113041 tgttcgaagg attagttaat cgtcgtagaa ttcttaatct tccaacatct gcaggtaaat
   113101 ctttaattca agctttgctt gcgcgatatt atttggaaaa ttatgaaggt aaaattctta
   113161 tcattgttcc aacaactgct ctgacaactc agatggctga tgacttcgtc gactatcgtt
   113221 tattcagcca tgcaatgata aagaaaattg gtggcggagc atcaaaagat gataaatata
   113281 aaaatgatgc accagtcgtt gttggtacat ggcaaactgt agtaaaacaa ccgaaagaat
   113341 ggttctcaca gtttggaatg atgatgaatg atgaatgcca tcttgctaca ggaaaaagta
   113401 tttcatctat catatcaggt ttaaataact gcatgttcaa attcggtttg tctggttcat
   113461 tacgtgatgg caaagccaat atcatgcagt atgttggaat gtttggtgaa atatttaaac
   113521 cagtaacgac ttctaaatta atggaagatg gacaagtaac tgagctaaaa attaatagta
   113581 tttttcttcg ctatcccgat gagttcacta ctaaattaaa gggaaaaact taccaagaag
   113641 aaataaaaat tattactggg cttagtaaaa gaaataaatg gatcgctaaa ttagctatta
   113701 agcttgcgca aaaagatgaa aacgcttttg tcatgtttaa acatgtatcg catggtaaag
   113761 ctattttcga tttaattaaa aatgaatacg ataaagttta ttacgtatca ggggaagttg
   113821 ataccgaaac ccgcaatata atgaaaacct tagctgaaaa tggtaaagga ataattatag
   113881 tagctagtta tggtgtattt tctactggta tttcagttaa aaatctgcat cacgttgttt
   113941 tagcgcacgg tgttaaatca aaaatcattg tattacaaac aatcggtcgt gtattacgta
   114001 agcatggttc taagacaata gcaacagtct gggacctcat agatagcgca ggcgtcaagc
   114061 caaaatctgc taatacgaaa aagaaatatg ttcatttgaa ctatctttta aaacacggca
   114121 ttgatcgtat tcagcgctac gcagatgaaa aatttaatta cgtaatgaaa acagttaatt
   114181 taataagctt cggccctttg gagaaaaaga tgttactaga atttaaacaa tttctttatg
   114241 aagcttctat tgatgaattt atgggtaaaa ttgcctcttg tcaaacatta gaaggtttag
   114301 aagaacttga agcttattat aagaaaagag tcaaagaaac tgaattaaaa gatactgatg
   114361 acatctctgt gagagatgct ttggcaggaa aaagagctga attagaagat tcagacgatg
   114421 aagtagaaga aagcttttaa attaaaaaag gcccaaccaa aaaggaaggg ccaaaactat
   114481 agactaaagg tcacactata gcaaaagttg tgtttcattt aattgttctt ccgaactttc
   114541 tgaaactggt agttctttaa tgtaattata gcaaggccca ggatgtacag gacctttgtc
   114601 tgtttcaaca accaatgcag aatcgattgg agttttacag acaacacaaa tcttatctga
   114661 catgattgtc tcctctgaat tatatctatt tatacaactc tcatatgcat atcaatgccc
   114721 atatctttag aataaaaata ttcatcaaga tatccggcaa attttccttt aatataaagg
   114781 acatcttcac cacacgggtg gtcggccagg atacgaatat cctgacgctt aagattatgc
   114841 tttttcatta agaattgaat ttccgtttca aattcttctt cataattaaa agcatcatca
   114901 atgctatatc tcattatttt ccagcctcaa atgctcgcat gtcttgaata tgcttaatag
   114961 caaatccacg tgatttaata gcatcaagag ctccgctaca gaaatctaat aaaatccccc
   115021 aatactgcaa cgaggtatca acctttaaaa catccttatc cgctgataga actgtcttca
   115081 tttctgattt ctcgtaacga tccatactaa attcatcacc atctcctcgt cccgagtagt
   115141 agtctaatct agctttaaga gcaacttttt tctgtgcttc aattctaagc atttcctttt
   115201 taatacttga atgcttatta agccatttac tatataacat cacattatta gctgcttcat
   115261 actgtaattt agtcgaatct ataaacacat ctttcttcaa ttcttcttga agatcttcta
   115321 atctcatatt gttctctatt caattgttat tggttgttat tggatggact tagattcatt
   115381 ataccacgtt ttaacgtgaa gcattatact ctattactgg aagccagctg cagttttatc
   115441 tgctcaatat catcaggatt atcgatgacc gaaaagcgta tttctactat cagagtataa
   115501 tcgtcataaa cgggtatcac attaactgct aatttatcaa tacgtggctc atagtttctt
   115561 actgcgcttt cgatattgcg ttcaaccgtg tcagcagtaa gaggagtcat attttcaaaa
   115621 agctggtctg ataaatcaca tccaaattca gggtcaaacg gtcttgaacc ttttcttgtt
   115681 gtaataattc ccaaaagact gtttttaatt gaccttaatc caagcgatct ggaaacgtct
   115741 ttgttccaat ccattttcat ttccgggtca atatcagaat aaagcttatt aatatttgcc
   115801 attatagtaa ctcaaagaac tctttgaggc ctcttattac gtgagcatgg gtttttccac
   115861 actctggaca cttaattgga acagccaaat aaacggtagg ctttaaaagc atatctttta
   115921 tagctacaat atctgactct gtgatgatag aatataaatc ttctagttcc ttttcattta
   115981 agtcttcaac tggaatgctt tccccgttag catgaatcgt ttctatacat gatactatca
   116041 tgtgggctat atttttatca tcaaaaattt tagggtatcg gaatttaatt ttaatgtcac
   116101 ctagtgtata ccagaggtct tctggtgcat ctatttgtgt atgtaataga tttatatggg
   116161 ttggtatttc agttccacag gtgcacttcc aggagttttc gtgattaact tcaccgagag
   116221 aatgtgccca taaatgaatc aacaatagtt ctgattcttg gcggtttaaa tcttttgcat
   116281 ttgtgcagtc tttgattagc tttttaacaa ttacttctac ggaaccatta tttttggcag
   116341 taataagttc tagatattct ttaagcgtga atgcgcgaca attgattatt ttagaaccaa
   116401 ctctcacatc aaatttgtat tcatacatat ttagctcctt tatttatcat atttataaat
   116461 agaataaaag gagcatctat ggcaaacatt attcgttgta aattaccaga tggtgttcat
   116521 cgttttaaac catttacggt agaagattat cgagattttt tgttagttcg aaacgatata
   116581 gaacatcggt caccacaaga acaaaagcaa ataattactg atttaattga tgattatttt
   116641 ggagactatc cgaagacttg gcaaccattt atatttttgc aggtatttgt agggtcaata
   116701 ggtaaaacta aaagtacggt cacatttata tgtccaaaat gtaaaaaaga aaagacagtt
   116761 ccatttgaaa tatatcaaaa agaattaaag gaccttgttt ttgatgtagc taatgttaaa
   116821 attaaattaa agtttccttc tgagttttat gaaaataaag caaagatgat tactgaaaat
   116881 attcattctg ttcaagtaga tgaaatatgg tatgattgga aggaaattag cgagtccagt
   116941 caaatagaac tagttgacgc catcgagata gaaacattag aaaaaattct cgatgcaatg
   117001 aatcctatta atttaactct acacatgtca tgctgtaata agtacattaa aaaatacact
   117061 gatatagtag acgtgtttaa gctattagtt aacccagatg agatatttac tttttatcaa
   117121 attaatcaca cactcgtaaa aagtaattat agcttaaatt caataagtaa aatgattcct
   117181 gccgagcgcg gattcgtatt aaaactgatt gagaaggata aacaataatg agtatgttgc
   117241 aacgccccgg atatccaaat ctcagcgtta aattatttga tagctacgac gcttggagta
   117301 ataatagatt tgttgaatta gctgctacta ttaccacatt aactatgcgg gattctcttt
   117361 atggccgaaa tgaaggaatg ctgcagtttt atgattctaa aaacatccat acaaaaatgg
   117421 atggaaatga aataattcag atttctgtag ctaatgcaaa tgatattaat aatgttaaaa
   117481 cacgaattta tggatgtaag catttttccg tgtcagtaga ttcaaaaggt gataacatca
   117541 ttgctattga attgggaact attcattcta tagaaaatct taaatttggt agaccatttt
   117601 tccctgatgc aggtgaatct ataaaagaaa tgcttggtgt catttatcag gatcgcacat
   117661 tattaactcc agcaataaat gctataaatg cttatgttcc tgatattcca tggactagca
   117721 catttgaaaa ctatttgtca tatgtaagag aagttgctct agctgtagga agcgacaaat
   117781 ttgtatttgt atggcaagac atcatgggcg ttaacatgat ggactatgat atgatgataa
   117841 atcaagaacc atatccaatg attgtcggtg agccatcttt aataggtcaa ttcatccaag
   117901 aattaaaata tccattagca tatgatttcg tttggttgac taaatcgaat cctcacaaac
   117961 gtgacccaat gaaaaacgct actatctatg cgcattcatt tttagattct tcaataccaa
   118021 tgattactac aggaaagggt gaaaactcta ttgtggtgtc aaggtcaggt gcttattctg
   118081 aaatgactta taggaatgga tatgaagaag ctattcgtct tcaaactatg gcacaatatg
   118141 acggctatgc taaatgttct actatcggta attttaactt gactcctggt gttaaaatta
   118201 tttttaatga tagtaaaaac caatttaaaa cagaatttta cgttgatgaa gttatccatg
   118261 aattatccaa taataattca gtaactcatc tatatatgtt cactaatgca acgaaactgg
   118321 aaacaataga cccagttaag gttaaaaatg aatttaaatc tgatactacc actgaagaaa
   118381 gtagttcttc caataagcaa taaagaagtt tctattccta aaatgggtct taaacattat
   118441 aacattttaa aagatgttaa aggtcctgat gaaaatttaa aacttctcat tgattctatt
   118501 tgtccgaatt tatcaccggc agaagttgat ttcgtttcta ttcatttatt ggaatttaat
   118561 ggaaagatta aatctcgtaa agaaatagat ggttatactt atgacattaa tgatgtttat
   118621 gtatgccaaa gattggaatt tcaataccaa ggaaatacat tttattttag acctcctgga
   118681 aaatttgaac aatttttaac ggtgagcgat atgttatcta aatgcttact tagggtcaac
   118741 gatgaagtta aagaaattaa ttttcttgag atgccagcat tcgttttaaa atgggcaaat
   118801 gatattttta caactttagc aattcctggc cctaatggtc caataactgg aattggcaat
   118861 attattggat tatttgaatg aaaaagccac aagaaatgca aacgatgcgt agaaaagtta
   118921 tttcagataa taaaccaaca caggaagcgg ctaaatccgc ttctaatact ttatctgggc
   118981 ttaatgacat atctacgaaa ttggatgatg ctcaagctgc ttctgaatta atagctcaaa
   119041 ctgtcgaaga aaaatcgaat gaaataattg gagcaattga caatgtagaa agcgcagtga
   119101 gtgatacatc tgccggttct gagttaattg ctgaaactgt cgaaattggc aacaatatta
   119161 ataaagaaat cggtgaatcg ctcggaagca aattagataa attaacaagt ttactagagc
   119221 aaaaaatcca gacagctgga attcaacaga ctggaactag tttagctacg gttgaaagcg
   119281 ctattcctgt taaagtcgtt gaggatgata ctgctgaatc tgtgggtcct ttattaccag
   119341 ctcctgaagc agttaataat gatcctgacg ctgatttttt ccctacccct cagccagttg
   119401 agccaaagca agaatcacca gaagaaaaac agaaaaaaga agcatttaac ttaaaattat
   119461 ctcaagcttt agataaatta acgaagactg ttgattttgg atttaaaaaa tccatttcaa
   119521 ttactgataa aatatcaagc atgctattta agtacaccgt cagtgctgct attgaagctg
   119581 ctaaaatgac tgcaatgata ttggctgttg ttgttggaat agaccttttg atgattcact
   119641 ttaaatactg gtcagataaa ttttcaaaag cctgggattt gtttagtaca gactttacca
   119701 aattctctag cgaaaccgga acttggggtc ctttattaca gagcatcttt gattctattg
   119761 ataaaattaa acaactttgg gaagcgggag attggggtgg attgacagta gctattgttg
   119821 aagggcttgg aaaggttctt tttaatttag gtgaacttat tcaattaggt atggctaaat
   119881 tatctgcagc aattcttcga gtcattcctg gtatgaagga tactgctgat gaagtagaag
   119941 gaagagcatt agaaaatttc caaaattcta ctggagcatc tctcaataaa gaagaccaag
   120001 aaaaagtagc aaattatcaa gataaacgaa tgaatggaga ccttggccca atagcagaag
   120061 gactagacaa aatctctaac tggaaaactc gtgcatctaa ctggattcgt ggtgtagata
   120121 ataaagaagc gctgactacc gacgaagagc gtgcggcaga agaagaaaaa ttaaagcaac
   120181 tttcaccgga agaaagaaaa aatgctttaa tgaaggctaa tgaagctcgt gctgcgatga
   120241 ttcgttttga aaaatatgcc gattcagctg atatgagtaa agactcaacg gttaaatcag
   120301 ttgaagctgc ctatgaagac cttaaaaaac ggatggatga cccggattta aataattcac
   120361 cggcagttaa aaaagaactt gctgctagat tttctaaaat tgatgctact tatcaagagc
   120421 tcaagaaaaa tcagcctaat gccaaacctg aaacttctgc taaatcacca gaagcgaaac
   120481 aagtccaggt gattgaaaag aacaaagcac agcaagctcc tgttcaacaa gcatctcctt
   120541 cgatcaataa tactaataat gttattaaga aaaatactgt cgttcataat atgacacctg
   120601 taacgagcac gactgctcct ggtgtatttg atgcgactgg agttaattaa ggaataatat
   120661 ggcaattgtt aaagaaataa ctgctgattt aattaaaaag tccggtgaga aaatttcagc
   120721 cggacagagt actaaatcag aagtaggaac taaaacatac acagcccagt ttccaactgg
   120781 gcgtgctagt ggtaatgaca ctacagagga cttccaggta acagatctat ataagaatgg
   120841 attattattt actgcataca atatgtcatc tagggattct ggaagtctta gatcgatgag
   120901 atctaactac tcttcttcat cttcgagtat tttacgtaca gctagaaaca ctattagtag
   120961 tacagtatca aaactatcaa atggattaat atcaaataat aattcaggaa caataagtaa
   121021 atctcctatc gcaaacattc ttttaccgag atctaaatct gatgttgata catcatcaca
   121081 tagatttaat gatgttcaag aaagccttat cagtagaggc ggaggtactg ctactggtgt
   121141 gctaagtaat attgcttcaa ccgcagtatt tggggcactg gaaagtataa cacaaggtat
   121201 aatggctgat aataatgaac agatttatac gacagccaga agtatgtatg gtggtgctga
   121261 aaatagaact aaagtgttta catgggattt gactccacgt tcaacagaag atttaatggc
   121321 tattattaat atctatcaat attttaacta tttttcttat ggtgaaacgg gtaaatctca
   121381 atatgctgct gaaataaagg ggtatttaga tgattggtat cgttctacgt taattgaacc
   121441 tttatctccg gaagacgcag ctaaaaataa aacactattt gagaaaatga catcgagttt
   121501 aactaacgtt ctagtagttt caaacccgac agtttggatg gtgaaaaact ttggcgcaac
   121561 atctaagttt gatggaaaaa cggaaatatt tggtccatgt caaatacaga gcattagatt
   121621 tgataaaaca cctaatggta actttaacgg attagctatt gctccaaacc tccctagtac
   121681 atttactctc gagattacta tgagagaaat tatcacgtta aaccgtgctt ctttatatgc
   121741 ggggactttt taatgtattc tttagaggaa tttaataatc aagcaataaa cgcagatttc
   121801 caacgtaata atatgtttag ctgcgttttt gcgacaactc catcaactaa aagctcttcg
   121861 ttgataagtt caattagcaa cttttcttat aataacttgg gcctaaattc agattggtta
   121921 ggattaactc aaggtgatat taatcaggga attaccacgc taattacagc tggcacacaa
   121981 aaactgataa gaaaatcagg agtcagtaaa tatcttattg gtgccatgag tcaacgtaca
   122041 gttcaaagtt tattaggctc atttacagtt ggtacatatt taattgactt ctttaacatg
   122101 gcatataact catctggatt gatgatatac tctgtaaaaa tgccagagaa tagattatcc
   122161 tatgaaactg actggaacta taattctcct aatattcgta taaccggaag agaattagac
   122221 cctttggtta tttcatttag aatggattca gaagcttgta actatcgtgc aatgcaagac
   122281 tgggttaact ccgttcaaga cccagtaact ggactgcgtg ctttgccaca agatgtcgag
   122341 gcagatattc aggttaatct tcattctcgc aatggattac ctcatactgc ggtgatgttc
   122401 acgatgcatt caatatcagt gagcgctcct gagttatcat atgatggaga taaccaaata
   122461 actacatttg atgttacttt tgcgtacaga gtgatgcagg ctggagcagt tgataggcaa
   122521 cgtgcgcttg aatggcttga atctgctgct ataaatggta ttcaaagcgt tctcggaaat
   122581 agtggaggtg ttactggact atctaattcg ctttcacgac ttagtagatt agggggaact
   122641 gcaggaagca tttcaaacat taatactatg acaggaattg tcaattcgca gagtaaaata
   122701 ttaggagcaa tataacaatg gggaccgaaa ggtccatatt tttatttacg gaatgaaatg
   122761 aaagcagcaa ctgaagcaac taaactgtct tcaatataaa cttcaatttt tacaggagct
   122821 tctgactcaa atttacctgt tactacaccc tgaaaaatac tttcagtctg ttctggcttt
   122881 gaaaaatttt cagaaggaaa aattccgaac tttttatctg ttccaaaaat tttgataaat
   122941 tcatcgtaaa ccgcttcgtt aaaagcatta tcagcaggaa taacgccttc aactacaagt
   123001 tcttgaccta aaaagcgtaa agaagatttc attttgtgtt cctcatgtta tgttagtaag
   123061 actactataa cacaacacga gggacttgta aactacattt tgaacttttt agtacgcgta
   123121 ataggcatgc gtcgatttta tactgtttca ttgtttgaag agcagtatca aaaacagcat
   123181 taatgacacc aattggattt ccacccaagt ttttaagctt aactaatgat agtttctcat
   123241 taacacctat cattacgata tgcatcattt tatcgcctgg tttaacgttt tatttgtatc
   123301 accgccagag gtgtatgtac aaaatctaaa tccaggaagt acactttctt caccggcttg
   123361 aatagcaaaa atttgtggta ttttatgctt aggatttaat gtaacaaccg gcgccgaagc
   123421 gccgtcaaat aattctgtaa taagttccat gatttatcct tgaacgaact tgtaaggcat
   123481 gtttgcaata tctatgcaag acgcaataat tccaagagat gattctactt tctgtttaac
   123541 atttgatgaa acaaatgatg caaagtcaac tctatcttct atatcacctg tcattgtaac
   123601 caattcacca gtttccatta aatggtctcc gtcatagatt accgattcgg tgagttcttc
   123661 tgtggtcata acttcagctt gaataagctt gttgttagtt ttaactgttc catcattgta
   123721 agatgcatcg gttattttat taactttgac cattaatcca cgtggcaaaa tgacttccat
   123781 ttcatttgaa ggcgctaaac ttccaccggg taaaacaaca ttgaccttat cagccccagt
   123841 aataacccat ccaattccaa ctaaattatc gctagaattt acaagtcctt catcagtttt
   123901 atcaatagaa acgcttaaac gcttttcgtc tggtaaaaca cctatagatg aatcagtcat
   123961 ccaagtacca aaaatatttg gatataatga tgttgacaca aagtttctaa aataaaaaac
   124021 tcgatttttt accattgctt cgtatattga aggtaacatt cgttgtgaac gatacaaagt
   124081 aatacctttt ggtaatcgtt caccattttt aaaggctgaa tctaaattat caatagcttt
   124141 ttctatgtca gatgctgtca aaatacttgt acgctcatct ggattatata atcccaaaag
   124201 agcattattt atgtctacat atcctgaacc tacgtattca cgaattccgc gtttttgcgc
   124261 tggtgtgtat ttagatgaat ctttattttc gactatagga tgtaatgacc atccagcggt
   124321 aagagcatat ccacgtaatt ctcttcgaat aatctttgtt tttattgcat tccaagaatt
   124381 ttgtactaac tcatttgcag catcttggtt taaatgcgaa tgtttgttaa tatttctttc
   124441 aaaccaagca cccttatatt tttctaaagt atcatcgacg atagaagcaa tagtttctaa
   124501 ggtttttatt gaagtaatag attcttttcg taatctttct aaagctttat tttttatttc
   124561 tgcgttaata atggattctt tatcttcagg aattatagaa gcttctctga atgccatccc
   124621 agctgtaaca ctgctaagag cattctctag tgcaaatcct gaagtagaaa ttaccgttaa
   124681 ttcattagaa tcagaaatta aaggcgcgtc cgctggttta tttaattcgg ccgctgaagc
   124741 ctcaaatttt tgaaacattg gtgtttcaaa tctagaagat tccaatgact gactttgcgc
   124801 aattgctcta cgggaaattt taactttaac gattacagct tggtcagaac gtttatcatt
   124861 ttcttgcgca atagatgctg caattgcctc atttttagtt acttgagccc cagtatcttt
   124921 attgatataa acatcaccga ccttcgattc aactttagta aagagctcgg tactaatttc
   124981 cggaactcct ggaatgtctt ctagtgatac atttttgcga tgtataagaa tatatgcata
   125041 ctttttatcg taatcccaga gttccttaag aaggacgtat ctaccacctg aacgactacg
   125101 gataagtcta tcagcaataa cttgaatttg tcgagcttgg ccagcagttt tagacttaag
   125161 aatacggagc atacaggcat caattttata ctggcgcatt gtttgcattg caacagtaaa
   125221 aactgaattg atataattaa ttgggcttgg accaagacct tttaatttag caattgaacc
   125281 tttagcagtt aatgtaaaag gaacaatatg catcatttta tcgcccatct ttaaatcacg
   125341 attagtatca cctccagatg tataggtaca taaacgaaag cctggttgtt caattgcatc
   125401 atcaacatga actgaaaaaa tttgcggtat tttcttcttt ggatataagt ttgtaattgg
   125461 aagagtagta tcttcgtcaa ataattctgt aataagttcc atcatatcct ctctagtgtt
   125521 tattctattc tatttataaa attaaaggcc cgaaggcctt taataatcta ttggtaagag
   125581 agtacgatat atttcaaact ttggaccttt ttcataagca tcaaatgttt ctgtgaattt
   125641 attataagca tatgcatcta taaattcaat catgatttgt gatacagaag tagaaacatc
   125701 tccaccttct ttttgagcca cgacaattgt ttctaagtaa gctttcatag accagttacc
   125761 tcatgaaaat caccaaatac atcttcgaat gtattagctt tagttttatc ttcacgtaaa
   125821 cgaatcgcaa tcggaagaaa taatttaacg taatcagtgc ggccatcaga ttttaaccaa
   125881 ccgttgcatt cgcactctag aatttttcca atataataat tttggttttc cataatgcga
   125941 gtacggtcaa gttcatgcga ttttacaccg gctttatctt ttaagcctga accagcattt
   126001 accttaattt ttccacactc tgactcaaga ataaatccac ccgctttagt agggtcttta
   126061 cggtgaggat aaattcctac aatttttaaa tcaacatcaa ttacttcttt aaatttataa
   126121 agattttttg aacgagcatt ttcccataat ccatcgatat ttttgagaat aataccttca
   126181 agaccttggt caatatactt tttataaatt accttagctt catctaggtt atttactacc
   126241 tggttttcaa ttaaaattac tttatcatat ccagatgtca tttgttctag tttagaaaaa
   126301 cgtacatcat atttcaaacg aaatgcagga agactgtata tttctaccaa cgggacataa
   126361 tcccagacct gaaacttcat gcattgtgct tctttttcag aaatggttcc ctttaaagat
   126421 ttattggcga ttccattaga agcagtacgt gattcagcta cttcggcgaa ttctttagct
   126481 ttactgtttt caggataagc atcaaaaaga aaatctaggc cttctggctc ctttttaact
   126541 tgctcatggt ataccaattc gccatcaatc aacacacctt ctggatgaat ctggcgggct
   126601 tcagcggtca ttttaattaa ctcttcctta agaagatcta atcctagata ttcattacca
   126661 gctcgtgata aaagacgaac atcatctaat tcatcacctc taacttcagc aaaacaccga
   126721 gctccatcag cttttaactg agcaaaggct ggaaatttga tattcttatt aatgcctttt
   126781 tcatcataag aacttgcgag catttgaggt tgttcaggaa ttaaacctgg ccaaactttg
   126841 tttgcaatag atactgaagc accacattca aggtctcgca tcatcactcg acgcaaaact
   126901 tcaacatcat cttttttacc atcggtgata tatccagtta attcctcaat tgctgcattt
   126961 ccagtcaatt tccgagtagc taatgtgaat tcaatgaagt caagcatatc ggtaagagtc
   127021 aacattccaa aactctgggt agcaatacca ggtttaggcc atttcttgat ataatactgt
   127081 aacccacgag aataagtcag acgatatact cgtttaagca attcattatc tttattcttt
   127141 tcaagaattg cttgcttctg tttagttgaa ccaatagatg ctatttcgtt cagaatttta
   127201 agaatcattg ttcatccttt agagtttggt ttacagctct attataaatc aattcatcat
   127261 taagctcagt caaagacctg tggtacgtgg ttctaacttt atttccttgc atccagtgct
   127321 tgatataaat gaaaccttgc tctacacatt ttttaaaaat tcgttcgtct ttttgagctc
   127381 ggaattctgg attgcatcta aaaaattgat ttacgtgacc gtaatcacgt gtagtattac
   127441 cttcattttc ataaatagtg tgaacaacaa acattagaat gctccttgga aaatattatc
   127501 accacaagta ggtctattat acaaatactc tataccgccg ggcttaatat agttccatgt
   127561 ctgaaacgga tgcgtctgat atggatgata tggattataa ggattaaatc caggagttct
   127621 ccaggtagtg ttccaaggaa aagaatcgtt tttaatcatc ttttcaatta catcttttat
   127681 agctttttca ctatcaaaac tttctttatt ttcctttggt gaaaaaagct tattctctac
   127741 atcgttccat gtataaactc gctgagcagt ttttggaata ttgtcacgct ctcctcgagc
   127801 catccaatac acaggaacac gtaatatttc actcgcgtga tcgcagtggt gagcgagatc
   127861 gtcaatataa caaattacgt tatatttctc ttttgctttt ttgaacaact cttcttttga
   127921 agaatcatga ctacacatca gtacttctga gaaagcacca ggaaaaagag cattcaaatt
   127981 aaattgacga tttaatagag cgtcaataga atcacccaat gctgtaacag caacaaaatt
   128041 ataatcttct tttaatttgt taattacaca cagagcatct ttatatggag acaagtaacg
   128101 aataaaatcc gaacgattgt atttttcaat taacttgacg ccaagttctt catcacagtt
   128161 aaagagttta ccaggagaaa taaatttctc atcttggatc atttttaaaa tatgttctaa
   128221 cggaagatta tatttctgag caaaataagg aaggcctgat tgccagctta aacatactcc
   128281 atcaatatca gttaaaatag taggcttcat agagagtctc ttaataggtt taacacatca
   128341 ataaattcag cttcggttag tattgtatca tcttttgtta gaccactagc aatgctgtgc
   128401 ttcaaaactt ttcctttcga ggcttgtaat gcatcacgaa agcccttgtt ttgaatcgct
   128461 gcttcaaaat atgcatttgt gtataattct ttccacgccg gggagtatct tgaaaacgga
   128521 actccaagcc aaaagagggt cccacggtcc tgagctctag cataagacct tccagcttgt
   128581 tgggcggcaa gcccggataa cccaaatata cgacgttgtt gttcaacatt tttcacctta
   128641 cacccttgga ggaatccttc aagacctcca aattgaatac catccataac gaaaggccat
   128701 tgggcgaaat tacttaatgc acatgatggc cacctaaaat tgcttctaat ctctaactca
   128761 gacattttca atgcttataa tttcaacatc agcccaatga ccatagcaag gaagacgaaa
   128821 ttcaactggc cagttagggt ccctttctaa tataatagac tcaacttgtg gttcttcgtg
   128881 ttcatcagta tacggatttt tatctgttac tttatatgtg accttaatgt actgaattcc
   128941 aaaaatctta ttaattatat tcatactaat tcctttaatc cgtagatagg agataattca
   129001 tcacccatac gaaggtcttc atttccatct acccaggaaa caatataagc ctcttttatt
   129061 tgaataccac tccatttaaa tggaggtaga accttagaaa ttaatccagg tataccaact
   129121 ccctttaatt caacagtttg acctaaaaag aatttcatta gaacctcatc tgaaaaccgt
   129181 gcgatttaac attaccgccg ccaatatcag aaatgttaat ttcacgcgca attgaagggt
   129241 caatgtcaat ttcacgattg agtttagtga tagctaaagt atcacgccca tttacagtac
   129301 ggaactctaa aggacaaacc acatcaacgt agtttttaat cgattcgcta gtaagttgca
   129361 aatgtgcagg aaggtcttta ggtgcctttg agaaaaccac ttcacagaaa tttttgcggg
   129421 tatcaaaata agtagtcata aacataatat tttcctcagt aaggggctga agcccctcat
   129481 tttattttaa atatcaaatt cattaagaac tacatcaaag attgcttcaa gatgctcagg
   129541 tttagctctg ttactcagaa tatgacgaat ccaagtttta actaagagtt tacgattagc
   129601 accattccag caaggatgag tccctaaatc gcgttggcgg aaatcatcat ccagagcgat
   129661 tttgaagttg gaacctttca tcgtgattga aaccgtgata ccgttttcaa atcgcatata
   129721 aacgtagtta ggagtcatat actgttcaat ttcgcatact gatccatttt gatgtttcca
   129781 gaggcaaata gtatcaatag aacctgcaat accattagaa acatatttac gttcaaagtt
   129841 aatgtagttc atttttattc tccgagatgt ttaattgcgg tacaggtata taatatcata
   129901 tcctgtacca aagtaaacaa ttattttact actttccaat gctgcatgtc aagtttacca
   129961 acttttttca tcttctcaat taagcgttct gcacgttggc gagctgtaac ataatgccat
   130021 tcgcctaatt cattttgttc aatttttcca acgattactg tattcaattc ataaatccaa
   130081 ccagtaaaga aattatgaac ttgaattgta aaggtgaaat ctgttcccat accttctgtt
   130141 gtttctactt caataatatc accttcaact gccattaaga accacatagt ttcatcatat
   130201 ttaccattga agcatttagt tttaactgca gcgttcagat taatcgtttt cattttattc
   130261 tcctttgttt gtgtaagata atactatcac aaaggaacta tactgtaaac aactttgtgc
   130321 aatctttgga aaataaaaaa ggactcccga aggagtcctc aacttatgct ttctgcttac
   130381 caaaacgaga agcatcatct cgaagaaccg cacgtgctcg gcgcatgatc ttctcaacag
   130441 tttgattgat acgagagttc gacccacgct tgtagccagc gcgtttagaa tcaccaactt
   130501 tcttttcaac tgctttcttt gctttagctt gttttgccat tataaattct cttttaaatg
   130561 aaaatgcagg acttattggc attgcctgcg caagccctca aggggaacat aggtttttgg
   130621 atatttaacg accaggataa ccataaaccc gtcatcattc acattcaaga ggtacaccgt
   130681 aaaactgtcg gggtcttaaa actataatga ttcgcaaatc attaatcaga cagttcgacg
   130741 gctcctcgat ttagctcaca ctaaggcagt gaatctccaa taaattactt cagtgttacc
   130801 acaaagtgac gaactgcttt tcgtgcagca gaagccagag gcttagcata tttaagttca
   130861 tctttttcct gaagctcagc agctaatgca gtttgagcag gattcagatg tttgaaataa
   130921 cgcaggattt caagagcttc ggcttcaaca tcaatagatg cgccatagtt ttcgtgacca
   130981 ttattccatg cgtttcgttg cagttcaaga gcgtgttgta attgtttaat catttaaaaa
   131041 ttctcgttag agattaaaac tcggtagtca cgttcttctg aatttcatct tctttcgaca
   131101 gatctctcag ttgtagacta ccacatagaa ttgttcggtt aacttattat tccgacaccc
   131161 aattcatatt attatttata tcacttataa agacacggaa tagctttata gtgacaggta
   131221 acgaattttt gtttaatttc ttttggctgc ttaagaccca gagctacaaa aggatgcgga
   131281 acatttcgaa tttgaccaac tggaagagaa gtcaaatcac caacttcgca gaaaccttca
   131341 ggaacatcag gaccgacaga gtgaactaca cacagttcag gaacttcacc ttgaacacgt
   131401 ttaccgataa taagtcctga ttctgtaact tcttcatcac cggcttgtgc aggttcagaa
   131461 actaaaataa catattcacc gacagcacga attggtagct gttgtacttc agacatcgtt
   131521 tttccttttt gttaacagat gaattaataa taacaaatag ttcttaaagc atttatttac
   131581 caataaattg aagcaaatgc tcaactttca taccattaac ggaaatcaat ttgtcaatag
   131641 aaaaacctcg ccacgcacca agctcaacat caaatactgg aatcatgtca gtagattctt
   131701 tccgagtaga ttcagtcaat ttgccagttt gcatggttgg cataaagtct gcatcacgag
   131761 tacctttcat agtacgaata gtaccatcag acttttcaaa aactacgttt gaaacaccca
   131821 tggacaattt agttttcaaa atttcacgaa ttgctacttt ctgctcagtt gtcagtttca
   131881 tttatttacc tattacagtt ttaatatgag ttgttccacg ttctttaagg gtggaaagta
   131941 atttttggca tttttctaaa tcagatttcc aactatatgg tctatcaata caaacccaat
   132001 ttgtcttata atactgtttc catttagaga aaaaatattt cttatactct acagcaaatg
   132061 agatgttctc gttagaataa gaactaattg ctgtgagttt taccaaacga aatttcatta
   132121 ttcaccacag aattcgttga tattttccca gtttaactta ttcaagtttt tcttaggaac
   132181 attaaacact tcaatacctg catttcgcag aatatcatcc caaccgggtt tatttttgtc
   132241 gtatgtttca caataaacca gctttttaat accagattga gctatcgctt ttgcgcaatc
   132301 tggacaagga gaaagtgtta catacatagt agcaccttca atagaagaac catttcgtgc
   132361 agcaaacaaa attgcattta gttcagcatg aatttcattt ttagatgacc attccgagtg
   132421 agcactacga tgttctttcg ccaaaacaaa acgatcagtt gaaccaaatg atacgcattc
   132481 aggcttatga ccttgaatga tagcatgttt aggcttattc aacaaccatc cttgctcagc
   132541 agcataatca caacagttca caccccctgc gggtgaacca ttatacccag tagaaataat
   132601 acgtccattc ttttcaatta ctgctcctac cttccaggag caacattttg attcctgcga
   132661 tactaaatat gcaatttgaa gtactgtact cgctttcatt tcataatcac cagataagca
   132721 gatttagcag tttcaacacg ataaatttcg tgacgaagtt tagttatact tttaataaca
   132781 gaactaatta tattctgccc atctttaaag cggtttttct tatcaataaa aactgcgcca
   132841 gtcatctttt tgtgaagctc aactggatac ttcgtcacaa taatagcatc atacacagaa
   132901 ggatgaatac tattcaccag agtatcattc attaaagtta ttctaatgaa ctgtgctgtt
   132961 tcagaatcaa gcgctctatg atcgccagta tcattttcaa gacaattatc aattatatca
   133021 gttaaattca tcatagtacg ccatacaccc tttgtgcttc aactaatcca tcaaaatcca
   133081 gtttaagatg cgatatttga tcgccatcac ctggattcac aattactaat actgaacgag
   133141 gagtttcggt aataacacga accgatgttt caggaaatcg ttcagaaacc ttatttacta
   133201 attcctgcgc aaatagttta actttttctt ggaattcctt taacagtaat cggtttttca
   133261 cttagcaaca ttttgttttc ctcatttgtt ttggtagagc tataatatca caactctacc
   133321 gtaaagtaaa ccattaaatc gctttgaatt ccgcagtttg agattcaaag cgaatatcgc
   133381 ctttgataac aagctcagca tcaagaccaa atacgacaat gatatgcgcg gaacctggat
   133441 acagtgtaat ggcaatagaa tccacctggt ctggaagcaa agtgttcaat acatgagtca
   133501 cttgagcatg gattcgaagc tcagctgcgt tatcaagttt ttcaaacata ttattagcga
   133561 taatttggct aaacactact tctacgattt tagagtaagt cggaaacata tttacctcac
   133621 ataattttct tcaagccaat caataacatc caacgcatta tcaaaagttg aaccatctac
   133681 tctgtcttct gtttcataat caagaacatc taggcctact cttccgtcaa caataggcca
   133741 tagacaaaat agatatttct tttctttttc aattttatca caaagacgat aaatcttttc
   133801 taggttattc ataagttttc catggtaaag gcagtttagt tttctttact actagttcaa
   133861 catcgggatt cttttctctt aatttaagac attcctccca tgctctattt tcactagtaa
   133921 atacacaaaa ttgcccatta ctagtaccaa ctaaaccgct atttacaata acaatagccc
   133981 aagtttcatg gtgccaagcc attaaaaatc tcccgaagcg acttgccagc attcaacacc
   134041 gatacgacgc cacatttcaa ctacttgagt tcggtcatca atagctaatt tcacgtcaaa
   134101 atgcggtgca atgtgtttcc agaaaatttc ttctttaact acatcgtctt tacgggtatc
   134161 gccttgttcg cgctgacatt gcataactaa tggaacgcca gcaatgtcct caacccattt
   134221 acgggtcata cgataatatt tcgttgggtc ttctttagtt ccactttcac gacctgaaac
   134281 gactacgatt tgataaccca taagagcata catcttagac agttcaacaa ccataggatt
   134341 gataacatcg gtatcgcatt tttcaaggtc ataaggacca cgaccattca ttttagctag
   134401 tgtaccatca acatcaaaaa taactgcttt tggtttacca ggagtcccat tatatactgg
   134461 aagaccgaga tactctcgca tgcttttata cattgaacgt aaaacatcaa ttggtactgc
   134521 tttagttccg cgttttgagt tacgtttaac caattcagtc caaggaacat caaacacttt
   134581 atgttcaact ttccagccgt attctttggc aaaagtttcc catgctaggc gacgttcagg
   134641 attcaggtta gtatctgaaa tgattactcc cttaacagaa tcgccaccgt acagaatact
   134701 tttagctgta tcaaactgca taccagttac gataccttct ttctttttgg tatacttgta
   134761 ctcatcgcgt tcttcatgcg ccataataga ttggcgatag tcatcacgat tgatattata
   134821 aaacccggga ttcttagcaa taaattcacg agcccaagta ctcttaccag aaccaggaca
   134881 gccaatagtc aaaataatct ttttcattta ttttttctca actaatgatt gaatataatc
   134941 atgtaggtct ttagatgctt taccccactt attttgatat tcatttttga gattagcacg
   135001 tgattgagct aataaaacat cattagttgg aggtaaagat tctaaccgct gaatctggcg
   135061 tccataaatc attgcagcca tctcggattc ataaatcaat cctttgagat gttcaaattg
   135121 atgccatgaa atcatttaca tttatcctct tttagctctt gacgataata acatrtcata
   135181 gttttctggt catgtacata tcgttttaca tcattaagcc aaatacgaaa ttcctgagaa
   135241 tcttcaaatg gcataccgac ccaggcttta ccatcaataa ctttaacttg ccaagatagt
   135301 ttagcttcat catatgactt tatttgcaca ggccaattag gatgaactgt ttctttcttt
   135361 acttctagag gctttgtcga acaaccaact agaagaccaa tagataatat tactgctgat
   135421 agtttaatca tttagaaagg tcctggatgt cttctgcgaa cttgttgaag gagttgttga
   135481 tttgtttttc aaccaatcct ggcttatgag ccaccacatc cgccttcttt gcatctttgc
   135541 gcagtttttc attttcacgc tcaatagcag caattgcctc acgattttta ttattcatcg
   135601 catcaatata attatactga attcgcaaat tatttaatgc taaggcgttt tcattggccg
   135661 tttttgtaat ttcagtaact gatgtttcta atctttctac cttatgtttt aaaataatag
   135721 atgttccgcc aaatgctatt acaagtaata gcaatccagc tgtaaaatta cttacatgca
   135781 taaagtttta ataacctcta caatatcgtc ttgagaaaga ccgttaatta aaatatgatg
   135841 ttcagctgga gatttagaaa ttttaaagca tgcctcaaca tcttctgcca tatccgatgc
   135901 actacgattt ggattactaa taccaaggcg atgttttccc gtcaaaggat taacgatgat
   135961 atagcatttg cagctattga tatgaacatt gggttgagtc tgattaatga acacttcaca
   136021 atcatactta gcaagttgat tttctaaaaa gactttcatc tcttcaaccg catcaggaag
   136081 catatcacgg gcttgctcaa gacgacgatt tcgatattct ttaatggtcg ttttccgctt
   136141 gacttgctta gctaaatctt tcttaagacc agtgatatat ccaactcgac gatttccttt
   136201 gaatacagaa atcccatctg tagtatcacc gtatgcttca acgaccattt cagtagtaat
   136261 aagttgtaaa tccatcataa agtcctcatg ttatgtcagt aagactacta taacacaaca
   136321 cgagggactt gtaaacaact tagtatcctt ctgggataaa ttttttataa tttttcaaaa
   136381 aattctgttc gatttcacac atgacctttt cttgactatc gtacccctgg tataagctca
   136441 tgatgatacc gaacaggtga tccattccag cacctttagc aacaccttgt gcttccattg
   136501 cataagtctt tctatcctta ccgcaatgct tattatgaca gtcaagaact aaaaacagag
   136561 ctcggtctaa gtacttcaga taagtcgttt caaatgcttc aatttttctg tatgaatatt
   136621 catcgtcagc atacattgct ttaagatcat ctgatgcacc atcaataata gtcttaaaca
   136681 atttttctgg attatctaat gaactttttg tactatgaag agacacgtac cagtcagact
   136741 taattttaaa atgagaacca tctttcatca cagcaacata gccttcgatg ttttctgcat
   136801 ttttagcttc ttctatccat ttagggctat cgatttcgta tcgttcaact agatacggac
   136861 gaagagtagc atctttataa atatcatcgt atgaaatgta ttcacccgtt tcgttttcac
   136921 gaacattcag taaaataatt ttcatctctt gataagcaag aacgattcta ttcgtcgggg
   136981 caacgaattc gaagttagca gtaaatccat cttcagctaa ttctttaagt ctatcacgca
   137041 accgatggtg attaatattc atcaaaattc cattagccat taaagcctgc tcagatttga
   137101 ttgaaccctt tgatttgaac agaatttcat caccgtctaa ataagttgat accaaagacc
   137161 cgtcttcttt tgttagaata taatcaacat cgtttaaatc gatattcatc gtgaacggat
   137221 tttcattcaa gttaaaaaac ttttccatag gacgagaagc aattcttact ggtttttctc
   137281 catccatttc aaacataatt ccacgacatt ctagtgcatc tggaagtaac caatcagaat
   137341 aagatgcata attatatgag aaaattctgt aagttcttcc agatgcactt acatcatctg
   137401 agtaaaaaaa cttacgctgc gaatccttac atagttccat taaattgtta aaaagttctt
   137461 gcattgtgta tcctcttttg tgttttgaat atagtaccac actccatgtg gaagcatcat
   137521 tttttcttgt gttgaatatt ccaaggcggg ttaaacagtt taatgaatag aggctcctct
   137581 aagtcaatcg ttgcgattgt cattgtacct aactcatttg tcatagaaag attaaaacat
   137641 tggcgggcgt aaaattcaac tttgcttcct tcctttagcg cagaatgaat taatgcagat
   137701 ttagtagaat cagacgtttt gtctttgcgg ttaatagcag ttctataata gtttattctt
   137761 ttacgtaaat ttttagtttt tccaatataa acaagctcat catttatagc aatagcataa
   137821 attacgttat acttgtttgg aatagataat tgttttatac ttccattgtc gtctaattct
   137881 agctcagtat atttaataaa tgaatattct gttgcaattt ctttcataat aaaatgggcc
   137941 ttgcggccca ctccttaaaa gtatttttta aaactcatca taactttatc atcaacatca
   138001 ttatcaatct gtgcaacaag gtaagatgac agttctactt cttgcggcgc ggattgaaca
   138061 ttatcagaat taagatattc acgaatccaa ggatatggat gtttaaccgg agcatcggta
   138121 attgggcatg gaagaccgca ctgtttcata cgagatacag ttaagtaatc aataaagctc
   138181 cacatgctat ttgtatttaa tccaggaaca tcaccatctt taaataaatg aactgcccag
   138241 tctttttcct ggcggttaac ttccatgaaa atatcaactg cttcttgttc acactcttgg
   138301 gcaattttaa cccattcatc accatcagta ccggattgaa gttgacgaat aatatattgg
   138361 gtgcctttaa ggtgaagctg ttcatcacgt gcaatgaact tcataatctt ggcattacct
   138421 tccatgattt ccatgttctt atggaagtta aaggtaccgt atgttcgatt gagctcgcta
   138481 attctcaacc cgttctctta tgaactgctg catgttacca tgcagtccag actatatcac
   138541 aatcccggag ggattctccc catttcgagt cgcttgaccc tacgtccgaa gactagtcgt
   138601 tgaaccttgt tttgcaattg tcgccgtgcc atcgtttata tgttgatggt gataaatctt
   138661 tcttatcaca atatggacaa ttcaattgaa ttctatttgg atttaattta catctgtcat
   138721 tatgttttag ataaaatcca ggacctttac caatgtgacc acagaaatca catgtgattt
   138781 ctttttgtgc aggatgggtc ccgttcttaa ccatttctaa tgtttttgct gatgttcttt
   138841 tcttatgttc ttccatcaga atctttaggt ataggtccgt tagcatctat ccaaattttt
   138901 ctatagttca attgtgcatc ctcttaaaag tataatcata tttatattat actaattaaa
   138961 ggtgcaagca aaaccttggc tgctagtttt ccataaagga ctttccagca attaaaggag
   139021 ttttcgataa acgttaccgt ttaaaggcgc attttacgca aaagatacat aaaaacgaat
   139081 agcttctaag gcattaataa cgtgcaaaca gaggtaaaga gatttcatca gatctcgttt
   139141 agctctttgc tcaacgtctt tatcagctag aattagacct tggtctttat aatattcaac
   139201 catgtcttta gcattttccc attcacgggt tttaaccaag acatcatcgt aatatcgccc
   139261 aatggactca gcacgtttca taatagcttc atctaataca atctcatcaa acaccttcga
   139321 tggatcagta taaagatttc gcatgatatg agtatatgaa cgactgtgaa tagtttcact
   139381 aaaagtccat gtagcaaccc atgtatcaag gcttgggtct gaaattaatg acataagtac
   139441 agcagatggc gcacgaccct gaatgctatc caaaagtgat tgatacttca ggttgttagt
   139501 aaaaatattt tgctgatact gaggaagctt attaaattgc gcagcatcca tcattaagtt
   139561 tacttcttca ggacgccaaa aaaaactgat ctgccgctca atgagttctt caaatactcg
   139621 atgtcgttga atatcatatc gagctaaacc taatccagaa ccaaagaaca tcggttcatt
   139681 caaaacatca actggatttg tattaaaaac tgtactcatt tagaatcctt aaatttacat
   139741 ttatcataat gccatcttaa agcattgcct ttattaactt tcttaccaca gtgcgggcaa
   139801 ggtggatact ctgctccttg tttagttctc aaagaaatca aatcacgggt ttctttagta
   139861 tgaggaacat ctcttgtcgg agaaattgta ccatacatcg gattaagcac gccgacttta
   139921 gcagcagcta tattcttttt agcttcttca gttttaggct ttctcatctt tttcttaggt
   139981 ttcttcgctt ttagcccttc ctttggttgc cgccgatatt ttgtgtttgg tttcttctgt
   140041 taaacgcaga cctgttttcg ctttttgaca ttttcagtct cgtttcttca gaaatgaccg
   140101 tacctttgcg aaattgcgaa tttaacttct ttgcatgggc atatatttta gaatgaactt
   140161 tataatgacg tttcttagtt cctttcatat tgcacatcat gaaaaatgcg aatataacag
   140221 attttaccgg ataaatcttt gataaaatag catgcgctat aaaatgctct ctagctgtta
   140281 attcaactaa attttcttta tcatcagaac ctcccatgca tctagggatt atatgatgtg
   140341 tctctttata ttcggataaa ggttcccgag cctgagctcg ggaaattagg tcgttataga
   140401 ttttttgata attcattaca atttacacgc tgcacaatca tcggctttag gagtttctat
   140461 ttcataatca tcagtaccag aaccatcacg ggtattatga taatagaaat ttttaatgcc
   140521 ataataccat ccgtatagca tgtcatcaat cattattgac attggaacct ttccttttgg
   140581 aaaaatctgc gggtcataat atgtattcgc tgaagctgat tgacataccc atttcagcat
   140641 aatagctacc tgcgtaagat aaggtttatt acctttctta gctaatttcc atgtataatc
   140701 atagaggtct atgttatgct caatattggg cacgacttga ttaaaggaac cctcttttga
   140761 ttctttaaca cttaccggtc cacgtggagg ctcgtagccg tttgtactgt tagaaacttg
   140821 ggaagatgac tcacatggca taagtgctga taatgtgcta ttacggatgc caaatagctt
   140881 aaggtcttcc cgcagcgccg accagtcaca aacgtatttt ggagctgcga tttggtcaat
   140941 ctttttattg taccagtcga taggtaattc gcctcgagac caacgagtgt ctgaataata
   141001 ttccgaaggt cctttttctt tggcgagctt aatggatgct ttaatgagtc catactgtaa
   141061 tctctcaaat agttcatgtg ttaaatcgtt agcatcttca taagaagcaa agttacttgc
   141121 cagccaagct gcatagttgg taacacctac accgaggtta cgacgctttt tagctttttc
   141181 tgcttcagga accggatatc cttggtaatc caacagatta tcaagagcac gaacttgaac
   141241 ttctgccaat tcattaattt tatcttggtc ttgccagtca aaattatcta atacgaatgc
   141301 agagagagta cacaatccaa tttcagcatc agggctattc acatcatttg ttggaatagc
   141361 aatttcacag cacaagttac tctgacgaat aggtgccttt tcacgaataa acggagtata
   141421 gttattcgta ttatcaatga actgcacata aatccttgct gttcctgaac gttcagtcat
   141481 gagcaattca aatagttcac gggctttaat acgcttttta cgaatattag ggtctttttc
   141541 tgctgcttcg tataattcac ggaaacggtc ttggtcttta aaataagaat aataaagctc
   141601 gccacccatt tcatgcggac tgaacaaagt aatgtaatcg ttttttccaa aacgttccat
   141661 catcaaatca ttcagttgaa caccataatc catatgacga atgcggtttt cttctacgcc
   141721 tttgttattt ttcaaaacga gaagattttc aacttccaaa tgccaaatag gataataagc
   141781 agtagcagcg ccgccacgaa ttccaccctg tgaacatgat ttaactgcag tctgaaaatg
   141841 tttccaaaaa ggaataacac cagtatggcg tacttcaccc atgccaatct tagaaccttc
   141901 ggcacgaatc ataccaacgt taataccaat tccagcgcgt ttagagatat attcaacaat
   141961 tgaagcagaa gccttattga tagacttcaa tgaatctcct gcctcaataa caacacatga
   142021 actaaactgt cgagtcggag tacgacaacc agccataata ggagttggca atgaaatctg
   142081 tcgagttgat actgcttcat aaaaacggat aacatgtttt aatctatcaa caggttcatc
   142141 ttgatgcagt gccattccaa tagtcataaa tgcaaactgt ggagtttcat aaatttgacc
   142201 agtggtttta tctttaacta gatatttttc ttttaattgc attgccccgg aataagtaaa
   142261 ttccatatcc cgttcgtgct taatttttga ttctaaaaat gtaatttctt ctgctgaata
   142321 ttttgacaat aattcagggt cgtatttacc tgcatttaca caataagaaa tatggtcaat
   142381 aaatgaacgt ggttcatact gcccataaac atgcttacga agagcaaaca ttaaacagcg
   142441 tgcagctaca tattgataat caggttcttc aaccgaaata gaattcgcag cagccttaat
   142501 gacaatagtc tgaatatcat cagttgtcat tccatcacgg agataagatt taatattttc
   142561 atataattca taaggatcta ctgatgttcc ttcagctgcc caagataaaa ctttaataat
   142621 tttttgtggg tcaaagctct gagaaacacc actacttttg ataacattaa ttaattgcat
   142681 aagtcctcaa cttgaaaatc gtctttaaac aatcggttaa ctatatgagc tattatatca
   142741 ccatgacacg gctttggttt acatgtgcat cctagcctca ttccacgtaa aggctctaaa
   142801 tgtgctttag ttatttctcc ggatttaatt cgacgtataa aatctttttt gaataattca
   142861 atggcagcct cccggctgcc agcatcttta ccgacgtaat ttccccaaaa tgtaccgcgg
   142921 tgaatattaa catcaaagtc ggatttatat ttattcacta cccggcatag acggcccacg
   142981 ctggaataat tcgtcatatt gtttttccgt taaaacagta atatcgtagt aacagtcaga
   143041 agaagtttta actgtggaaa ttttattatc aaaatactca cgagtcattt tatgagtata
   143101 gtatttttta ccataaatgg taataggctg ttctggtcct ggaacttcta actcgcttgg
   143161 gttaggaagt gtaaaaagaa ctacaccaga agtatcttta aatcgtaaaa tcatatatcc
   143221 tcgcaataat aaaattacac cgccatcttt cctttaatag gagggtgtga tacatagttg
   143281 ttaagaacga aatctttagg cctaagttta agaacatatt ttaattgttc tttagtagaa
   143341 agatatcgga atttataagg tagaccactt attaccagct cacaaagctc tttaggttca
   143401 cgcctcaaaa tttctttaca ttgttctacg tgattcatat agatatgagt attaccacca
   143461 gaaaatatca aatcccctgg aataagatta cacatcttag ctacaatatg aactaacgta
   143521 gcatatgacg caatattaaa cggtagcatt atgttcagat aaggtcgtta atcttacccc
   143581 ggaattatat ccagctgcat gtcaccatgc agagcagact atatctccaa cttgttaaag
   143641 caagttgtct atcgtttcga gtcacttgac cctactcccc aaagggatag tcgttaggca
   143701 tttatgtaga accaattcca tttatcagat tttacacgat aagtaactaa tccagacgaa
   143761 attttaaaat gtctagctgc atctgctgca caatcaaaaa taaccccatc acatgaaatc
   143821 tttttaatat tactaggctt tttacctttc atcttttctg atattttaga tttagttatg
   143881 tctgaatgct tatgattaaa gaatgaatta ttttcacctg aacgatttct gcatttacta
   143941 caagtataag cagaagtttg tatgcgaaca ccgcacttac aaaacttatg ggtttctgga
   144001 ttccaacgcc cgtttttact tccgggttta ctgtaaagag ctttccgacc atcaggtcca
   144061 agtttaagca tcttagcttt aacagtttca gaacgtttct taataatttc ttcttttaat
   144121 ggatgcgtag aacatgtatc accaaacgtt gcatcagcaa tattgtatcc attaatttta
   144181 gaattaagct ctttaatcca aaaattttct cgttcaataa tcaaatcttt ctcatatgga
   144241 atttcttcca aaatagaaca ttcaaacaca ttaccatgtt tgttaaaaga cctctgaagt
   144301 tttatagaag aatggcatcc tttttctaaa tctttaaaat gcctcttcca tctcttttca
   144361 aaatctttag cacttcctac atatacttta ttgtttaaag tatttttaat ctgataaatt
   144421 ccgcttttca taaatacctc tttaaatata gaagtattta ttaaagggca agtcctacaa
   144481 tttagcacgg gattgtctac tagagaggtt ccccgtttag atagattaca agtataagtc
   144541 accttatact caggcctcaa ttaacccaag aaaacatcta ctgagcgttg ataccactgc
   144601 aaatccaaat agccattacg cacattaaac tgatagaaca tatgacaagg cggtaatgcc
   144661 atatatttaa gttcagctgg attccatgca gaaacaattt gacgcctatc atttggcagt
   144721 tttttaatac gatcaataac ttctataatt tggtctacac caccaaaatc acgccactgt
   144781 tttccataaa ttggaccaag ttcaccgcta tggtatccta aatcttttgc ttgattttcg
   144841 taattttcat cccagactgt tttgccttgg attaacgaat cgtgttgaat taatcgtaaa
   144901 tcattgacat ttgtgcttcc tgataaaaac catattagct cagcaatgca agctttccag
   144961 gcgagcttct tagttgttac cgcaggaaaa cctttagtta aatcccagcg taatttagat
   145021 ccgaacagag caattgttcc tgtgcctgta cgatcatcgg tttcataacc attttcaaaa
   145081 atgtctttaa ttaaatcttg gtattgtttc atttatatac tgattccgta agggttgtta
   145141 cttcatctat tttataccaa tgcgtttcaa ccatttcacg cttgcttata tcatcaagaa
   145201 aacttgcgtc taattgaact gttgaattaa cacgatgcct tttaacgatg cgagaaacaa
   145261 ctacttcatc tgcataaggt aatgcagcat ataacagagc aggcccgcca attacactta
   145321 ctttagaatt ctgatcaagc atagtttcga atggtgcatt agggcttgac acttgaattt
   145381 cgccgccaga aatgtaagtt atatattgct cccaagtaat atagaaatgt gctaaatcgc
   145441 cgtctttagt tacaggataa tcacgcgcaa ggtcacacac cacaatatgg ctacgaccag
   145501 gaagtaatgt aggcaatgac tggaacgttt tagcacccat aatcataatt gtgccttcag
   145561 tacgagcttt aaaattctgg aggtcctttt taactcgtcc ccatggtaaa ccatcaccta
   145621 aaccgaatgc taattcatta aagccgtcga ccgttttagt tggagaataa cggaatacca
   145681 atttaatcat tacgtaaatc ctattttaat tgaaaacgaa tgcttacttg gataatttca
   145741 atgacataca taatattttc ctcaaacaga ctttttcaca attttccaat cagctttaaa
   145801 ctgctcgacg tcagaatggt aaatccaaaa tcctgcgctt tctccgtctt cataaagagg
   145861 acatccatcg cattcatctt cccatcccat atcacgtaaa agatgttcag ctttttcaac
   145921 aagttcagaa tctttaccga tgatattaaa ataccattta cctctaactt ctgaatcttt
   145981 gatgctctgg cgttgtaatc tcattttatt ctccttagca agctttaatc aaaagatata
   146041 aacagaccaa cataactgct gccataatat aaggtgcgaa cattttcttt tctccattag
   146101 ttttgatagg gtaatagtat cacactacta ccctgatgta aactactttt tgaaagtttt
   146161 tcgcaaaagt tcaatgattt catctacatt gttttcgtca acaatgcagt gaatttttgt
   146221 tacgccagaa accttgtctt tgacttcatc ttcttcagaa gtcggttctt tatattcgcg
   146281 gaaacaataa aactcttctt cactaagttc aaaataatca tcacccatac catcatcatt
   146341 atagatttca ccattagcac aaatgatttc ggttacataa tcaaagccat ctaaacttga
   146401 tattgattta acttcaaacc aaccgccatt ttcttgaatg atgccgacca tactagcatt
   146461 tgatgaacta atatcaatga aagatttaat acgatgtgga tttaactcgt attttttgcc
   146521 gatttccatt ttgattttcc tcattttaat aggggcttga tagccccttg ataattattg
   146581 ttcaatcagt cccatgtaaa attctgcgtc ttcagaatcc atgccatcac aatattcatt
   146641 agccataaag cgggtgaggt cttcaagagg accttcaata acgatttgaa tactccaaaa
   146701 cttagaatct tgcacgcttg tgatactaag ttcaggataa cgattacgaa taatctcttc
   146761 aatatattca aaatcaacga tgtcaatatc aactttagcc atattatttt cctctttaat
   146821 tattagcagt attgccgata gttgtatagt accataaagc tttatgcttg taaaccgttt
   146881 tgtgaaaaaa tttttaaaat aaaaaagggg acctctaggg tccccaatta attagtaata
   146941 taatctatta aaggtcattc aaaaggtcat ccaggtccgt gtcatcagca ctagatgaac
   147001 taccagagct tgagctcata aaatcatctt cagtttttgt attgaagtca tcaacattga
   147061 atgcatccaa atcatcagcc actttatcag ctttcttagc agcagttgca gcagcaccgc
   147121 ccatcacagc agttcccata acttgaccga atttagtatt aagttcttca aacgatttga
   147181 atttatcttt agaagtcatt tcagaaaggt caaccatttg ttcgaacagt tctttctgga
   147241 aagattcatc gtcaatgttt ggaatcgcag attgattcag gaatttagat tcatcgtagt
   147301 tactaaatcc agaaacttgt ttaactttca gtacaaagtt agcaccttcc cacggacaag
   147361 ttacatcaac tggagtttca cccatttcaa catcaaccgc aatcattgca ttgattttat
   147421 cccagatttt cttaccaaag cggtatttaa atactttacc ttcgttttct ggagcagctg
   147481 ggtcttttac tacaagaatg ttagcccagt aagaagtttt acgtttaaca agactgtact
   147541 ctttattgtc agtgttgtat agatcatttt tactgatgta ttgacatact gggcaagaat
   147601 cgtaatcacc atgggtagat gaacatgttt caatatacca tttaccattt ttcttgaaac
   147661 cgtgatttac aagaattgcg aatggtgctt gttcatcatt tttagacgga agaaaacgaa
   147721 ttactgcttg accgttaccc gcattatcga gtttcagttt ccactcgcct ttatcttcag
   147781 aagaaaaacc tttattgcca ttcagtttag ccatttgtgc agcgagttca gcagtagatt
   147841 tacgtttaaa catttttatt tcctttttaa tttaatttaa ttaacagttg gtgctatgac
   147901 actttacctc atagctggca taattcgcaa tactctgggt cttcgagagg tatccaacct
   147961 gagttgaaat actttaccat cgatttagca gttgtatcag ttatatttat attaccttta
   148021 actcttcgcc atccaggagt tttaccgtac agattagagg ataataataa cacataattc
   148081 tcgtaagcaa tatgagataa tttccaagac tctatattag ctcgtgatgt tttccaaggt
   148141 ctaaaatcgt cacggttcat ataattagcc aatctcatat gctctctaac ttccgggtct
   148201 ttggctggat gagtttcacc actcacacca aatccaccac cagcatatac cagattaaaa
   148261 tagtctggat tatctctggc atttacttca agttggtatt ttcgttctgc ttcaataaca
   148321 tccaagtcat catcaatttg aattatttta acgctcggtt tttgaagcat tagcgcattc
   148381 aaaaatcttt tttgtttaca tgagctccag tattcctttc cggaagagtc atatattatt
   148441 ccgttctcaa atgagcaatt taatttacta ccgatatagt agtatggcgg agtcttattt
   148501 ttgacacggt cttcaaatgt aaaccaatat actatattca tatcaatact tgcaagattt
   148561 cacagtttca atgaaaacat ttttagcttt ctgtgaatca atatttaaaa tttttctata
   148621 agcctttaac tttatagaat aattattcca gactaaatta tcagtctgtt catcatgttt
   148681 atcaattata tttaaaaacg aatcaagcaa gataaacgtc tcaaacgaaa ttatgttcga
   148741 ttgcagaagt ttaaaaatat aacttgattg aacttttgga ttatactcaa aaatttcttt
   148801 aaaagcagaa acttcaactt ttttactaaa ataataaatg ttgcgaatat cttcttcaaa
   148861 cttaaattta atttgcttta agcgtccgat atattcacga taaaacacaa gtgcatcagc
   148921 gtcagagatg tcaccaatcc aagcatcttg gttagcaacc aaattgctta taaagattaa
   148981 agcaagttcc tttaatttat atttttctga taacttctgg aaaaaatact tatcccttcg
   149041 cttttgataa gcggcatcag acacccgcat gcaccaatta tacttaatta catcatactt
   149101 tccattcata tgttgtttta tcattaagta taatttataa actgatttac catcaatgta
   149161 tctttcacca ccagcaggca tgcggagttt aatcatagta gaaaatctaa tgtattagtt
   149221 ttttcacaac gaacaacaga aggacgtaaa agattttcgt caatagcttc tgactgaatt
   149281 ttttcaatta tacccgaagg aataaattta gcaaattgag tttcaggaat agaattttct
   149341 tctaagaatg ctgttgtagc ttcaagataa ctcattccaa actcttctac cattttttca
   149401 ataataaatc cattttcttg gcggtcaaga agctttgcta tttcatcctt ttctttctta
   149461 attgaaagtt ctttttctga aagaccggtc tcatcgaccg gacgaatatc atttagagaa
   149521 aactgtgtca taaagttcaa ctacctcttc agtttcagct tcaaacacat cacggttatc
   149581 tttatgatac aaagctaata gacgattaaa catcttacca tcaacgccaa gttcatcttt
   149641 agcacgaatt cgaatatctt taatcagttc attataaccg gaaattttca gtttatgatc
   149701 agatgcttct ttaataaatt tagccaagtc ttcgccatgg atagcttcat caaattcaac
   149761 catttctttt ttagccatta ttcacctcaa aattcattaa tgctattagt taatttagaa
   149821 agacccgctt ttacaaaata tgaataaatt ttgccacgcg gtggtaattt atatgaatta
   149881 tagtaattca caatgtttga agcaatatta tcaggaatat aatcaaaatc aattagaact
   149941 aaattttctt tataacgatt atattcagat tcagtgagaa gcaccttagc ttgctcacgg
   150001 tcattagcaa tagcttcaac gattgaagtt ttcattgaag gagttcgttc accttcaact
   150061 ctggtaaacc aaaagtcaga tcgtacttta actgaagcaa cgttatcctt tttgtcgcct
   150121 ttaaggattt tagtcataca gtcaatttca gcagaaccgc ttttaatttt aacccatttc
   150181 ttatgcatcg gagaccattg cttaacattt ggatatttgt gaagctgagt aaagtcacca
   150241 tctgacgaaa tgattaaaat cttatgtcct tctaaagaga actttttaac aagaacagca
   150301 atgtggtcat ctgcttcata cttatcaata tccataacaa tgtatggcat ataagctttc
   150361 aattcatcta taactttatg gctggattca aaataacctt cccagtccca agtagattct
   150421 tctcgtgctt ttccacggtt tttcttataa taataagcga aatcacgacg ccaatatcca
   150481 gatttcgcgt tatcaataca cagtacaatt ttagtgtatc caagcgtttt tgcttttttg
   150541 acattaaact taattgagtt caatatcaaa tgacgaacca ttgataaatt aattttttct
   150601 ttatctggga agtttaccaa agcagttgaa agcgcaattt gactaaagtc aattaagcag
   150661 attccttctt tgtaatcttc atccaacatc atttctaaat ccatatgaac ctcgttcaat
   150721 tagtgagatt tctattatat accatccaaa tcttaaagta aacaagtata aatacttatt
   150781 attgaaaaca caataggagc ccgggagaat ggccgagatt aaaagagaat tcagagcaga
   150841 agatggtctg gacgcaggtg gtgataaaat aatcaacgta gctttagctg atcgtaccgt
   150901 aggaactgac ggtgttaacg ttgattactt aattcaagaa aacacagttc aacagtatga
   150961 tccaactcgt ggatatttaa aagattttgt aatcatttat gataaccgct tttgggctgc
   151021 tataaatgat attccaaaac cagcaggagc ttttaatagc ggacgctgga gagcattacg
   151081 taccgatgct aactggatta cggtttcatc tggttcatat caattaaaat ctggtgaagc
   151141 aatttcggtt aacaccgcag ctggaaatga catcacgttt actttaccat cttctccaat
   151201 tgatggtgat actatcgttc tccaagatat tggaggaaaa cctggagtta accaagtttt
   151261 aattgtagct ccagtacaaa gtattgtaaa ctttagaggt gaacaggtac gttcagtact
   151321 aatgactcat ccaaagtcac agctagtttt aatttttagt aatcgtctgt ggcaaatgta
   151381 tgttgctgat tatagtagag aagctatagt tgtaacacca gcgaatactt atcaagcgca
   151441 atccaacgat tttatcgtac gtagatttac ttctgctgca ccaattaatg tcaaacttcc
   151501 aagatttgct aatcatggcg atattattaa tttcgtcgat ttagataaac taaatccgct
   151561 ttatcataca attgttacta catacgatga aacgacttca gtacaagaag ttggaactca
   151621 ttccattgaa ggccgtacat cgattgacgg tttcttgatg tttgatgata atgagaaatt
   151681 atggagactg tttgacgggg atagtaaagc gcgtttacgt atcataacga ctaattcaaa
   151741 cattcgtcca aatgaagaag ttatggtatt tggtgcgaat aacggaacaa ctcaaacaat
   151801 tgagcttaag cttccaacta atatttctgt tggtgatact gttaaaattt ccatgaatta
   151861 catgagaaaa ggacaaacag ttaaaatcaa agctgctgat gaagataaaa ttgcttcttc
   151921 agttcaattg ctgcaattcc caaaacgctc agaatatcca cctgaagctg aatgggttac
   151981 agttcaagaa ttagttttta acgatgaaac taattatgtt ccagttttgg agcttgctta
   152041 catagaagat tctgatggaa aatattgggt tgtacagcaa aacgttccaa ctgtagaaag
   152101 agtagattct ttaaatgatt ctactagagc aagattaggc gtaattgctt tagctacaca
   152161 agctcaagct aatgtcgatt tagaaaattc tccacaaaaa gaattagcaa ttactccaga
   152221 aacgttagct aatcgtactg ctacagaaac tcgcagaggt attgcaagaa tagcaactac
   152281 tgctcaagtg aatcagaaca ccacattctc ttttgctgat gatattatca tcactcctaa
   152341 aaagctgaat gaaagaactg ctacagaaac tcgtagaggt gtcgcagaaa ttgctacgca
   152401 gcaagaaact aatgcaggaa ccgatgatac tacaatcatc actcctaaaa agcttcaagc
   152461 tcgtcaaggt tctgaatcat tatctggtat tgtaaccttt gtatctactg caggtgctac
   152521 tccagcttct agccgtgaat taaatggtac gaatgtttat aataaaaaca ctgataattt
   152581 agttgtttca cctaaagctt tggatcagta taaagctact ccaacacagc aaggtgcagt
   152641 aattttagca gttgaaagtg aagtaattgc tggacaaagt cagcaaggat gggcaaatgc
   152701 tgttgtaacg ccagaaacgt tacataaaaa gacatcaact gatggaagaa ttggtttaat
   152761 tgaaattgct acgcaaagtg aagttaatac aggaactgat tatactcgtg cagtcactcc
   152821 taaaacttta aatgaccgta gagcaactga aagtttaagt ggtatagctg aaattgctac
   152881 acaagttgaa ttcgacgcag gcgtcgacga tactcgtatc tctacaccat taaaaattaa
   152941 aaccagattt aatagtactg atcgtacttc tgttgttgct ctatctggat tagttgaatc
   153001 aggaactctc tgggaccatt atacacttaa tattcttgaa gcaaatgaga cacaacgtgg
   153061 tacacttcgt gtagctacgc aggtcgaagc tgctgcggga acattagata atgttttaat
   153121 aactcctaaa aagcttttag gtactaaatc tactgaagcg caagagggtg ttattaaagt
   153181 tgcaactcag tctgaaactg tgactggaac gtcagcaaat actgctgtat ctccaaaaaa
   153241 tttaaaatgg attgcgcaga gtgaacctac ttgggcagct actactgcaa taagaggttt
   153301 tgttaaaact tcatctggtt caattacatt cgttggtaat gatacagtcg gttctaccca
   153361 agatttagaa ctgtatgaga aaaatagcta tgcggtatca ccatatgaat taaaccgtgt
   153421 attagcaaat tatttgccac taaaagcaaa agctgctgat acaaatttat tggatggtct
   153481 agattcatct cagttcattc gtagggatat tgcacagacg gttaatggtt cactaacctt
   153541 aacccaacaa acgaatctga gtgcccctct tgtatcatct agtactggtg aatttggtgg
   153601 ttcattggcc gctaatagaa catttaccat ccgtaataca ggagccccga ctagtatcgt
   153661 tttcgaaaaa ggtcctgcat ccggggcaaa tcctgcacag tcaatgagta ttcgtgtatg
   153721 gggtaaccaa tttggcggcg gtagtgatac gacccgttcg acagtgtttg aagttggcga
   153781 tgacacatct catcactttt attctcaacg taataaagac ggtaatatag cgtttaacat
   153841 taatggtact gtaatgccaa taaacattaa tgcttccggt ttgatgaatg tgaatggcac
   153901 tgcaacattc ggtcgttcag ttacagccaa tggtgaattc atcagcaagt ctgcaaatgc
   153961 ttttagagca ataaacggtg attacggatt ctttattcgt aatgatgcct ctaataccta
   154021 ttttttgctc actgcagccg gtgatcagac tggtggtttt aatggattac gcccattatt
   154081 aattaataat caatccggtc agattacaat tggtgaaggc ttaatcattg ccaaaggtgt
   154141 tactataaat tcaggcggtt taactgttaa ctcgagaatt cgttctcagg gtactaaaac
   154201 atctgattta tatacccgtg cgccaacatc tgatactgta ggattctggt caatcgatat
   154261 taatgattca gccacttata accagttccc gggttatttt aaaatggttg aaaaaactaa
   154321 tgaagtgact gggcttccat acttagaacg tggcgaagaa gttaaatctc ctggtacact
   154381 gactcagttt ggtaacacac ttgattcgct ttaccaagat tggattactt atccaacgac
   154441 gccagaagcg cgtaccactc gctggacacg tacatggcag aaaaccaaaa actcttggtc
   154501 aagttttgtt caggtatttg acggaggtaa ccctcctcaa ccatctgata tcggtgcttt
   154561 accatctgat aatgctacaa tggggaatct tactattcgt gatttcttgc gaattggtaa
   154621 tgttcgcatt gttcctgacc cagtgaataa aacggttaaa tttgaatggg ttgaataaga
   154681 ggtattatgg aaaaatttat ggccgagttt ggacaaggat atgtccaaac gccattttta
   154741 tcggaaagta attcagtaag atataaaata agtatagcgg gttcttgccc gctttctaca
   154801 gcaggaccat catatgttaa atttcaggat aatcctgtag gaagtcaaac atttagcgca
   154861 ggcctccatt taagagtttt tgacccttcc accggagcat tagttgatag taagtcatat
   154921 gccttttcga cttcaaatga tactacatca gctgcttttg ttagtttcat gaattctttg
   154981 acgaataatc gaattgttgc tatattaact agtggaaagg ttaattttcc tcctgaagta
   155041 gtatcttggt taagaaccgc cggaacgtct gcctttccat ctgattctat attgtcaaga
   155101 tttgacgtat catatgctgc tttttatact tcttctaaaa gagctatcgc attagagcat
   155161 gttaaactga gtaatagaaa aagcacagat gattatcaaa ctattttaga tgttgtattt
   155221 gacagtttag aagatgtagg ggctaccggg tttccaagag gaacgtatga aagtgttgag
   155281 caattcatgt cggcagttgg tggaactaat gacgaaattg cgagattgcc aacttcagct
   155341 gctataagta aattatctga ttataattta attcctggag atgttcttta tcttaaagct
   155401 cagttatatg ctgatgctga tttacttgct cttggaacta caaatatatc tatccgtttt
   155461 tataatgcat ctaacggata tatttcttca acacaagctg aatttactgg gcaagctggg
   155521 tcatgggaat taaaggaaga ttatgtagtt gttccagaaa acgcagtagg atttacgata
   155581 tacgcacaga gaactgcaca agctggccaa ggtggcatga gaaatttaag cttttctgaa
   155641 gtatcaagaa atggcggcat ttcgaaacct gctgaatttg gcgtcaatgg tattcgtgtt
   155701 aattatatct gcgaatccgc ttcacccccg gatataatgg tacttcctac gcaagcatcg
   155761 tctaaaactg gtaaagtgtt tgggcaagaa tttagagaag tttaaattga gggacccttc
   155821 gggttccctt tttctttata aatactattc aaataaaggg gcatacaatg gctgatttaa
   155881 aagtaggttc aacaactgga ggctctgtca tttggcatca aggaaatttt ccattgaatc
   155941 cagccggtga cgatgtactc tataaatcat ttaaaatata ttcagaatat aacaaaccac
   156001 aagctgctga taacgatttc gtttctaaag ctaatggtgg tacttatgca tcaaaggtaa
   156061 catttaacgc tggcattcaa gtcccatatg ctccaaacat catgagccca tgcgggattt
   156121 atgggggtaa cggtgatggt gctacttttg ataaagcaaa tatcgatatt gtttcatggt
   156181 atggcgtagg atttaaatcg tcatttggtt caacaggccg aactgttgta attaatacac
   156241 gcaatggtga tattaacaca aaaggtgttg tgtcggcagc tggtcaagta agaagtggtg
   156301 cggctgctcc tatagcagcg aatgacctta ctagaaagga ctatgttgat ggagcaataa
   156361 atactgttac tgcaaatgca aactctaggg tgctacggtc tggtgacacc atgacaggta
   156421 atttaacagc gccaaacttt ttctcgcaga atcctgcatc tcaaccctca cacgttccac
   156481 gatttgacca aatcgtaatt aaggattctg ttcaagattt cggctattat taagaggact
   156541 tatggctact ttaaaacaaa tacaatttaa aagaagcaaa atcgcaggaa cacgtcctgc
   156601 tgcttcagta ttagccgaag gtgaattggc tataaactta aaagatagaa caatttttac
   156661 taaagatgat tcaggaaata tcatcgatct aggttttgct aaaggcgggc aagttgatgg
   156721 caacgttact attaacggac ttttgagatt aaatggcgat tatgtacaaa caggtggaat
   156781 gactgtaaac ggacccattg gttctactga tggcgtcact ggaaaaattt tcagatctac
   156841 acagggttca ttttatgcaa gagcaacaaa cgatacttca aatgcccatt tatggtttga
   156901 aaatgccgat ggcactgaac gtggcgttat atatgctcgc cctcaaacta caactgacgg
   156961 tgaaatacgc cttagggtta gacaaggaac aggaagcact gccaacagtg aattctattt
   157021 ccgctctata aatggaggcg aatttcaggc taaccgtatt ttagcatcag attcgttagt
   157081 aacaaaacgc attgcggttg ataccgttat tcatgatgcc aaagcatttg gacaatatga
   157141 ttctcactct ttggttaatt atgtttatcc tggaaccggt gaaacaaatg gtgtaaacta
   157201 tcttcgtaaa gttcgcgcta agtccggtgg tacaatttat catgaaattg ttactgcaca
   157261 aacaggcctg gctgatgaag tttcttggtg gtctggtgat acaccagtat ttaaactata
   157321 cggtattcgt gacgatggca gaatgattat ccgtaatagc cttgcattag gtacattcac
   157381 tacaaatttc ccgtctagtg attatggcaa cgtcggtgta atgggcgata agtatcttgt
   157441 tctcggcgac actgtaactg gcttgtcata caaaaaaact ggtgtatttg atctagttgg
   157501 cggtggatat tctgttgctt ctattactcc tgacagtttc cgtagtactc gtaaaggtat
   157561 atttggtcgt tctgaggacc aaggcgcaac ttggataatg cctggtacaa atgctgctct
   157621 cttgtctgtt caaacacaag ctgataataa caatgctgga gacggacaaa cccatatcgg
   157681 gtacaatgct ggcggtaaaa tgaaccacta tttccgtggt acaggtcaga tgaatatcaa
   157741 tacccaacaa ggtatggaaa ttaacccggg tattttgaaa ttggtaactg gctctaataa
   157801 tgtacaattt tacgctgacg gaactatttc ttccattcaa cctattaaat tagataacga
   157861 gatattttta actaaatcta ataatactgc gggtcttaaa tttggagctc ctagccaagt
   157921 tgatggcaca aggactatcc aatggaacgg tggtactcgc gaaggacaga ataaaaacta
   157981 tgtgattatt aaagcatggg gtaactcatt taatgccact ggtgatagat ctcgcgaaac
   158041 ggttttccaa gtatcagata gtcaaggata ttatttttat gctcatcgta aagctccaac
   158101 cggcgacgaa actattggac gtattgaagc tcaatttgct ggggatgttt atgctaaagg
   158161 tattattgcc aacggaaatt ttagagttgt tgggtcaagc gctttagccg gcaatgttac
   158221 tatgtctaac ggtttgtttg tccaaggtgg ttcttctatt actggacaag ttaaaattgg
   158281 cggaacagca aacgcactga gaatttggaa cgctgaatat ggtgctattt tccgtcgttc
   158341 ggaaagtaac ttttatatta ttccaaccaa tcaaaatgaa ggagaaagtg gagacattca
   158401 cagctctttg agacctgtga gaataggatt aaacgatggc atggttgggt taggaagaga
   158461 ttcttttata gtagatcaaa ataatgcttt aactacgata aacagtaact ctcgcattaa
   158521 tgccaacttt agaatgcaat tggggcagtc ggcatacatt gatgcagaat gtactgatgc
   158581 tgttcgcccg gcgggtgcag gttcatttgc ttcccagaat aatgaagacg tccgtgcgcc
   158641 gttctatatg aatattgata gaactgatgc tagtgcatat gttcctattt tgaaacaacg
   158701 ttatgttcaa ggcaatggct gctattcatt agggacttta attaataatg gtaatttccg
   158761 agttcattac catggcggcg gagataacgg ttctacaggt ccacagactg ctgattttgg
   158821 atgggaattt attaaaaacg gtgattttat ttcacctcgc gatttaatag caggcaaagt
   158881 cagatttgat agaactggta atatcactgg tggttctggt aattttgcta acttaaacag
   158941 tacaattgaa tcacttaaaa ctgatatcat gtcgagttac ccaattggtg ctccgattcc
   159001 ttggccgagt gattcagttc ctgctggatt tgctttgatg gaaggtcaga cctttgataa
   159061 gtccgcatat ccaaagttag ctgttgcata tcctagcggt gttattccag atatgcgcgg
   159121 gcaaactatc aagggtaaac caagtggtcg tgctgttttg agcgctgagg cagatggtgt
   159181 taaggctcat agccatagtg catcggcttc aagtactgac ttaggtacta aaaccacatc
   159241 aagctttgac tatggtacga agggaactaa cagtacgggt ggacacactc actctggtag
   159301 tggttctact agcacaaatg gtgagcacag ccactacatc gaggcatgga atggtactgg
   159361 tgtaggtggt aataagatgt catcatatgc catatcatac agggcgggtg ggagtaacac
   159421 taatgcagca gggaaccaca gtcacacttt ctcttttggg actagcagtg ctggcgacca
   159481 ttcccactct gtaggtattg gtgctcatac ccacacggta gcaattggat cacatggtca
   159541 tactatcact gtaaatagta caggtaatac agaaaacacg gttaaaaaca ttgcttttaa
   159601 ctatatcgtt cgtttagcat aaggagaggg gcttcggccc ttctaaatat gaaaatatat
   159661 cattattatt ttgacactaa agaattttac aaagaagaaa attacaaacc ggttaaaggc
   159721 ctcggtcttc ctgctcattc aacaattaaa aaacctttag aacctaaaga aggatacgcg
   159781 gttgtatttg atgaacgtac tcaggattgg atttatgaag aagaccatcg cggaaaacgc
   159841 gcatggactt ttaataaaga agaaattttt ataagtgaca ttggaagccc ggttggtata
   159901 actttcgatg agcccggcga atttgatata tggactgatg acggttggaa agaagacgaa
   159961 acatataagc gagttttaat tcgtaataga aaaattgaag aattatataa agagttccaa
   160021 gttttaaata atatgattga agcttctgtc gccaataaaa aggaaaaatt ctattataaa
   160081 aaccttaagc ggttctttgc tcttttagaa aagcatgagc atttaggtgg tgaattccct
   160141 tcatggcctg aaaaagaaca gaagccttgg tataagcgtt tattcaagca ttacgtataa
   160201 atatcttaaa aggagggtct atggcagcac ctagaatatc attttcgccc tctgatattc
   160261 tatttggtgt tctagatcgc ttgttcaaag ataacgctac cgggaaggtt cttgcttccc
   160321 gggtagctgt cgtaattctt ttgtttataa tggcgattgt ttggtatagg ggagatagtt
   160381 tctttgagta ctataagcaa tcaaagtatg aaacatacag tgaaattatt gaaaaggaaa
   160441 gaactgcacg ctttgaatct gtcgccctgg aacaactcca gatagttcat atatcatctg
   160501 aggcagactt tagtgcggtg tattctttcc gccctaaaaa cttaaactat tttgttgata
   160561 ttatagcata cgaaggaaaa ttaccttcaa caataagtga aaaatcactt ggaggatatc
   160621 ctgttgataa aactatggat gaatatacag ttcatttaaa tggacgtcat tattattcca
   160681 actcaaaatt tgctttttta ccaactaaaa agcctactcc cgaaataaac tacatgtaca
   160741 gttgtccata ttttaatttg gataatatct atgctggaac gataaccatg tactggtata
   160801 gaaatgatca tataagtaat gaccgccttg aatcaatatg tgctcaggcg gccagaatat
   160861 taggaagggc taaataatta tttgttcgta tacatctcta gatatcgata tacaccctca
   160921 aaaccctcgt tgaattcgtc gatgagggtt ttcttatctt cttgagttaa ttcagaaaca
   160981 attttacgga atgaattttg atttaacttt ctaccttcat gcgttactcc aatctcattt
   161041 agaaatgcaa taaaattagc acgattctca acaatatctt ctctggaaaa tttaatcaaa
   161101 atagatgcaa cagtaataat ttcacgaact gtatcaatgt ttttattcat taactatacc
   161161 actcaattag ttgactttgt tataatatca tcagacgctt gatttgtaaa ctggtctgtg
   161221 taattttctt caaaaatttt ttctacgaat tccttgaacg attcacgttc ctgagctaca
   161281 ttatgctcga ttaccttttc aagattatga ctcattcgaa ataatcttca atttcataat
   161341 catggacata aatcattata gtttttaata catcatcaat attttttcct ggagctggaa
   161401 ttacgtaaaa ataccctgct tttgagaggt ctttataagt tccaatcaag aaatcattat
   161461 tctcaagatg taactcttca actaattcat tgacaattga atggtatagg tttggcagaa
   161521 acttatatag cttttctaga atatcaattt tgaatgtata ttgaaccacg gactgagaat
   161581 caataatcat agaccttccc cttatgtttc tgtttgcgat tagattcttt aaacgctttc
   161641 ttcttatcct tatgaacaga agctttatta aaattatgct ttgcgactaa attgttcata
   161701 gtgctgaatt acctctctta aacatttgca tgtgaatgaa aactttttag ctacaccaca
   161761 ttcaaatata tgttctctta aatcgcgtgt atcggtatat cccatctcaa caataaaatg
   161821 ccgtattaga tttttatctt tatcgtttag agaattaaaa taatcagatt ttgaattaat
   161881 ttccctggcc aaattgaatc accttcagtt gacgttttaa ctcttttatc atctcttcgt
   161941 tcatcgcaat ataaagatcg cgtagagcag gttttagcat tccatttact ggagaactaa
   162001 atggacatac ataatctttt cctacgagct ttttagtgaa ttccatatca cagaactgaa
   162061 atcccggctc attggtataa attccccaat tagttgacat cattttattg gcatattcca
   162121 gtgcctggat ttgattcata attccatcaa tttgaaactt tttaatattc attagtaaag
   162181 gtcctcagag taaagttctt tttcactacc acgttcaata cttacttgtc cagcgtaagt
   162241 tgcaataatc attgcttctt cacgtgtcca ataattacta tattggtcaa taaacccttg
   162301 gtcatcatca caaacttgct gagtaactaa ttgaggttta actacatcta aaacttctgc
   162361 catatcttta gaataatgac gagcacctgg aataataaga gttcgtccat cttttaattt
   162421 aaaacggttg gctgcgcaaa caattcgtcg ttgatacttt tggttttcat cccagtacgc
   162481 agtctgccaa cagatttcag gaacttcttt cagaatatct tcttctgtgc atttataacc
   162541 atgcgcttta aatttttcaa caagactttc tggagtttca cgagataaag gaacattcag
   162601 catttttaaa cgattgataa atgggttcat ttaaaccatc ctttaatacg ctgccacaaa
   162661 gttttctgtt gagctttgtt gacgccaatt gagcgaataa ccggttgaga ttcctggaat
   162721 tctttataat cagcaaggta aatttcgtaa gctgcatccg taaatgaact tatcgctgcc
   162781 ataaaattat tgcgaatacc tactggagca tctttacttt cacgaatgat catgtattta
   162841 ccagtcttaa tctttacgat agttccaaga taagctccat ggtaccaaat atcccaaccc
   162901 tcttgagtag gttctgcgca acgacgaagt tcattgacaa tttctaactt gtttattatt
   162961 tattcctcac agttcagatg ctacagtgat tacagcttca atgttttctg ccgagcgttt
   163021 aatgtcaaga tacacattac cgtttttagc gattttacat gacattccga tgtcagtaaa
   163081 tttctgaata tgatgttcca tcattttgta tccaaaaatt cgcatatttc cattgttatt
   163141 aatttcaaaa ttacgaattc cgttagtgcg tttttctaaa atagcaagat aattactacg
   163201 ataaatttca acctttttaa gaacaaatcc atttttatct aaaagtttta acatgaggtc
   163261 tttatcttct tccatatcgg aagtaatctc gcgagcttta cgagttgctc gttttttcag
   163321 cagttccgga gcattttcct gtgcatataa agttgctgca tttgaaataa tatcctgagc
   163381 ttcaccagta atgattaatc catcaccaga tttctccacc aggccttttt taatcaatac
   163441 cccaatatta ctattaacta ctgcgttacc taaatctgga tgcacctcac gaacttctgc
   163501 agctgtaatg aaatctttct tagcaatggt aattaaaatc gtagcagttt tttcattcag
   163561 aacatcgtta gaagctttga tgatgtaagt tactttagac attttctaat ctccgtaatt
   163621 ctgtatcagt agttgatagt tgtatagtac cacagtatgc tttggttgta aaccgttttg
   163681 tgaaaaaatt tttaaaataa aaaagggaga gcctcggctc tccctaaaat tactgcatga
   163741 ctgtgataac tgtcatgata acacgttgaa ttccgaacgc aagaagacct cctgctacgg
   163801 ctggaacaac gcctaaaccc gccagtaaaa tgctaccaga tactaatgca gcgcttgtaa
   163861 taccaatgaa tggactcatt tgatttcctc taaatctttg gtgtattcag taactacatc
   163921 agtagttttc caatattcgt tttcttcttt tttagcttta gcttcttcag caagtttctt
   163981 tgcttcatcg gaagtcatat gaaaaatatt cattccaact agtttatcaa cataagaaga
   164041 atacatatcg attttcgaaa gttcttcggt cagttcttta cgagttttac cctgtacaac
   164101 aatttcacct gaaattactt tcttaatgaa atgtgctttg gcaaaggcta aacgaaaagc
   164161 tgactcagtt tctttaattt tgttatcaat tcgtttttgg acataagttt tacgaacttc
   164221 aacaaagtct ttaattaaat caactacgtt atcgtaaact tgcagctttc ctttctcatt
   164281 aataaccgta atattctggg aacgacgctc aatcagtccg aagtctttca taatttttgc
   164341 atggcgttct tcttcgttat cgctcaaaga atattctttg cggaatttaa ctttgaagcc
   164401 aaaaccatgc tcaccacaag catcatccca tgtaatgaag cctttatttt caagtgggtc
   164461 taagatttta ctcacataag tttcacgatc atacttatac ggaatctcag tgatatgcat
   164521 ttgagttcgt gaagtaaact tatatgttcc acgaatttca tattgcccat caatttcaac
   164581 gacttcacca cgaaattctg ggaattctac tttcggttta gttactttct ttccttgaag
   164641 agcttgcagt acagctttct tgacagaaga aacactatga ggaagaatgt aagttgcata
   164701 accagttgca ataccggaaa cgccattaag aagaacagta ggaataatag gcaaatagaa
   164761 agcaggcgga atgtgttctt tatcttgatg taccggagca tattcagtat ctttatatac
   164821 gttatagaaa tttttactta cacgagcaaa aatataacga cttgccgctg ccttttggac
   164881 agtacgagaa ccaaagtttc cttgaccatc taacagagga aagttattat tccaagtatt
   164941 agccatcaaa gcacctgcgt cttgtgcaga gttttcacca tgatgatatc caaggtccgc
   165001 tacaccacct gcaatagaag cgagtttgtg aaacttatct ttatttcctc gtgccaaatc
   165061 aagagctcga gcaataacaa atcgttgaac tggcttaaat ccatcaatca tatttgggat
   165121 agcacgattt tcaaccgtgt acatagcata agccaatgct tcattatcaa tgatactttt
   165181 taaatcgcga ttattcagtt gcataaattt accatactag tgaatgtagt gccataataa
   165241 catcagaaat gaaaagcacg acttgaatta atccgaacat tactccgtaa tatagtgcta
   165301 ccaataaagc agcaagggct aatgaatagc ccaagatttt cttaatcatt agataacaac
   165361 acaaatgtta aatatgcaca cataccctgg gctaaagctt gtgaaaacac actgctagca
   165421 tcgatacaga tagttaaaac acatgctact atccaacaaa taaatgaaat aactcctaat
   165481 aattttgcaa tattcatatt ttcctcactg gcgtccgaag acgcctttag ttttaagatt
   165541 gttacgatag aactgcatca cgtgttcgtt atggaaatta ctcattaata tgcctgtaaa
   165601 acaaatttaa agttatcagc caacatacgg ttcatttctt cgagtgtttg atactcagaa
   165661 tgatgattac gagtaaacgc caaagctagc tgaccttttc caaatcccgt cgttagaggt
   165721 ttcatcttag aagcaggcag ataaaacact gtgtatggaa cattgttatt tgcaatagta
   165781 cgcgcaagtt gagaccggcg ttgacgaata tgacttaaaa ccgcactgaa tccttgctta
   165841 gaacgctgat tacctacata aaatcgtgca gatacgcatg gattactaaa tggaccaccg
   165901 agtttactca ctaaaaagta aaatccaggt ttagataaaa tatctttatg cggagttcct
   165961 aaaaaccatt caccaccctt gattgtacca ataacagtag cgcctgcatc attcagatca
   166021 gtaacagtca tatatttcat attaatttcc tctaaattat tttctactcc aaggccgcat
   166081 gaatacacac ggccattaaa ttactcgtcg cagtcgacgc tcaattccca aaactcttct
   166141 acagtataag tttcagtatc attttcaata cagaaacgtt cattactatt atttgctaaa
   166201 gtagcattaa ctgtcatttt ttcgctagtg ctcttaagag gtgaaatacg aattaactga
   166261 tcaccgttat ctaaacaaaa aatttcacca acttttacat ctttaaaact tttcataatt
   166321 cacctcaagg agtataaaat ccaaatgcag ttgttgacca tcccatccaa tatggaaaat
   166381 ttacaccaat gtaaaacata agaatataaa accaaccgct cagcaaattc atcattttac
   166441 accattccaa attgtttcaa ccacggattt taaaccattt tgatgaatat ccattcctac
   166501 taccgccatc aaataaattc caactacaac tgaacctaag gcaaaaatca gcatgaaaat
   166561 gaataaagcc ggaaaaatat tatcgaaaaa ccattcaata aatgtaaaag cactgcgttt
   166621 acgttcatat tttcctcaca taaatccaaa gtaaacgttt aatacatcaa tcattaaaac
   166681 gattgggaat atactcaaaa ctattagtat tataactaca ttccatatag ctttaataat
   166741 ctttttcatt ttctgttcct ccatagttga tagggtaata gtaccacgga agaacagtct
   166801 tgtaaacaac ttttttaaaa atattcgtaa taaatgtgaa taccaactac taccgctgaa
   166861 acctgtgcaa cccaccacgc acaagcaata agtacagaat tcaaaatttt cataataacc
   166921 tcattacaaa agtaaatgtt aaacaaatta ctggaatact aattaaccaa acaaaacacc
   166981 accataatga actcatagtt caatctcagc gattttcatt ttattctcca aatccgtatc
   167041 agtagttgat agttgtatag taccacggtc cttgtggtat gtaaactgtt ttgtgaaatt
   167101 ttttaaatgg aaagatacca tccgttgtag ttgctttttc ttacaacttt acgaaggtct
   167161 tctctgtcac cgatgaactt cggagtgtac tggatgacac ctggatgaat ttctttagtg
   167221 ttgaatataa ttatacagtc agcgacttga tgatttagaa tgggccctag atttattcca
   167281 gaaccatatg gatactctcc gctgcatccc gttgttaccg aaatccaacg tgagtcagtt
   167341 tgatgtgtct taacttctac acgaagcccg cagtattttg gatgagccaa tacatcccat
   167401 gcatatgtgt acggatcatc gacatcctct tggcctttat tgacatatcc actcaaccaa
   167461 tctgccacaa aaaactctgc gtacacagcg atacggcatc tttcgataac ttctgcctta
   167521 tcttgatttg ggttttgttt taaagagtat cttgcagtat cagcaatttt gaccttcatt
   167581 tcacaggtca agtcactgtt cgatagggta aatgtcggaa tctgaaatag tctctgtaac
   167641 ccaggattcg ttttctgcat ttaaactttc ctttatgtcg gaatcaccga tattcatata
   167701 aatcataatt tctcttaaaa caaaaggccg aagcccttta ttttacttga attgtgcaat
   167761 tcttttctct agacattcag cataagattt cattgagatg aactgcgaaa gtagcagttc
   167821 ttgctcaact gcgctaactg ttagaaactt tgcgctttct aaaaatttgc tcagtgcatt
   167881 aattttgagc attaattgat cgtattcttc ttttactcgt gcttgataag ctaacataat
   167941 tttccttagt taagggccga agccttattt aaattgttca gtaacgtctt caactacttc
   168001 atattggcag gtacgcattt tagcatcgtt gtaatcaatc ggaattgata ctacatcgcg
   168061 aggatgaact ttaactttta caactcggct ggttgaacta ccaaagtgac gaatataaga
   168121 tttagaacac acatgcaaac cacgagaaca agtttgtgta tcatcgtcat tcacacgagt
   168181 acgtggcatt ttaactactt tacccggact gttatcaaag gtgtttgagt gacagtcaaa
   168241 gtaattgctg cgaactactt tccaagcata gaagtaacca tcttctgtaa tttcaatatc
   168301 gtttgctacc aagaaatcaa agagtcgaga taccgctttt tggcttgggt tttccaacag
   168361 attttccaag aacggaaaat aaaattcaaa gttttcgcct ttttccatcg agtcaagaat
   168421 acgatcaacc aaaccagacc gcaattcaat attttgatag aacaagcttc caccttcaat
   168481 tcgaacatcg ccggaaatat atttttcaac agcacgacga acattaattt tttgtgccgc
   168541 ttcttccaac ttatccgcta caagcagatt aagaatttcc tggaagtttg aatgagtatt
   168601 aggagttgcg ttataagtta cgccatcaac agtaattgaa atgaattttt tagatgcatt
   168661 ccaaataatg tcagatttag caactggagc aataactgca tcgctattaa ctttaactgt
   168721 aatatcaccg ctaatagtaa ctttagggcg tttagcttct tcagcatttt tcaaaacacg
   168781 acggattgtg tcaaccgata caccttgcca atcagccaat tcctgttggg tgtaattacc
   168841 acttgaatac agtttaacaa tttcagcttg ttcgtttttg gtcaggcatt taatattgta
   168901 cat
"""

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


gp3 = """MSQALQQIFNQANTTNFVVSIPHSNTTSAFTLNAQSVPIPGIRI
                     PVTDTVTGPFGLGRAQRPGVTFEYDPLIVRFIVDEELKSWIGMYEWMLGTSNYLTGEN
                     TAQKTGPEYITLYILDNSKTEIVMSINFYKPWVSDLSEVEFSYTEDSDPALVCTATIP
                     YTYFQVEKDGKIIAEV"""

gp5 = """MEMISNNLNWFVGVVEDRMDPLKLGRVRVRVVGLHPPQRAQGDV
                     MGIPTEKLPWMSVIQPITSAAMSGIGGSVTGPVEGTRVYGHFLDKWKTNGIVLGTYGG
                     IVREKPNRLEGFSDPTGQYPRRLGNDTNVLNQGGEVGYDSSSNVIQDSNLDTAINPDD
                     RPLSEIPTDDNPNMSMAEMLRRDEGLRLKVYWDTEGYPTIGIGHLIMKQPVRDMAQIN
                     KVLSKQVGREITGNPGSITMEEATTLFERDLADMQRDIKSHSKVGPVWQAVNRSRQMA
                     LENMAFQMGVGGVAKFNTMLTAMLAGDWEKAYKAGRDSLWYQQTKGRASRVTMIILTG
                     NLESYGVEVKTPARSLSAMAATVAKSSDPADPPIPNDSRILFKEPVSSYKGEYPYVHT
                     METESGHIQEFDDTPGQERYRLVHPTGTYEEVSPSGRRTRKTVDNLYDITNADGNFLV
                     AGDKKTNVGGSEIYYNMDNRLHQIDGSNTIFVRGDETKTVEGNGTILVKGNVTIIVEG
                     NADITVKGDATTLVEGNQTNTVNGNLSWKVAGTVDWDVGGDWTEKMASMSSISSGQYT
                     IDGSRIDIG"""

# count 6
gp6 = """MANTPVNYQLTRTANAIPEIFVGGTFAEIKQNLIEWLNGQNEFL
                     DYDFEGSRLNVLCDLLAYNTLYIQQFGNAAVYESFMRTANLRSSVVQAAQDNGYLPTS
                     KSAAQTEIMLTCTDALNRNYITIPRGTRFLAYAKDTSVNPYNFVSREDVIAIRDKNNQ
                     YFPRLKLAQGRIVRTEIIYDKLTPIIIYDKNIDRNQVKLYVDGAEWINWTRKSMVHAG
                     STSTIYYMRETIDGNTEFYFGEGEISVNASEGALTANYIGGLKPTQNSTIVIEYISTN
                     GADANGAVGFSYADTLTNITVININENPNDDPDFVGADGGGDPEDIERIRELGTIKRE
                     TQQRCVTATDYDTFVSERFGSIIQAVQTFTDSTKPGYAFIAAKPKSGLYLTTVQREDI
                     KNYLKDYNLAPITPSIISPNYLFIKTNLKVTYALNKLQESEQWLEGQIIDKIDRYYTE
                     DVEIFNSSFAKSKMLTYVDDADHSVIGSSATIQMVREVQNFYKTPEAGIKYNNQIKDR
                     SMESNTFSFNSGRKVVNPDTGLEEDVLYDVRIVSTDRDSKGIGKVIIGPFASGDVTEN
                     ENIQPYTGNDFNKLANSDGRDKYYVIGEINYPADVIYWNIAKINLTSEKFEVQTIELY
                     SDPTDDVIFTRDGSLIVFENDLRPQYLTIDLEPISQ"""

# count 6
gp7 = """MTVKAPSVTSLRISKLSANQVQVRWDDVGANFYYFVEIAETKTN
                     SGENLPSNQYRWINLGYTANNSFFFDDADPLTTYIIRVATAAQDFEQSDWIYTEEFET
                     FATNAYTFQNMIEMQLANKFIQEKFTLNNSDYVNFNNDTIMAALMNESFQFSPSYVDV
                     SSISNFIIGENEYHEIQGSIQQVCKDINRVYLMESEGILYLFERYQPVVKVSNDKGQT
                     WKAVKLFNDRVGYPLSKTVYYQSANTTYVLGYDKIFYGRKSTDVRWSADDVRFSSQDI
                     TFAKLGDQLHLGFDVEIFATYATLPANVYRIAEAITCTDDYIYVVARDKVRYIKTSNA
                     LIDFDPLSPTYSERLFEPDTMTITGNPKAVCYKMDSICDKVFALIIGEVETLNANPRT
                     SKIIDSADKGIYVLNHDEKTWKRVFGNTEEERRRIQPGYANMSTDGKLVSLSSSNFKF
                     LSDNVVNDPETAAKYQLIGAVKYEFPREWLADKHYHMMAFIADETSDWETFTPQPMKY
                     YAEPFFNWSKKSNTRCWINNSDRAVVVYADLKYTKVIENIPETSPDRLVHEYWDDGDC
                     TIVMPNVKFTGFKKYASGMLFYKASGEIISYYDFNYRVRDTVEIIWKPTEVFLKAFLQ
                     NQEHETPWSPEEERGLADPDLRPLIGTMMPDSYLLQDSNFEAFCEAYIQYLSDGYGTQ
                     YNNLRNLIRNQYPREEHAWEYLWSEIYKRNIYLNADKRDAVARFFESRSYDFYSTKGI
                     EASYKFLFKVLYNEEVEIEIESGAGTEYDIIVQSDSLTEDLVGQTIYTATGRCNVTYI
                     ERSYSNGKLQWTVTIHNLLGRLIAGQEVKAERLPSFEGEIIRGVKGKDLLQNNIDYIN
                     RSRSYYVMKIKSNLPSSRWKSDVIRFVHPVGFGFIAITLLTMFINVGLTLKHTETIIN
                     KYKNYKWDSGLPTEYADRIAKLTPTGEIEHDSVTGEAIYEPGPMAGVKYPLPDDYNAE
                     NNNSIFQGQLPSERRKLMSPLFDASGTTFAQFRDLVNKRLKDNIGNPRDPENPTQVKI
                     DE"""

# count 6
gp8 = """MNDSSVIYRAIVTSKFRTEKMLNFYNSIGSGPDKNTIFITFGRS
                     EPWSSNENEVGFAPPYPTDSVLGVTDMWTHMMGTVKVLPSMLDAVIPRRDWGDTRYPD
                     PYTFRINDIVVCNSAPYNATESGAGWLVYRCLDVPDTGMCSIASLTDKDECLKLGGKW
                     TPSARSMTPPEGRGDAEGTIEPGDGYVWEYLFEIPPDVSINRCTNEYIVVPWPEELKE
                     DPTRWGYEDNLTWQQDDFGLIYRVKANTIRFKAYLDSVYFPEAALPGNKGFRQISIIT
                     NPLEAKAHPNDPNVKAEKDYYDPEDLMRHSGEMIYMENRPPIIMAMDQTEEINILFTF
                     """
# count 6
gp9 = """MFIQEPKKLIDTGEIGNASTGDILFDGGNKINSDFNAIYNAFGD
                     QRKMAVANGTGADGQIIHATGYYQKHSITEYATPVKVGTRHDIDTSTVGVKVIIERGE
                     LGDCVEFINSNGSISVTNPLTIQAIDSIKGVSGNLVVTSPYSKVTLRCISSDNSTSVW
                     NYSIESMFGQKESPAEGTWNISTSGSVDIPLFHRTEYNMAKLLVTCQSVDGRKIKTAE
                     INILVDTVNSEVISSEYAVMRVGNETEEDEIANIAFSIKENYVTATISSSTVGMRAAV
                     KVIATQKIGVAQ"""

# count 6
gp10 = """MKQNINIGNVVDDGTGDYLRKGGIKINENFDELYYELGDGDVPY
                     SAGAWKTYNASSGQTLTAEWGKSYAINTSSGRVTINLPKGTVNDYNKVIRARDVFATW
                     NVNPVTLVAASGDTIKGSAVPVEINVRFSDLELVYCAPGRWEYVKNKQIDKITSSDIS
                     NVARKEFLVEVQGQTDFLDVFRGTSYNVNNIRVKHRGNELYYGDVFSENSDFGSPGEN
                     EGELVPLDGFNIRLRQPCNIGDTVQIETFMDGVSQWRSSYTRRQIRLLDSKLTSKTSL
                     EGSIYVTDLSTMKSIPFSAFGLIPGEPINPNSLEVRFNGILQELAGTVGMPLFHCVGA
                     DSDDEVECSVLGGTWEQSHTDYSVETDENGIPEILHFDSVFEHGDIINITWFNNDLGT
                     LLTKDEIIDETDNLYVSQGPGVDISGDVNLTDFDKIGWPNVEAVQSYQRAFNAVSNIF
                     DTIYPIGTIYENAVNPNNPVTYMGFGSWKLFGQGKVLVGWNEDISDPNFALNNNDLDS
                     GGNPSHTAGGTGGSTSVTLENANLPATETDEEVLIVDENGSVIVGGCQYDPDESGPIY
                     TKYREAKASTNSTHTPPTSITNIQPYITVYRWIRIA"""

# count 6
gp11 = """MSLLNNKAGVISRLADFLGFRPKTGDIDVMNRQSVGSVTISQLA
                     KGFYEPNIESAINDVHNFSIKDVGTIITNKTGVSPEGVSQTDYWAFSGTVTDDSLPPG
                     SPITVLVFGLPVSATTGMTAIEFVAKVRVALQEAIASFTAINSYKDHPTDGSKLEVTY
                     LDNQKHVLSTYSTYGITISQEIISESKPGYGTWNLLGAQTVTLDNQQTPTVFYHFERT
                     A"""
# count 6
gp12 = """MSNNTYQHVSNESRYVKFDPTDTNFPPEITDVHAAIAAISPAGV
                     NGVPDASSTTKGILFIPTEQEVIDGTNNTKAVTPATLATRLSYPNATETVYGLTRYST
                     NDEAIAGVNNESSITPAKFTVALNNAFETRVSTESSNGVIKISSLPQALAGADDTTAM
                     TPLKTQQLAIKLIAQIAPSETTATESDQGVVQLATVAQVRQGTLREGYAISPYTFMNS
                     SSTEEYKGVIKLGTQSEVNSNNASVAVTGATLNGRGSTTSMRGVVKLTTTAGSQSGGD
                     ASSALAWNADVIQQRGGQIIYGTLRIEDTFTIANGGANITGTVRMTGGYIQGNRIVTQ
                     NEIDRTIPVGAIMMWAADSLPSDAWRFCHGGTVSASDCPLYASRIGTRYGGNPSNPGL
                     PDMRGLFVRGSGRGSHLTNPNVNGNDQFGKPRLGVGCTGGYVGEVQIQQMSYHKHAGG
                     FGEHDDLGAFGNTRRSNFVGTRKGLDWDNRSYFTNDGYEIDPESQRNSKYTLNRPELI
                     GNETRPWNISLNYIIKVKE"""

# count 1
gp13 = """MSGYNPQNPKELKDVILRRLGAPIINVELTPDQIYDCIQRALEL
                     YGEYHFDGLNKGFHVFYVGDDEERYKTGVFDLRGSNVFAVTRILRTNIGSITSMDGNA
                     TYPWFTDFLLGMAGINGGMGTSCNRFYGPNAFGADLGYFTQLTSYMGMMQDMLSPIPD
                     FWFNSANEQLKVMGNFQKYDLIIVESWTKSYIDTNKMVGNTVGYGTVGPQDSWSLSER
                     YNNPDHNLVGRVVGQDPNVKQGAYNNRWVKDYATALAKELNGQILARHQGMMLPGGVT
                     IDGQRLIEEARLEKEALREELYLLDPPFGILVG"""

# count 1
gp14 = """MATYDKNLFAKLENRTGYSQTNETEILNPYVNFNHYKNSQILAD
                     VLVAESIQMRGVECYYVPREYVSPDLIFGEDLKNKFTKAWKFAAYLNSFEGYEGAKSF
                     FSNFGMQVQDEVTLSINPNLFKHQVNGKEPKEGDLIYFPMDNSLFEINWVEPYDPFYQ
                     LGQNAIRKITAGKFIYSGEEINPVLQKNEGINIPEFSELELNAVRNLNGIHDINIDQY
                     AEVDQINSEAKEYVEPYVVVNNRGKSFESSPFDNDFMD"""

# count 1
gp15 = """MFGYFYNSSFRRYATLMGDLFSNIQIKRQLESGDKFIRVPITYA
                     SKEHFMMKLNKWTSINSQEDVAKVETILPRINLHLVDFSYNAPFKTNILNQNLLQKGA
                     TSVVSQYNPSPIKMIYELSIFTRYEDDMFQIVEQILPYFQPHFNTTMYEQFGNDIPFK
                     RDIKIVLMSAAIDEAIDGDNLSRRRIEWSLTFEVNGWMYPPVDDAEGLIRTTYTDFHA
                     NTRDLPDGEGVFESVDSEVVPRDIDPEDWDGTVKQTFTSNVNRPTPPEPPGPRT"""

# count 1
gp17 = """MEQPINVLNDFHPLNEAGKILIKHPSLAERKDEDGIHWIKSQWD
                     GKWYPEKFSDYLRLHKIVKIPNNSDKPELFQTYKDKNNKRSRYMGLPNLKRANIKTQW
                     TREMVEEWKKCRDDIVYFAETYCAITHIDYGVIKVQLRDYQRDMLKIMSSKRMTVCNL
                     SRQLGKTTVVAIFLAHFVCFNKDKAVGILAHKGSMSAEVLDRTKQAIELLPDFLQPGI
                     VEWNKGSIELDNGSSIGAYASSPDAVRGNSFAMIYIDECAFIPNFHDSWLAIQPVISS
                     GRRSKIIITTTPNGLNHFYDIWTAAVEGKSGFEPYTAIWNSVKERLYNDEDIFDDGWQ
                     WSIQTINGSSLAQFRQEHTAAFEGTSGTLISGMKLAVMDFIEVTPDDHGFHQFKKPEP
                     DRKYIATLDCSEGRGQDYHALHIIDVTDDVWEQVGVLHSNTISHLILPDIVMRYLVEY
                     NECPVYIELNSTGVSVAKSLYMDLEYEGVICDSYTDLGMKQTKRTKAVGCSTLKDLIE
                     KDKLIIHHRATIQEFRTFSEKGVSWAAEEGYHDDLVMSLVIFGWLSTQSKFIDYADKD
                     DMRLASEVFSKELQDMSDDYAPVIFVDSVHSAEYVPVSHGMSMV"""

# count 144 = 24 * 6 (yttre gröna röret)
gp18 = """MTLLSPGIELKETTVQSTVVNNSTGTAALAGKFQWGPAFQIKQV
                     TNEVDLVNTFGQPTAETADYFMSAMNFLQYGNDLRVVRAVDRDTAKNSSPIAGNIDYT
                     ISTPGSNYAVGDKITVKYVSDDIETEGKITEVDADGKIKKINIPTGKNYAKAKEVGEY
                     PTLGSNWTAEISSSSSGLAAVITLGKIITDSGILLAEIENAEAAMTAVDFQANLKKYG
                     IPGVVALYPGELGDKIEIEIVSKADYAKGASALLPIYPGGGTRASTAKAVFGYGPQTD
                     SQYAIIVRRNDAIVQSVVLSTKRGEKDIYDSNIYIDDFFAKGGSEYIFATAQNWPEGF
                     SGILTLSGGLSSNAEVTAGDLMEAWDFFADRESVDVQLFIAGSCAGESLETASTVQKH
                     VVSIGDARQDCLVLCSPPRETVVGIPVTRAVDNLVNWRTAAGSYTDNNFNISSTYAAI
                     DGNHKYQYDKYNDVNRWVPLAADIAGLCARTDNVSQTWMSPAGYNRGQILNVIKLAIE
                     TRQAQRDRLYQEAINPVTGTGGDGYVLYGDKTATSVPSPFDRINVRRLFNMLKTNIGR
                     SSKYRLFELNNAFTRSSFRTETAQYLQGNKALGGIYEYRVVCDTTNNTPSVIDRNEFV
                     ATFYIQPARSINYITLNFVATATGADFDELTGLAG"""

# count 24*6 = 144 (inre mörkgröna röret)
gp19 = """MFVDDVTRAFESGDFARPNLFQVEISYLGQNFTFQCKATALPAG
                     IVEKIPVGFMNRKINVAGDRTFDDWTVTVMNDEAHDARQKFVDWQSIAAGQGNEITGG
                     KPAEYKKSAIVRQYARDAKTVTKEIEIKGLWPTNVGELQLDWDSNNEIQTFEVTLALD
                     YWE"""

gp20 = """MKFNVLSLFAPWAKMDERNFKDQEKEDLVSITAPKLDDGAREFE
                     VSSNEAASPYNAAFQTIFGSYEPGMKTTRELIDTYRNLMNNYEVDNAVSEIVSDAIVY
                     EDDTEVVALNLDKSKFSPKIKNMMLDEFSDVLNHLSFQRKGSDHFRRWYVDSRIFFHK
                     IIDPKRPKEGIKELRRLDPRQVQYVREIITETEAGTKIVKGYKEYFIYDTAHESYACD
                     GRMYEAGTKIKIPKAAVVYAHSGLVDCCGKNIIGYLHRAVKPANQLKLLEDAVVIYRI
                     TRAPDRRVWYVDTGNMPARKAAEHMQHVMNTMKNRVVYDASTGKIKNQQHNMSMTEDY
                     WLQRRDGKAVTEVDTLPGADNTGNMEDIRWFRQALYMALRVPLSRIPQDQQGGVMFDS
                     GTSITRDELTFAKFIRELQHKFEEVFLDPLKTNLLLKGIITEDEWNDEINNIKIEFHR
                     DSYFAELKEAEILERRINMLTMAEPFIGKYISHRTAMKDILQMTDEEIEQEAKQIEEE
                     SKEARFQDPDQEQEDF"""

# many
gp21 = """MNEPQLLIETWGQPGEIIDGVPMLESHDGKDLGLKPGLYIEGIF
                     MQAEVVNRNKRLYPKRILEKAVKDYINEQVLTKQALGELNHPPRANVDPMQAAIIIED
                     MWWKGNDVYGRARVIEGDHGPGDKLAANIRAGWIPGVSSRGLGSLTDTNEGYRIVNEG
                     FKLTVGVDAVWGPSAPDAWVTPKEITESQTAEADTSADDAYMALAEAMKKAL"""

# many
gp22 = """MLKEQLIAEAQKIDASVALDSIFESVNISPEAKETFGTVFEATV
                     KQHAVKLAESHIAKIAEKAEEEVEKNKEEAEEKAEKKIAEQASKFIDHLAKEWLAENK
                     LAVDKGIKAELFESMLGGLKELFVEHNVVVPEESVDVVAEMEEELQEHKEESPRLFEE
                     LNMRDAYINYVQREVALSESTKDLTESQKEKVSALVEGMDYSDAFSSKLSAIVEMVKK
                     SNKDESTITESINTPDTEAAGLNFVTEAVEDKAAQGAEDIVSVYAKVASRF"""

# many. ananas
gp23 = """MTIKTKAELLNKWKPLLEGEGLPEIANSKQAIIAKIFENQEKDF
                     QTAPEYKDEKIAQAFGSFLTEAEIGGDHGYNATNIAAGQTSGAVTQIGPAVMGMVRRA
                     IPNLIAFDICGVQPMNSPTGQVFALRAVYGKDPVAAGAKEAFHPMYGPDAMFSGQGAA
                     KKFPALAASTQTTVGDIYTHFFQETGTVYLQASVQVTIDAGATDAAKLDAEIKKQMEA
                     GALVEIAEGMATSIAELQEGFNGSTDNPWNEMGFRIDKQVIEAKSRQLKAAYSIELAQ
                     DLRAVHGMDADAELSGILATEIMLEINREVVDWINYSAQVGKSGMTLTPGSKAGVFDF
                     QDPIDIRGARWAGESFKALLFQIDKEAVEIARQTGRGEGNFIIASRNVVNVLASVDTG
                     ISYAAQGLATGFSTDTTKSVFAGVLGGKYRVYIDQYAKQDYFTVGYKGPNEMDAGIYY
                     APYVALTPLRGSDPKNFQPVMGFKTRYGIGINPFAESAAQAPASRIQSGMPSILNSLG
                     KNAYFRRVYVKGI"""

# count 12
gp24 = """MAKINELLRESTTTNSNSIGRPNLVALTRATTKLIYSDIVATQR
                     TNQPVAAFYGIKYLNPDNEFTFKTGATYAGEAGYVDREQITELTEESKLTLNKGDLFK
                     YNNIVYKVLEDTPFATIEESDLELALQIAIVLLKVRLFSDAASTSKFESSDSEIADAR
                     FQINKWQTAVKSRKLKTGITVELAQDLEANGFDAPNFLEDLLATEMADEINKDILQSL
                     ITVSKRYKVTGITDSGFIDLSYASAPEAGRSLYRMVCEMVSHIQKESTYTATFCVASA
                     RAAAILAASGWLKHKPEDDKYLSQNAYGFLANGLPLYCDTNSPLDYVIVGVVENIGEK
                     EIVGSIFYAPYTEGLDLDDPEHVGAFKVVVDPESLQPSIGLLVRYALSANPYTVAKDE
                     KEARIIDGGDMDKMAGRSDLSVLLGVKLPKIIIDE"""

# count 6
gp25 = "MANINKLYSDIDPEMKMDWNKDVSRSLGLRSIKNSLLGIITTRKGSRPFDPEFGCDLSDQLFENMTPLTADTVERNIESAVRNYEPRIDKLAVNVIPVYDDYTLIVEIRFSVIDNPDDIEQIKLQLASSNRV"

gp27 = """MSMLQRPGYPNLSVKLFDSYDAWSNNRFVELAATITTLTMRDSL
                     YGRNEGMLQFYDSKNIHTKMDGNEIIQISVANANDINNVKTRIYGCKHFSVSVDSKGD
                     NIIAIELGTIHSIENLKFGRPFFPDAGESIKEMLGVIYQDRTLLTPAINAINAYVPDI
                     PWTSTFENYLSYVREVALAVGSDKFVFVWQDIMGVNMMDYDMMINQEPYPMIVGEPSL
                     IGQFIQELKYPLAYDFVWLTKSNPHKRDPMKNATIYAHSFLDSSIPMITTGKGENSIV
                     VSRSGAYSEMTYRNGYEEAIRLQTMAQYDGYAKCSTIGNFNLTPGVKIIFNDSKNQFK
                     TEFYVDEVIHELSNNNSVTHLYMFTNATKLETIDPVKVKNEFKSDTTTEESSSSNKQ"""

gp28 = """MNLNLILPLKKVVLPISNKEVSIPKMGLKHYNILKDVKGPDENL
                     KLLIDSICPNLSPAEVDFVSIHLLEFNGKIKSRKEIDGYTYDINDVYVCQRLEFQYQG
                     NTFYFRPPGKFEQFLTVSDMLSKCLLRVNDEVKEINFLEMPAFVLKWANDIFTTLAIP
                     GPNGPITGIGNIIGLFE"""

gp29 = """MKKPQEMQTMRRKVISDNKPTQEAAKSASNTLSGLNDISTKLDD
                     AQAASELIAQTVEEKSNEIIGAIDNVESAVSDTSAGSELIAETVEIGNNINKEIGESL
                     GSKLDKLTSLLEQKIQTAGIQQTGTSLATVESAIPVKVVEDDTAESVGPLLPAPEAVN
                     NDPDADFFPTPQPVEPKQESPEEKQKKEAFNLKLSQALDKLTKTVDFGFKKSISITDK
                     ISSMLFKYTVSAAIEAAKMTAMILAVVVGIDLLMIHFKYWSDKFSKAWDLFSTDFTKF
                     SSETGTWGPLLQSIFDSIDKIKQLWEAGDWGGLTVAIVEGLGKVLFNLGELIQLGMAK
                     LSAAILRVIPGMKDTADEVEGRALENFQNSTGASLNKEDQEKVANYQDKRMNGDLGPI
                     AEGLDKISNWKTRASNWIRGVDNKEALTTDEERAAEEEKLKQLSPEERKNALMKANEA
                     RAAMIRFEKYADSADMSKDSTVKSVEAAYEDLKKRMDDPDLNNSPAVKKELAARFSKI
                     DATYQELKKNQPNAKPETSAKSPEAKQVQVIEKNKAQQAPVQQASPSINNTNNVIKKN
                     TVVHNMTPVTSTTAPGVFDATGVN"""

gp34 = """MAEIKREFRAEDGLDAGGDKIINVALADRTVGTDGVNVDYLIQE
                     NTVQQYDPTRGYLKDFVIIYDNRFWAAINDIPKPAGAFNSGRWRALRTDANWITVSSG
                     SYQLKSGEAISVNTAAGNDITFTLPSSPIDGDTIVLQDIGGKPGVNQVLIVAPVQSIV
                     NFRGEQVRSVLMTHPKSQLVLIFSNRLWQMYVADYSREAIVVTPANTYQAQSNDFIVR
                     RFTSAAPINVKLPRFANHGDIINFVDLDKLNPLYHTIVTTYDETTSVQEVGTHSIEGR
                     TSIDGFLMFDDNEKLWRLFDGDSKARLRIITTNSNIRPNEEVMVFGANNGTTQTIELK
                     LPTNISVGDTVKISMNYMRKGQTVKIKAADEDKIASSVQLLQFPKRSEYPPEAEWVTV
                     QELVFNDETNYVPVLELAYIEDSDGKYWVVQQNVPTVERVDSLNDSTRARLGVIALAT
                     QAQANVDLENSPQKELAITPETLANRTATETRRGIARIATTAQVNQNTTFSFADDIII
                     TPKKLNERTATETRRGVAEIATQQETNAGTDDTTIITPKKLQARQGSESLSGIVTFVS
                     TAGATPASSRELNGTNVYNKNTDNLVVSPKALDQYKATPTQQGAVILAVESEVIAGQS
                     QQGWANAVVTPETLHKKTSTDGRIGLIEIATQSEVNTGTDYTRAVTPKTLNDRRATES
                     LSGIAEIATQVEFDAGVDDTRISTPLKIKTRFNSTDRTSVVALSGLVESGTLWDHYTL
                     NILEANETQRGTLRVATQVEAAAGTLDNVLITPKKLLGTKSTEAQEGVIKVATQSETV
                     TGTSANTAVSPKNLKWIAQSEPTWAATTAIRGFVKTSSGSITFVGNDTVGSTQDLELY
                     EKNSYAVSPYELNRVLANYLPLKAKAADTNLLDGLDSSQFIRRDIAQTVNGSLTLTQQ
                     TNLSAPLVSSSTGEFGGSLAANRTFTIRNTGAPTSIVFEKGPASGANPAQSMSIRVWG
                     NQFGGGSDTTRSTVFEVGDDTSHHFYSQRNKDGNIAFNINGTVMPININASGLMNVNG
                     TATFGRSVTANGEFISKSANAFRAINGDYGFFIRNDASNTYFLLTAAGDQTGGFNGLR
                     PLLINNQSGQITIGEGLIIAKGVTINSGGLTVNSRIRSQGTKTSDLYTRAPTSDTVGF
                     WSIDINDSATYNQFPGYFKMVEKTNEVTGLPYLERGEEVKSPGTLTQFGNTLDSLYQD
                     WITYPTTPEARTTRWTRTWQKTKNSWSSFVQVFDGGNPPQPSDIGALPSDNATMGNLT
                     IRDFLRIGNVRIVPDPVNKTVKFEWVE"""

gp35 = """MEKFMAEFGQGYVQTPFLSESNSVRYKISIAGSCPLSTAGPSYV
                     KFQDNPVGSQTFSAGLHLRVFDPSTGALVDSKSYAFSTSNDTTSAAFVSFMNSLTNNR
                     IVAILTSGKVNFPPEVVSWLRTAGTSAFPSDSILSRFDVSYAAFYTSSKRAIALEHVK
                     LSNRKSTDDYQTILDVVFDSLEDVGATGFPRGTYESVEQFMSAVGGTNDEIARLPTSA
                     AISKLSDYNLIPGDVLYLKAQLYADADLLALGTTNISIRFYNASNGYISSTQAEFTGQ
                     AGSWELKEDYVVVPENAVGFTIYAQRTAQAGQGGMRNLSFSEVSRNGGISKPAEFGVN
                     GIRVNYICESASPPDIMVLPTQASSKTGKVFGQEFREV"""

gp36 = """MADLKVGSTTGGSVIWHQGNFPLNPAGDDVLYKSFKIYSEYNKP
                     QAADNDFVSKANGGTYASKVTFNAGIQVPYAPNIMSPCGIYGGNGDGATFDKANIDIV
                     SWYGVGFKSSFGSTGRTVVINTRNGDINTKGVVSAAGQVRSGAAAPIAANDLTRKDYV
                     DGAINTVTANANSRVLRSGDTMTGNLTAPNFFSQNPASQPSHVPRFDQIVIKDSVQDF
                     GYY"""

gp37 = """MATLKQIQFKRSKIAGTRPAASVLAEGELAINLKDRTIFTKDDS
                     GNIIDLGFAKGGQVDGNVTINGLLRLNGDYVQTGGMTVNGPIGSTDGVTGKIFRSTQG
                     SFYARATNDTSNAHLWFENADGTERGVIYARPQTTTDGEIRLRVRQGTGSTANSEFYF
                     RSINGGEFQANRILASDSLVTKRIAVDTVIHDAKAFGQYDSHSLVNYVYPGTGETNGV
                     NYLRKVRAKSGGTIYHEIVTAQTGLADEVSWWSGDTPVFKLYGIRDDGRMIIRNSLAL
                     GTFTTNFPSSDYGNVGVMGDKYLVLGDTVTGLSYKKTGVFDLVGGGYSVASITPDSFR
                     STRKGIFGRSEDQGATWIMPGTNAALLSVQTQADNNNAGDGQTHIGYNAGGKMNHYFR
                     GTGQMNINTQQGMEINPGILKLVTGSNNVQFYADGTISSIQPIKLDNEIFLTKSNNTA
                     GLKFGAPSQVDGTRTIQWNGGTREGQNKNYVIIKAWGNSFNATGDRSRETVFQVSDSQ
                     GYYFYAHRKAPTGDETIGRIEAQFAGDVYAKGIIANGNFRVVGSSALAGNVTMSNGLF
                     VQGGSSITGQVKIGGTANALRIWNAEYGAIFRRSESNFYIIPTNQNEGESGDIHSSLR
                     PVRIGLNDGMVGLGRDSFIVDQNNALTTINSNSRINANFRMQLGQSAYIDAECTDAVR
                     PAGAGSFASQNNEDVRAPFYMNIDRTDASAYVPILKQRYVQGNGCYSLGTLINNGNFR
                     VHYHGGGDNGSTGPQTADFGWEFIKNGDFISPRDLIAGKVRFDRTGNITGGSGNFANL
                     NSTIESLKTDIMSSYPIGAPIPWPSDSVPAGFALMEGQTFDKSAYPKLAVAYPSGVIP
                     DMRGQTIKGKPSGRAVLSAEADGVKAHSHSASASSTDLGTKTTSSFDYGTKGTNSTGG
                     HTHSGSGSTSTNGEHSHYIEAWNGTGVGGNKMSSYAISYRAGGSNTNAAGNHSHTFSF
                     GTSSAGDHSHSVGIGAHTHTVAIGSHGHTITVNSTGNTENTVKNIAFNYIVRLA"""


gp40 = """MNKDDLDLDLEIIDESPSSEGEEERKERLFNESLKIIKSAMENV
                     IQEIVIKLEDGSTHIVYVTKLDWVDGKVVMDFAVLDQERKAELAPHVEKCITMQLQDA
                     FNKRSKKKFKFF"""

# count 6
gp48 = """MAIVKEITADLIKKSGEKISAGQSTKSEVGTKTYTAQFPTGRAS
                     GNDTTEDFQVTDLYKNGLLFTAYNMSSRDSGSLRSMRSNYSSSSSSILRTARNTISST
                     VSKLSNGLISNNNSGTISKSPIANILLPRSKSDVDTSSHRFNDVQESLISRGGGTATG
                     VLSNIASTAVFGALESITQGIMADNNEQIYTTARSMYGGAENRTKVFTWDLTPRSTED
                     LMAIINIYQYFNYFSYGETGKSQYAAEIKGYLDDWYRSTLIEPLSPEDAAKNKTLFEK
                     MTSSLTNVLVVSNPTVWMVKNFGATSKFDGKTEIFGPCQIQSIRFDKTPNGNFNGLAI
                     APNLPSTFTLEITMREIITLNRASLYAGTF"""

# count 6
gp53 = """MLFTFFDPIEYAAKTVNKNAPTIPMTDIFRNYKDYFKRALAGYR
          LRTYYIKGSPRPEELANAIYGNPQLYWVLLMCNDNYDPYYGWITSQEAAYQASIQKYK
          NVGGDQIVYHVNENGEKFYNLISYDDNPYVWYDKGDKARKYPQYEGALAAVDTYEAAV
          LENEKLRQIKIIAKSDINSFMNDLIRIMEKSYGNDK"""

# count 6
gp54 = """MYSLEEFNNQAINADFQRNNMFSCVFATTPSTKSSSLISSISNF
                     SYNNLGLNSDWLGLTQGDINQGITTLITAGTQKLIRKSGVSKYLIGAMSQRTVQSLLG
                     SFTVGTYLIDFFNMAYNSSGLMIYSVKMPENRLSYETDWNYNSPNIRITGRELDPLVI
                     SFRMDSEACNYRAMQDWVNSVQDPVTGLRALPQDVEADIQVNLHSRNGLPHTAVMFTM
                     HSISVSAPELSYDGDNQITTFDVTFAYRVMQAGAVDRQRALEWLESAAINGIQSVLGN
                     SGGVTGLSNSLSRLSRLGGTAGSISNINTMTGIVNSQSKILGAI"""
# count 6 (temporär)
gp63 = """MQELFNNLMELCKDSQRKFFYSDDVSASGRTYRIFSYNYASYSD
                     WLLPDALECRGIMFEMDGEKPVRIASRPMEKFFNLNENPFTMNIDLNDVDYILTKEDG
                     SLVSTYLDGDEILFKSKGSIKSEQALMANGILMNINHHRLRDRLKELAEDGFTANFEF
                     VAPTNRIVLAYQEMKIILLNVRENETGEYISYDDIYKDATLRPYLVERYEIDSPKWIE
                     EAKNAENIEGYVAVMKDGSHFKIKSDWYVSLHSTKSSLDNPEKLFKTIIDGASDDLKA
                     MYADDEYSYRKIEAFETTYLKYLDRALFLVLDCHNKHCGKDRKTYAMEAQGVAKGAGM
                     DHLFGIIMSLYQGYDSQEKVMCEIEQNFLKNYKKFIPEGY"""

# many
gp67 = """MEGLIEAIKSNDLVAARKLFAEAMAARTIDLIKEEKIAIARNFL
                     IEGEEPEDEDEDEDDEDSDDKDDKKDEDSDEDEDDE"""

# many
gp68 = """MLLIPETHELVLENVEALIPEAQGRFDELSSALNKDDINTIVEN
                     MLDDETDLAVALASINENMPLNEFIVKHVSARGEITRTKDRKTRERNAFQTTGLSKAK
                     RRQIARKATKTKIANPAGQSRAQRKRKKALKRRKALGLS"""

# many
gpalt = """MELITELFDEDTTLPITNLYPKKKIPQIFSVHVDDAIEQPGFRL
                     CTYTSGGDTNRDLKMGDKMMHIVPFTLTAKGSIAKLKGLGPSPINYINSVFTVAMQTM
                     RQYKIDACMLRILKSKTAGQARQIQVIADRLIRSRSGGRYVLLKELWDYDKKYAYILI
                     HRKNVSLEDIPGVPEISTELFTKVESKVGDVYINKDTGAQVTKNEAIAASIAQENDKR
                     SDQAVIVKVKISRRAIAQSQSLESSRFETPMFQKFEASAAELNKPADAPLISDSNELT
                     VISTSGFALENALSSVTAGMAFREASIIPEDKESIINAEIKNKALERLRKESITSIKT
                     LETIASIVDDTLEKYKGAWFERNINKHSHLNQDAANELVQNSWNAIKTKIIRRELRGY
                     ALTAGWSLHPIVENKDSSKYTPAQKRGIREYVGSGYVDINNALLGLYNPDERTSILTA
                     SDIEKAIDNLDSAFKNGERLPKGITLYRSQRMLPSIYEAMVKNRVFYFRNFVSTSLYP
                     NIFGTWMTDSSIGVLPDEKRLSVSIDKTDEGLVNSSDNLVGIGWVITGADKVNVVLPG
                     GSLAPSNEMEVILPRGLMVKVNKITDASYNDGTVKTNNKLIQAEVMTTEELTESVIYD
                     GDHLMETGELVTMTGDIEDRVDFASFVSSNVKQKVESSLGIIASCIDIANMPYKFVQG
                     """

# cirka 120 i centrum av ananasens hexagoner (head outer capsid)
gphoc = """MTFTVDITPKTPTGVIDETKQFTATPSGQTGGGTITYAWSVDNV
                     PQDGAEATFSYVLKGPAGQKTIKVVATNTLSEGGPETAEATTTITVKNKTQTTTLAVT
                     PASPAAGVIGTPVQFTAALASQPDGASATYQWYVDDSQVGGETNSTFSYTPTTSGVKR
                     IKCVAQVTATDYDALSVTSNEVSLTVNKKTMNPQVTLTPPSINVQQDASATFTANVTG
                     APEEAQITYSWKKDSSPVEGSTNVYTVDTSSVGSQTIEVTATVTAADYNPVTVTKTGN
                     VTVTAKVAPEPEGELPYVHPLPHRSSAYIWCGWWVMDEIQKMTEEGKDWKTDDPDSKY
                     YLHRYTLQKMMKDYPEVDVQESRNGYIIHKTALETGIIYTYP"""

# many
gpipi = """MKTFKEFTSTTTPVSTITEATLTSEVIKANKGREGKPMISLVDG
                     EEIKGTVYLGDGWSAKKDGATIVISPAEETALFKAKHISAAHLKIIAKNLL"""

# many
gpipii = """MKTYQEFIAEARVGAGKLEAAVNKKAHSFHDLPDKDRKKLVSLY
                     IDRERILALPGANEGKQAKPLNAVEKKIDNFASKFGMSMDDLQQAAIEAAKAIKDK"""

# many
gpipiii = """MKTYQEFIAEASVVKAKGINKDEWTYRSGNGFDPKTAPIERYLA
                     TKASDFKAFAWEGLRWRTDLNIEVDGLKFAHIEDVVASNLDSEFVKADADLRRWNLKL
                     FSKQKGPKFVPKAGKWVIDNKLAKAVNFAGLEFAKHKSSWKGLDAMAFRKEFADVMTK
                     GGFKAEIDTSKGKFKDANIQYAYAVANAARGNS"""

# cirka 360. ananasens hexagoners kanter (small outer capsid)
gpsoc = """MASTRGYVNIKTFEQKLDGNKKIEGKEISVAFPLYSDVHKISGA
                     HYQTFPSEKAAYSTVYEENQRTEWIAANEDLWKVTG"""

# whisker, 6 st
gpwac = """MTDIVLNDLPFVDGPPAEGQSRISWIKNGEEILGADTQYGSEGS
                     MNRPTVSVLRNVEVLDKNIGILKTSLETANSDIKTIQGILDVSGDIEALAQIGINKKD
                     ISDLKTLTSEHTEILNGTNNTVDSILADIGPFNAEANSVYRTIRNDLLWIKRELGQYT
                     GQDINGLPVVGNPSSGMKHRIINNTDVITSQGIRLSELETKFIESDVGSLTIEVGNLR
                     EELGPKPPSFSQNVYSRLNEIDTKQTTVESDISAIKTSIGYPGNNSIITSVNTNTDNI
                     ASINLELNQSGGIKQRLTVIETSIGSDDIPSSIKGQIKDNTTSIESLNGIVGENTSSG
                     LRANVSWLNQIVGTDSSGGQPSPPGSLLNRVSTIETSVSGLNNAVQNLQVEIGNNSAG
                     IKGQVVALNTLVNGTNPNGSTVEERGLTNSIKANETNIASVTQEVNTAKGNISSLQGD
                     VQALQEAGYIPEAPRDGQAYVRKDGEWVFLSTFLSPA"""

# Antalen tagna från Youtube-videon. De är ungefärliga.
# Behållaren och innehållet är osäkert.
T4 = []
T4.append([gp3,1])
T4.append([gp5,1])
T4.append([gp6,6])
T4.append([gp7,6])
T4.append([gp8,6])
T4.append([gp9,6])
T4.append([gp10,6])
T4.append([gp11,6])
T4.append([gp12,6])

T4.append([gp13,1])
T4.append([gp14,1])
T4.append([gp15,1])
T4.append([gp17,1])

T4.append([gp18,144])
T4.append([gp19,144])

T4.append([gp20,12])  # http://cronodon.com/BioTech/t4_advanced.html
T4.append([gp21,72])  # http://cronodon.com/BioTech/t4_advanced.html
T4.append([gp22,576]) # http://cronodon.com/BioTech/t4_advanced.html
T4.append([gp23,930]) # http://www.pnas.org/content/101/16/6003.full.pdf

T4.append([gp24,55])
T4.append([gp25,6])

T4.append([gp27,1])
T4.append([gp28,1])
T4.append([gp29,1])

# long tail fiber assembly
T4.append([gp34,6])
T4.append([gp35,6])
T4.append([gp36,6])
T4.append([gp37,6])

T4.append([gp40,1])
T4.append([gp48,6])
T4.append([gp53,6])
T4.append([gp54,6])
T4.append([gp63,6])

T4.append([gp67,200])
T4.append([gp68,200])
T4.append([gpalt,200])

T4.append([gphoc,155]) # http://www.pnas.org/content/101/16/6003.full.pdf
T4.append([gpsoc,810]) # http://www.pnas.org/content/101/16/6003.full.pdf

T4.append([gpipi,120])
T4.append([gpipii,120])
T4.append([gpipiii,120])

# whiskers
T4.append([gpwac,6])

gene = fix_gene(gene)

_,rev11 = read_table(table)

assert count_atoms_in_genome(T4,rev11) == [9774901, 23171543, 3621741, 7665463, 743466] # [C,H,N,O,S]
assert count_atoms_in_dna_string(T4genome) == [3314544, 5178004, 1229076, 2705846, 337800]