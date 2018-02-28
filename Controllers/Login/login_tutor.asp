<%
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray,AccountExpiringDate
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    Dim tot, TutorID
    username=lcase(request.form("us"))
    password=lcase(request.form("passwd"))

    query_di_interrogazione="SELECT COUNT(*) as Tot FROM Tutor WHERE IsActive = True AND CheckToLogIn = '"&username&"|"&password&"'"
	recordset.Open query_di_interrogazione,connessione
    tot = recordset("Tot")
    recordset.MoveFirst
    recordset.Close 

    query_di_interrogazione="SELECT TutorID, AccountExpiringDate, AccountType, TrialMode, IsPrivate FROM Tutor WHERE IsActive = True AND CheckToLogIn = '"&username&"|"&password&"'"
	recordset.Open query_di_interrogazione,connessione
    response.Write(query_di_interrogazione)
    TutorID = recordset("TutorID")
    AccountExpiringDate = recordset("AccountExpiringDate")
    AccountType = recordset("AccountType")
    TrialMode = recordset("TrialMode")
    IsPrivate = recordset("IsPrivate")
    recordset.MoveFirst
    recordset.Close 

    query_di_interrogazione="SELECT COUNT(*) AS LessonsNumber FROM Lessons WHERE TutorID = 1 AND Accepted = true"
	recordset.Open query_di_interrogazione,connessione
    Session("LessonsNumber") = recordset("LessonsNumber")
    
    If tot > 0 Then
        Session("Tutor_id") = TutorID
        If IsPrivate Then
            Session("private_logged") = True
        End If
        Session("tutor_logged") = True
        AccountExpiringDate = AccountExpiringDate
        If AccountExpiringDate < date() Then
            Session("ExpiredAccount") = 1
        End If
        Session("AccountType") = AccountType
        Session("TrialMode") = TrialMode
        response.redirect("../../Tutor_Index_edit.asp")
    Else
        response.redirect("/")
    End If

	set recordset=nothing
	set connessione=nothing
%>