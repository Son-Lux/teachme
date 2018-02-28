<%
    Dim LessonID, Date, TutorID, StudentID, SchoolSubjectID
    class_name = Request.Form("class_name")
    class_menber_number = Request.Form("class_menber_number")
    class_datestart = Request.Form("class_datestart")
    class_dateend = Request.Form("class_dateend")
    class_description = Request.Form("class_description")
    class_place = Request.Form("class_place")
    class_price = Request.Form("class_price")
    TutorID = Request.Form("tutor_id")
    PrivateID = Request.Form("private_id")
    cls = Request.Form("cls")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    If PrivateID <> "" Then
        query_di_interrogazione = "INSERT INTO Class_Lessons (DateStart,DateForCheck,DateEnd,Name,MenberNumber,Description,PrivateID,Place,Price,CategoryID)"
        query_di_interrogazione = query_di_interrogazione + " VALUES ('"&class_datestart&"','"&Replace(Replace(Replace(class_datestart,"T",""),":",""),"-","")&"','"&class_dateend&"','"&class_name&"',"&class_menber_number&",'"&class_description&"','"&PrivateID&"','"&class_place&"','"&class_price&"','"&cls&"')"
    Else
        query_di_interrogazione = "INSERT INTO Class_Lessons (DateStart,DateForCheck,DateEnd,Name,MenberNumber,Description,TutorID,Place,Price,CategoryID)"
        query_di_interrogazione = query_di_interrogazione + " VALUES ('"&class_datestart&"','"&Replace(Replace(Replace(class_datestart,"T",""),":",""),"-","")&"','"&class_dateend&"','"&class_name&"',"&class_menber_number&",'"&class_description&"','"&TutorID&"','"&class_place&"','"&class_price&"','"&cls&"')"
    End If
    
    

    response.Write(query_di_interrogazione) 

	recordset.Open query_di_interrogazione,connessione
    'recordset.Close

	set recordset=nothing
	set connessione=nothing

    If PrivateID <> "" Then
    Response.Redirect ("/Private_Index_edit.asp") 
    Else
    Response.Redirect ("/Tutor_Index_edit.asp") 
    End If
    
%>