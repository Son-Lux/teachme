<%
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    Dim tot, privateID
    username=lcase(request.form("us"))
    password=lcase(request.form("passwd"))

    query_di_interrogazione="SELECT COUNT(*) as Tot FROM private WHERE IsActive = True AND CheckToLogIn = '"&username&"|"&password&"'"
	recordset.Open query_di_interrogazione,connessione
    tot = recordset("Tot")
    recordset.Close 

    query_di_interrogazione="SELECT privateID FROM private WHERE IsActive = True AND CheckToLogIn = '"&username&"|"&password&"'"
	recordset.Open query_di_interrogazione,connessione
    privateID = recordset("privateID")

    If tot > 0 Then
        Session("private_id") = recordset("privateID")
        Session("private_logged") = True
        response.redirect("../../private_Index_edit.asp")
    Else
        response.redirect("/")
    End If

	set recordset=nothing
	set connessione=nothing
%>