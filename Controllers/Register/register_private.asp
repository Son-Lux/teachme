<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Type Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->
<%
    Dim LessonID, Date, privateID, StudentID, SchoolSubjectID
    name = Request.Form("name")
    surname = Request.Form("surname")
    age = Request.Form("age")
    email = Request.Form("email")
    address = Request.Form("pac-input")
    password = Request.Form("password")
    coord = split(Request.Form("coord"),",")
    indirizzo = Request.Form("indirizzo")
    p_iva = Request.Form("p_iva")
    cf = Request.Form("cf")
    mobile = Request.Form("mobile")
    pageUrl = Request.Form("pageUrl")
    account_type = Request.Form("change_account")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "SELECT COUNT(*) as Count FROM private WHERE Email = '"& email &"'"
    recordset.Open query_di_interrogazione,connessione
    

    If recordset("Count")+0 > 0 Then
    %>
        Email gi&agrave; inserita, riprova
    <%
    Else
    
    recordset.Close
    activation = Replace(Replace(Replace(Now(),"/",""),":","")," ","")
    query_di_interrogazione = "INSERT INTO private (Name,Surname,Email,Address,Lat,Lon,Username,Password,CheckToLogIn,Activation,p_iva,cf,mobile,pageUrl,AccountType,IsPrivate)"
    query_di_interrogazione = query_di_interrogazione + " VALUES ('"&name&"','"&surname&"','"&email&"','"&address&"','"&coord(0)&"','"&coord(1)&"','"&email&"','"&password&"','"&email&"|"&password&"','"&activation&"','"&p_iva&"','"&cf&"','"&mobile&"','"&pageUrl&"','"&account_type&"',1)"
        'response.Write(query_di_interrogazione)

	recordset.Open query_di_interrogazione,connessione
    'recordset.Close

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
       .Subject = "Registrazione private " & nomeDominio
       .HTMLBody = "Ciao,<br /> Benvenuto su TeachMe, clicca <a href='http://teachme.tips/Controllers/Register/activate_private_account.asp?c="&activation&"'>qui</a> per attivare il tuo account" 
       .Send
    End With

    response.redirect("../../check_activation_mail.asp")
    End If
    %>