<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Type Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->
<%
    Dim LessonID
    LessonID = Request.QueryString("l")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database


    query_di_interrogazione = "SELECT Student.Email, DateStartFormatted FROM (Lessons INNER JOIN Student ON Lessons.StudentID = Student.StudentID) WHERE LessonID = '" & LessonID &"'"
    recordset.Open query_di_interrogazione,connessione
    email = recordset("email")
    DateStartFormatted = recordset("DateStartFormatted")

    recordset.Close
    query_di_interrogazione = "DELETE FROM Lessons WHERE LessonID = '" & LessonID &"'"
	recordset.Open query_di_interrogazione,connessione

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
       .Subject = "Lezione Eliminata" & nomeDominio
       .HTMLBody = "Ciao, il tutor ha deciso di rifiutare la tua richiesta di lezione del "& DateStartFormatted  
       .Send
    End With

    Response.Redirect ("../orders.asp?s="&Session("student_id")) 

	set recordset=nothing
	set connessione=nothing
%>