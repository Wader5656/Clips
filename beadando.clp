 (deffacts init
	(book 1)
	(book 2)
	(book 3)
	(book 4)
	(book 5)
	(cim DP D DB HL ME)

	)
	
	; Cím | Kiadó | Kiadási év | ár
	;David Parittyaja(DP) Diadal(D) Dorgicsi Borok(DB) Hideg Lipcseben (HL) Mokas Eszkozok(ME)
	;1780 ehny, 1804 enyn, 1832 enyhk, 1860 enyh, 1910 ekt
	

	(defrule solve
	; 1. A Dörgicsei borok (DB) az IC kiadónál jelent meg anno, s 50 ezer vagy 130 ezer forintért vette meg valaki.
		(book ?DB&1)
		(book ?IC&?DB&1)
		(book ?otvene)
		(book ?szazharmince&~?otvene)
		(test (or(= ?DB ?otvene) (= ?DB ?szazharmince)))
	
	; 2. Az 1860-ban megjelent Dávid Parittyája (DP) című albumért, ami nem a PFC kiadónál jelent meg, nem 50 ezer forintot fizettek. 
		(book ?DP&2&~1&~?DB)
		(book ?enyh&?DP&~?DB)
		(book ?PFC&~?DP)
		(book ?PFC&~?IC)
		(book ?enyh&~?otvene&~?PFC)
		(book ?DP&~?otvene)
	
	; 3. A diadal című (D) regényért (amit nem 1780-ban adtak ki) 210 ezer forintot fizetett egy antikvár-könyv-gyűjtő.
		(book ?D&3&~1&~2&~?DP&~?DB)
		(book ?ketszaztize&?D&~?otvene&~?szazharmince)
		(book ?ehny&~?D&~?ketszaztize&~?enyh&~?DP)
		
	; 4. Az 1780-as könyv magasabb áron talált új gazdára, mint a Hideg lipcsében(HL).
		(book ?HL&4&~1&~2&~3&~?DB&~?DP&~?D)
		(book ?szazhatvane&~?ketszaztize&~?szazharmince&~?otvene)
		(book ?nyolcvane &~?szazharmince&~?szazhatvane&~?otvene&~?ketszaztize)
		(book ?ehny&~?enyh&~?ketszaztize&~?otvene)
		(or (test(and(= ?ehny ?szazhatvane) (= ?HL ?szazharmince)))
			(test(and(= ?ehny ?szazhatvane) (= ?HL ?nyolcvane)))
			(test(and(= ?ehny ?szazhatvane) (= ?HL ?otvene)))
			(test(and(= ?ehny ?szazharmince) (= ?HL ?nyolcvane)))
			(test(and(= ?ehny ?szazharmince) (= ?HL ?otvene)))
			(test(and(= ?ehny ?nyolcvane) (= ?HL ?otvene)))
		)
	
	; 5. A Mókás eszközökért (ME) nem 160 ezer, az 1832-es kiadású könyvért pedig nem 50 ezer és nem 80 ezer forintot fizettek.
		(book ?ME&5&~1&~2&~3&~4&~?DP&~?DB&~?D&~?HL)
		(book ?ME&~?szazhatvane)
		(book ?enyhk&~?ehny&~?enyh&~?otvene&~?nyolcvane)
	; 6. A 80 ezer forintos könyv az FE kiadó gondozásában jelent meg.
		(book ?nyolcvane&~?otvene&~?szazharmince&~?szazhatvane&~?ketszaztize)
		(book ?FE&?nyolcvane&~?IC&~?PFC)
	; 7. A 130 ezerért elkelt könyvritkaság 1804-ben jelent meg.
		(book ?szazharmince&~?otvene&~?nyolcvane&~?szazhatvane&~?ketszaztize)
		(book ?enyn&?szazharmince&~?enyh&~?enyhk&~?ehny)
	; 8. A "legújabb", 1910-ben megjelent könyvet az SBA kiadó jelentette meg.
		(book ?ekt&~?ehny&~?enyh&~?enyhk&~?enyn)
		(book ?SBA&?ekt&~?FE&~?IC&~?PFC)
	; 9. Az RB kiadónak egy a 19. században megjelent könyv került kalapács alá.
		(book ?RB&~?SBA&~?PFC&~?IC&~?FE)
		(book ?enyn&~?enyhk&~?enyh)
		(test (or(= ?RB ?enyn) (= ?RB ?enyhk) (= ?RB ?enyh)))


	
	=>
	(assert (solution
	DavidParittyaja ?DB Diadal ?D DorgicseiBorok ?DB HidegLipcseben ?HL MokasEszkozok ?ME
	FE ?FE IC ?IC PFC ?PFC RB ?RB SBA ?SBA
	ehny ?ehny enyn ?enyn enyhk ?enyhk enyh ?enyh ekt ?ekt
	otvenezer ?otvene nyolcvanezer ?nyolcvane szazharmincezer ?szazharmince szazhatvanezer ?szazhatvane ketszaztizezer ?ketszaztize
    
	(format t "-------------------------------------------------------------------------------------------%n")
	(printout t
		"Cim: "crlf"| "David Parittyaja: ?DP" | "Diadal: ?D" | "Dorgicsei Borok: ?DB" | "Hideg Lipcseben: ?HL" | "Mokas Eszkozok: ?ME" | " crlf)
	(printout t
		"Kiado:"crlf" | "FE: ?FE" | "IC: ?IC" | "PFC: ?PFC" | "RB: ?RB" | "SBA: ?SBA" | " crlf)
	(printout t
		"Kiadasi ev:" crlf" | "1780: ?ehny" | "1804: ?enyn" | "1832: ?enyhk" | "1860: ?enyh" | "1910: ?ekt" | " crlf)		
	(printout t
		"Ar:" crlf "| "50e: ?otvene" | "80e: ?nyolcvane" | "130e: ?szazharmince" | "160e: ?szazhatvane" | "210e: ?ketszaztize" | " crlf)
	))
	)	
	
	
	
	
