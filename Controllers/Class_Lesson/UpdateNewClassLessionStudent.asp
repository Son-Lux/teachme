<%
    Class_LessonsID = Request.QueryString("t")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE Class_LessonsStudents SET IsNew = 0 WHERE Class_LessonsStudentsID ="&Class_LessonsID
    response.Write(query_di_interrogazione)
    recordset.Open query_di_interrogazione,connessione

	set recordset=nothing
	set connessione=nothing

    Response.Redirect ("/Tutor_Index.asp") 
%>