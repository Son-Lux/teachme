<%
    Class_LessonsID = Request.QueryString("c")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE Class_LessonsStudents SET read = 1 WHERE Class_LessonsStudentsID ="&Class_LessonsID
    recordset.Open query_di_interrogazione,connessione

	set recordset=nothing
	set connessione=nothing

    Response.Redirect ("/Student_Index.asp") 
%>