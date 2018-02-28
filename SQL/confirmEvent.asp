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

    query_di_interrogazione = "UPDATE Lessons SET Accepted = 1 WHERE LessonID = '" & LessonID &"'"
	recordset.Open query_di_interrogazione,connessione
    'recordset.Close

    If Session("private_logged") Then
        query_di_interrogazione = "SELECT LessonID, DateStartFormatted, DateEndFormatted, Student.Name+' '+Student.Surname as StudentName, Student.email as StudentEmail, private.Name+' '+private.Surname as TutorName, private.Email as TutorEmail, private.Address as TutorAddress, SchoolSubject.Name As SchoolSubjectName, Student.mobile as StudentPhone, private.mobile as TutorPhone FROM ((Lessons INNER JOIN Student ON Lessons.StudentID = Student.StudentID) INNER JOIN private ON Lessons.PrivateID = private.privateID) INNER JOIN SchoolSubject ON Lessons.SchoolSubjectID = SchoolSubject.SchoolSubjectID WHERE LessonID = '" & LessonID &"'"
        recordset.Open query_di_interrogazione,connessione

        msgData1 = Replace(Replace(Replace(recordset("DateStartFormatted"),"-",""),":","")," ","T")
        msgData2 = Replace(Replace(Replace(recordset("DateEndFormatted"),"-",""),":","")," ","T")
        msgData3 = recordset("TutorAddress")
        icsMSG = "BEGIN:VCALENDAR" & VbCrLf & "VERSION:2.0" & VbCrLf & "PRODID:-//www.marudot.com//iCal Event Maker" & VbCrLf & "X-WR-CALNAME:"&recordset("SchoolSubjectName") & VbCrLf & "CALSCALE:GREGORIAN" & VbCrLf & "BEGIN:VTIMEZONE" & VbCrLf & "TZID:Europe/Berlin" & VbCrLf & "TZURL:http://tzurl.org/zoneinfo-outlook/Europe/Berlin" & VbCrLf & "X-LIC-LOCATION:Europe/Berlin" & VbCrLf & "BEGIN:DAYLIGHT" & VbCrLf & "TZOFFSETFROM:+0100" & VbCrLf & "TZOFFSETTO:+0200" & VbCrLf & "TZNAME:CEST" & VbCrLf & "DTSTART:19700329T020000" & VbCrLf & "RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU" & VbCrLf & "END:DAYLIGHT" & VbCrLf & "BEGIN:STANDARD" & VbCrLf & "TZOFFSETFROM:+0200" & VbCrLf & "TZOFFSETTO:+0100" & VbCrLf & "TZNAME:CET" & VbCrLf & "DTSTART:19701025T030000" & VbCrLf & "RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU" & VbCrLf & "END:STANDARD" & VbCrLf & "END:VTIMEZONE" & VbCrLf & "BEGIN:VEVENT" & VbCrLf & "DTSTAMP:20150501T130907Z" & VbCrLf & "UID:"&msgData1&"T130907Z-1050965495@marudot.com" & VbCrLf & "DTSTART;TZID='Europe/Berlin':"&msgData1&"" & VbCrLf & "DTEND;TZID='Europe/Berlin':"&msgData2&"" & VbCrLf & "SUMMARY: Lezione di "& recordset("SchoolSubjectName") & VbCrLf & "DESCRIPTION:Caro "&recordset("StudentName")&"("&recordset("StudentPhone")&"), recati da "&recordset("TutorName")&" ("&recordset("TutorPhone")&") in "&recordset("TutorAddress")&", per la lezione di "&recordset("SchoolSubjectName") & VbCrLf & "END:VEVENT" & VbCrLf & "END:VCALENDAR"
    Else
        query_di_interrogazione = "SELECT LessonID, DateStartFormatted, DateEndFormatted, Student.Name+' '+Student.Surname as StudentName, Student.email as StudentEmail, Tutor.Name+' '+Tutor.Surname as TutorName, Tutor.Email as TutorEmail, Tutor.Address as TutorAddress, SchoolSubject.Name As SchoolSubjectName, Student.mobile as StudentPhone, Tutor.mobile as TutorPhone FROM ((Lessons INNER JOIN Student ON Lessons.StudentID = Student.StudentID) INNER JOIN Tutor ON Lessons.TutorID = Tutor.TutorID) INNER JOIN SchoolSubject ON Lessons.SchoolSubjectID = SchoolSubject.SchoolSubjectID WHERE LessonID = '" & LessonID &"'"
        recordset.Open query_di_interrogazione,connessione

        msgData1 = Replace(Replace(Replace(recordset("DateStartFormatted"),"-",""),":","")," ","T")
        msgData2 = Replace(Replace(Replace(recordset("DateEndFormatted"),"-",""),":","")," ","T")
        msgData3 = recordset("TutorAddress")
        icsMSG = "BEGIN:VCALENDAR" & VbCrLf & "VERSION:2.0" & VbCrLf & "PRODID:-//www.marudot.com//iCal Event Maker" & VbCrLf & "X-WR-CALNAME:"&recordset("SchoolSubjectName") & VbCrLf & "CALSCALE:GREGORIAN" & VbCrLf & "BEGIN:VTIMEZONE" & VbCrLf & "TZID:Europe/Berlin" & VbCrLf & "TZURL:http://tzurl.org/zoneinfo-outlook/Europe/Berlin" & VbCrLf & "X-LIC-LOCATION:Europe/Berlin" & VbCrLf & "BEGIN:DAYLIGHT" & VbCrLf & "TZOFFSETFROM:+0100" & VbCrLf & "TZOFFSETTO:+0200" & VbCrLf & "TZNAME:CEST" & VbCrLf & "DTSTART:19700329T020000" & VbCrLf & "RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU" & VbCrLf & "END:DAYLIGHT" & VbCrLf & "BEGIN:STANDARD" & VbCrLf & "TZOFFSETFROM:+0200" & VbCrLf & "TZOFFSETTO:+0100" & VbCrLf & "TZNAME:CET" & VbCrLf & "DTSTART:19701025T030000" & VbCrLf & "RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU" & VbCrLf & "END:STANDARD" & VbCrLf & "END:VTIMEZONE" & VbCrLf & "BEGIN:VEVENT" & VbCrLf & "DTSTAMP:20150501T130907Z" & VbCrLf & "UID:"&msgData1&"T130907Z-1050965495@marudot.com" & VbCrLf & "DTSTART;TZID='Europe/Berlin':"&msgData1&"" & VbCrLf & "DTEND;TZID='Europe/Berlin':"&msgData2&"" & VbCrLf & "SUMMARY: Lezione di "& recordset("SchoolSubjectName") & VbCrLf & "DESCRIPTION:Caro "&recordset("StudentName")&"("&recordset("StudentPhone")&"), recati da "&recordset("TutorName")&" ("&recordset("TutorPhone")&") in "&recordset("TutorAddress")&", per la lezione di "&recordset("SchoolSubjectName") & VbCrLf & "END:VEVENT" & VbCrLf & "END:VCALENDAR"
    End If
	

    dim fs,tfile
    set fs=Server.CreateObject("Scripting.FileSystemObject")
    set tfile=fs.CreateTextFile(server.mappath("/")&"\public\"&LessonID&".ics")
    tfile.WriteLine(icsMSG)
    tfile.close
    set tfile=nothing
    set fs=nothing

    DIM corpoMessaggio, numeroCampi, invioA, invioA2, invioDa, nomeDominio, indirizzoIp, modulo, browserSistemaOperativo
    
    invioA2 =  recordset("TutorEmail")
    invioA =  recordset("StudentEmail")


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

    response.Write(server.mappath("/")&"\public\"&LessonID&".ics")

    With iMsg
       Set .Configuration = iConf
       .To = invioA
       .From = invioDa
       .Sender = invioDa
       .Subject = "Lezione TeachMe " & nomeDominio
       .HTMLBody = "Ciao,<br /> non dimenticart della tua lezione TeachMe clicca sull'allegato per aggiungere un promemoria al tuo calendario" 
       .AddAttachment (server.mappath("/")&"\public\"&LessonID&".ics")
       .Send
    End With

    With iMsg
       Set .Configuration = iConf
       .To = invioA2
       .From = invioDa
       .Sender = invioDa
       .Subject = "Lezione TeachMe " & nomeDominio
       .HTMLBody = "Ciao,<br /> non dimenticart della tua lezione TeachMe clicca sull'allegato per aggiungere un promemoria al tuo calendario" 
       .AddAttachment (server.mappath("/")&"\public\"&LessonID&".ics")
       .Send
    End With

    If Session("private_logged") Then
        Response.Redirect ("/Private_Index_edit.asp") 
    Else
        Response.Redirect ("/Tutor_Index_edit.asp") 
    End If

	set recordset=nothing
	set connessione=nothing
%>