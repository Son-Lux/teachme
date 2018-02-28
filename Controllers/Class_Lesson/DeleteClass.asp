<%
    c = Request.querystring("c")
    'cls = Request.querystring("cls")
    'cl = Request.querystring("cl")
    If Session("tutor_logged") OR Session("private_logged")  Then

        dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	    nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	    Set connessione=Server.CreateObject("ADODB.Connection")
	    Set recordset=Server.CreateObject ("ADODB.Recordset")
	    connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

        query_di_interrogazione = "DELETE FROM Class_Lessons WHERE Class_LessonID = "&c
        recordset.Open query_di_interrogazione,connessione

        query_di_interrogazione = "DELETE FROM Class_LessonsStudents WHERE Class_LessonsID="&c
        recordset.Open query_di_interrogazione,connessione

        'query_di_interrogazione = "UPDATE Class_Lessons SET TakenSeats = TakenSeats - 1 WHERE Class_LessonID ="&cl
        'recordset.Open query_di_interrogazione,connessione

	    set recordset=nothing
	    set connessione=nothing

    End If

    If Session("private_logged") Then
        Response.Redirect ("/Private_Index_edit.asp") 
    Else
        Response.Redirect ("/Tutor_Index_edit.asp") 
    End If
%>