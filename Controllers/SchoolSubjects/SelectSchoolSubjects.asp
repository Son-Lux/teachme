<%
    ss = Request.Form("ss")
    TutorID = Request.Form("tutor_id")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "INSERT INTO TutorSchoolSubject (SchoolSubjectID,TutorID)"
    query_di_interrogazione = query_di_interrogazione + " VALUES ("&ss&","&TutorID&")"

    'response.Write(query_di_interrogazione) 

	recordset.Open query_di_interrogazione,connessione
    'recordset.Close

	set recordset=nothing
	set connessione=nothing

    If Session("private_logged") Then
        Response.Redirect ("/Private_Index_edit.asp") 
    Else
        Response.Redirect ("/Tutor_Index_edit.asp") 
    End If
%>