<%
    ss_name = Request.Form("ss_name")
    ss_level = Request.Form("ss_level")
    ss_price = Request.Form("ss_price")
    ss_category = Request.Form("ss_category")
    TutorID = Request.Form("TutorID")
    privateID = Request.Form("privateID")
    Dim maxID 

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "SELECT MAX(SchoolSubjectID) as maxID FROM SchoolSubject"
    recordset.Open query_di_interrogazione,connessione

    maxID = recordset("maxID")+1
    recordset.Close

    query_di_interrogazione = "INSERT INTO SchoolSubject (SchoolSubjectID,Name,Price,ClassId,Category)"
    query_di_interrogazione = query_di_interrogazione + " VALUES ("&maxID&",'"&ss_name&"',"&ss_price&","&ss_level&","&ss_category&")"
    response.Write(query_di_interrogazione)
    recordset.Open query_di_interrogazione,connessione

    If privateID <> "" Then
        query_di_interrogazione = "INSERT INTO PrivateSchoolSubject (SchoolSubjectID,PrivateID)"
        query_di_interrogazione = query_di_interrogazione + " VALUES ('"&maxID&"',"&PrivateID&")"
    Else
        query_di_interrogazione = "INSERT INTO TutorSchoolSubject (SchoolSubjectID,TutorID)"
        query_di_interrogazione = query_di_interrogazione + " VALUES ('"&maxID&"',"&TutorID&")"
    End If
    
    recordset.Open query_di_interrogazione,connessione

	set recordset=nothing
	set connessione=nothing

    If Session("private_logged") Then
        Response.Redirect ("/Private_Index_edit.asp") 
    Else
        Response.Redirect ("/Tutor_Index_edit.asp") 
    End If
%>