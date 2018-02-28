<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Type Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->
<%
    Dim email
    email = Request.Form("email")

    if email <> "" then
        
        dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	    nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	    Set connessione=Server.CreateObject("ADODB.Connection")
	    Set recordset=Server.CreateObject ("ADODB.Recordset")
	    connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

        query_di_interrogazione = "SELECT Password FROM Student WHERE email = '"&email&"' UNION SELECT Password FROM Tutor WHERE email = '"&email&"'"
        recordset.Open query_di_interrogazione,connessione
        
        password = ""
        If Not recordset.EOF Then
            password = recordset("Password")
        End If
        
       
        if password <> "" then
            DIM corpoMessaggio, numeroCampi, invioA, invioDa, nomeDominio, indirizzoIp, modulo, browserSistemaOperativo
    
            invioA =  email
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
               .Subject = "Recupero Password"
               .HTMLBody = "Recupero password per l'utente '"& email &"', password: '"& password &"'"
               .Send
            End With
        else
            response.redirect("/forgotton-password-error.asp")
        end if

    else
        response.redirect("/forgotton-password-error.asp")
    end if

%>