För att försäkra sig om att rösterna sparas korrekt, kan man tänka sig att skicka transaktioner till en databas. En transaktion består av ett personnummer samt själva rösten. I databasen bryts kopplingen mellan personnummer och röst. Tabellen Personer ökas med ett Personnummer. Tabellen Röster ökas med en Röst. Båda tilläggen måste lyckas. Den röstande underrättas direkt om rösten sparats eller ej. Enda anledningen till att transaktionen misslyckas är att den Röstande redan röstat. Ska man kunna ändra sin röst måste man tyvärr kunna associera Personnummer med Röst, vilket är ett hot mot valhemligheten. Förtidsröstning kan fortfarande ske, men den Röstande måste uppge om den vill kunna ångra sig eller ej.

Efter valet skickas ett meddelande ut till alla som röstat, att de röstat. Dessutom ska den Röstande kunna gå in och se att just den valsedel man lämnat in, räknats. Detta går att genomföra om man skapar ett unikt nummer för varje valsedel, typ github.

Krypteringen av valsedlar görs på en oberoende server. Denna innehåller en nyckel, AES-256, som är hemlig tills valet är över. Lämpligen hanteras den enbart av Valobservatörer. Ingen människa behöver känna till den, förrän alla vallokaler stängt.

Viktigt är att loggfilen förstörs snarast efter valet, eftersom den innehåller kopplingen mellan Röstande och Röst. Detta sker lämpligen efter att pappersrösterna räknats och antalen befunnits stämma.

Röstande = personnummer, tio tecken, krypterat.

Röst = 
	Riksdag
		Parti/Person * 5 
	Landsting
		Parti/Person * 5
	Kommun
		Parti/Person * 5

Varje Parti/Person lagras i tre bytes.
Saltning består av tre bytes.
Totalt består Rösten av 45 + 3 = 48 bytes, krypterat.

Personnummer och Röst krypteras för sig på olika servrar. Detta för att förbättra valhemligheten.

# Hur hindra att falska röster tillkommer?

Eftersom man känner till alla röstberättigades personnummer, kan fusk bara omfatta de personnummer vars ägare ej röstat. Dessa uppgår normalt till cirka 15%.

# Hur hindra att röster försvinner?

Genom att spara krypterade personnummer per parti och erbjuda en tjänst som ger partierna möjlighet att kontrollera att ett visst personnummer finns med, kan partierna genom egna stickprov bland medlemmar, kontrollera att rösterna räknats. Dessa medlemsregister är normalt hemliga. 

