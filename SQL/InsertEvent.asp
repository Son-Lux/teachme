<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Type Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->
<%
    Dim LessonID, Date, TutorID, StudentID, SchoolSubjectID
    LessonID = Request.Form("LessonId")
    DateStart = Request.Form("DateStart")
    DateEnd = Request.Form("DateEnd")
    TutorID = Request.Form("TutorID")
    PrivateID = Request.Form("PrivateID")
    StudentID = Request.Form("StudentID")
    SchoolSubjectID = Request.Form("SchoolSubjectID")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    If PrivateID = "" Then
        query_di_interrogazione = "SELECT Name+' '+Surname as TutorName, Email FROM Tutor WHERE TutorID = "&TutorID
        recordset.Open query_di_interrogazione,connessione
        TutorName = recordset("TutorName")
        TutorEmail = recordset("Email")
        recordset.Close

        query_di_interrogazione = "INSERT INTO Lessons (LessonID,DateStart,DateStartFormatted,DateEnd,DateEndFormatted,TutorID,StudentID,SchoolSubjectID)"
        query_di_interrogazione = query_di_interrogazione + " VALUES ("&LessonID&",'"&DateStart&"','"&Replace(DateStart,"T"," ")&"','"&DateEnd&"','"&Replace(DateEnd,"T"," ")&"',"&TutorID&","&StudentID&","&SchoolSubjectID&")"
    Else
        query_di_interrogazione = "SELECT Email FROM Private WHERE PrivateID = "&PrivateID
        recordset.Open query_di_interrogazione,connessione
        PrivateEmail = recordset("Email")
        recordset.Close

        query_di_interrogazione = "INSERT INTO Lessons (LessonID,DateStart,DateStartFormatted,DateEnd,DateEndFormatted,PrivateID,StudentID,SchoolSubjectID)"
        query_di_interrogazione = query_di_interrogazione + " VALUES ("&LessonID&",'"&DateStart&"','"&Replace(DateStart,"T"," ")&"','"&DateEnd&"','"&Replace(DateEnd,"T"," ")&"',"&PrivateID&","&StudentID&","&SchoolSubjectID&")"
    End If
  
    
    recordset.Open query_di_interrogazione,connessione
    

    DIM corpoMessaggio, numeroCampi, invioA, invioDa, nomeDominio, indirizzoIp, modulo, browserSistemaOperativo
    
    If PrivateID = "" Then
        invioA =  TutorEmail
    Else
        invioA =  PrivateEmail
    End If        

            invioDa =  "support@teachme.tips"

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
               .Subject = "Prenotazione Lezione"
               .HTMLBody = "Ciao,<br /> qualcuno ha prenotato una tua lezione, loggati per confermarla."
               .Send
            End With

'            invioA =  StudentEmail

 '           With iMsg
  '             Set .Configuration = iConf
   '            .To = invioA
    '           .From = invioDa
     '          .Sender = invioDa
      '         .Subject = "Prenotazione Lezione"
       '        .HTMLBody = "Ciao,<br /> hai prenotato una lezione su Teachmen."
        '       .Send
         '   End With

	set recordset=nothing
	set connessione=nothing
%>