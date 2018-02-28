<%
    ss_name = Request.Form("ss_name")
    ss_level = Request.Form("ss_level")
    ss_price = Request.Form("ss_price")
    SchoolSubjectID = Request.Form("SchoolSubjectID")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE SchoolSubject SET Name ='"&ss_name&"', Price="&ss_price&", ClassId="&ss_level&" WHERE SchoolSubjectID = "&SchoolSubjectID
    recordset.Open query_di_interrogazione,connessione

	set recordset=nothing
	set connessione=nothing

    If Session("private_logged") Then
        Response.Redirect ("/Private_Index_edit.asp") 
    Else
        Response.Redirect ("/Tutor_Index_edit.asp") 
    End If
%>