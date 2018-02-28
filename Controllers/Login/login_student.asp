<%
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    Dim tot, StudentID, returnurl
    username=lcase(request.form("us"))
    password=lcase(request.form("passwd"))
    returnurl = request.QueryString("returnurl")

    query_di_interrogazione="SELECT COUNT(*) as Tot FROM Student WHERE IsActive = True AND CheckToLogIn = '"&username&"|"&password&"'"
	recordset.Open query_di_interrogazione,connessione
    tot = recordset("Tot")
    recordset.Close 

    query_di_interrogazione="SELECT StudentID FROM Student WHERE IsActive = True AND CheckToLogIn = '"&username&"|"&password&"'"
	recordset.Open query_di_interrogazione,connessione
    StudentID = recordset("StudentID")

    If tot > 0 Then
        Session("student_id") = recordset("StudentID")
        Session("student_logged") = True
        If returnurl <> "" Then
            response.redirect(returnurl)
        Else
            response.redirect("../../Student_Index.asp")
        End If
    Else
        response.redirect("/")
    End If

	set recordset=nothing
	set connessione=nothing
%>