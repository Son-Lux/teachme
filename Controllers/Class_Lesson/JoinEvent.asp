<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Type Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->
<%
    Dim StudentID, Class_LessonsID,TakenSeats,TutorID
    StudentID = Request.Form("StudentID")
    TutorID = Request.Form("TutorID")
    Class_LessonsID = Request.Form("Class_LessonsID")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "INSERT INTO Class_LessonsStudents (StudentID,Class_LessonsID)"
    query_di_interrogazione = query_di_interrogazione + " VALUES ('"&StudentID&"','"&Class_LessonsID&"')"
    recordset.Open query_di_interrogazione,connessione

    query_di_interrogazione = "SELECT TakenSeats, Name FROM Class_Lessons WHERE Class_LessonID = "&Class_LessonsID
    recordset.Open query_di_interrogazione,connessione
    TakenSeats = recordset("TakenSeats")
    TakenSeats = TakenSeats + 1
    class_name = recordset("Name")
    recordset.Close

    query_di_interrogazione = "UPDATE Class_Lessons SET TakenSeats = "&TakenSeats&" WHERE Class_LessonID = "&Class_LessonsID
    recordset.Open query_di_interrogazione,connessione


    query_di_interrogazione = "SELECT Email, Name, Surname From Student WHERE StudentID = "&StudentID
    recordset.Open query_di_interrogazione,connessione
    email = recordset("Email")
    studentName = recordset("Name")&" "&recordset("Surname")
    recordset.Close

    query_di_interrogazione = "SELECT Email From Tutor WHERE TutorID = "&TutorID
    recordset.Open query_di_interrogazione,connessione
    emailtutor = recordset("Email")

	set recordset=nothing
	set connessione=nothing

    DIM corpoMessaggio, numeroCampi, invioA, invioDa, nomeDominio, indirizzoIp, modulo, browserSistemaOperativo
    
    invioA =  email
    invioDa =  "info@teachme.tips"

    nomeDominio 				= Request.ServerVariables("HTTP_HOST")
    indirizzoIp					= Request.ServerVariables("REMOTE_ADDR") 
    modulo						= Request.ServerVariables("HTTP_REFERER")
    browserSistemaOperativo		= Request.ServerVariables("HTTP_USER_AGENT")

    DIM iMsg, Flds, iConf

    Set iMsg = CreateObject("CDO.Message")
    Set iConf = CreateObject("CDO.Configuration")
    Set Flds = iConf.Fields

    Flds(cdoSendUsingMethod) = cdoSendUsingPort
    Flds(cdoSMTPServer) = "localhost" 
    Flds(cdoSMTPServerPort) = 25
    Flds(cdoSMTPAuthenticate) = cdoAnonymous ' 0
    Flds.Update

    With iMsg
       Set .Configuration = iConf
       .To = invioA
       .From = invioDa
       .Sender = invioDa
       .Subject = "Iscrizione ad un Corso " & nomeDominio
       .HTMLBody = "Ciao,<br /> con la presente le confermiamo la sua iscrizione al corso di "&class_name
       .Send
    End With

    'invia anche a tutor
    With iMsg
       Set .Configuration = iConf
       .To = emailtutor
       .From = invioDa
       .Sender = invioDa
       .Subject = "Iscrizione ad un tuo Corso " & nomeDominio
       .HTMLBody = "Ciao,<br /> con la presente ti informiamo che un utente "&studentName&" si è iscritto al tuo corso di "&class_name
       .Send
    End With

    Response.Redirect ("/Tutor_Index.asp?t="&TutorID) 
%>