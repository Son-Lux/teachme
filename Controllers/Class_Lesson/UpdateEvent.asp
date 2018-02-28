<%
    class_name = Request.Form("class_name")
    class_menber_number = Request.Form("class_menber_number")
    class_datestart = Request.Form("class_datestart")
    class_description = Request.Form("class_description")
    class_place = Request.Form("class_place")
    class_price = Request.Form("class_price")
    Class_LessonsID = Request.Form("Class_LessonsID")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE Class_Lessons SET DateStart='"&class_datestart&"',DateForCheck='"&Replace(Replace(Replace(class_datestart,"T",""),":",""),"-","")&"',Name='"&class_name&"',MenberNumber='"&class_menber_number&"',Description='"&class_description&"', Place = '"&class_place&"', Price = '"&class_price&"' WHERE Class_LessonID ="&Class_LessonsID
    recordset.Open query_di_interrogazione,connessione

	set recordset=nothing
	set connessione=nothing

    If Session("private_logged") Then
        Response.Redirect ("/Private_Index_edit.asp") 
    Else
        Response.Redirect ("/Tutor_Index_edit.asp") 
    End If
    
%>