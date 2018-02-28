<%
    tutor_id = Session("Tutor_id")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE Tutor SET AccountExpiringDate = '"&DateAdd("m", 1, Date)&"' WHERE TutorId = "& tutor_id
    recordset.Open query_di_interrogazione,connessione

    set recordset=nothing
	set connessione=nothing

    Session("ExpiredAccount") = 0
    response.redirect("/")
    
%>