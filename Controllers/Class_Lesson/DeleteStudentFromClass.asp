<%
    cls = Request.querystring("cls")
    cl = Request.querystring("cl")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "DELETE FROM Class_LessonsStudents WHERE Class_LessonsStudentsID="&cls
    recordset.Open query_di_interrogazione,connessione

    query_di_interrogazione = "UPDATE Class_Lessons SET TakenSeats = TakenSeats - 1 WHERE Class_LessonID ="&cl
    recordset.Open query_di_interrogazione,connessione

	set recordset=nothing
	set connessione=nothing

    Response.Redirect ("/Tutor_Index.asp") 
%>