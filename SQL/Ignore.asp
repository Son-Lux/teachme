<%
    Dim LessonID, Date, TutorID, StudentID, SchoolSubjectID
    LessonID = Request.querystring("l")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE Lessons SET Ignore = 1 WHERE LessonID = '"&LessonID&"'"
    response.Write(query_di_interrogazione )

    'response.Write(query_di_interrogazione) 

	recordset.Open query_di_interrogazione,connessione
    'recordset.Close

    Response.Redirect("/Tutor_Index.asp")

	set recordset=nothing
	set connessione=nothing
%>