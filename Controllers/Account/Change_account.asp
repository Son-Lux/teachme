<%
  Dim valore
    valore = Request.Form("change_account")
    tutor_id = Request.Form("tutor_id")
    pageUrl = Request.Form("pageUrl")
    facebookpage = Request.Form("facebook_url")
    description = Request.Form("description")
    url = Request.Form("url")
    description = Replace(description,"'","&apos;")

    paymentmethod_cash = Request.Form("paymentmethod_cash")
    If paymentmethod_cash = "on" Then
        paymentmethod_cash = 1
    Else
        paymentmethod_cash = 0
    End If
    paymentmethod_creditcard = Request.Form("paymentmethod_creditcard")
    If paymentmethod_creditcard = "on" Then
        paymentmethod_creditcard = 1
    Else
        paymentmethod_creditcard = 0
    End If
    paymentmethod_bank = Request.Form("paymentmethod_bank")
    If paymentmethod_bank = "on" Then
        paymentmethod_bank = 1
    Else
        paymentmethod_bank = 0
    End If
    
    search_availability = Request.Form("search_availability")
    If search_availability = "on" Then
        search_availability = 1
    Else
        search_availability = 0
    End If

    not_avaliable_days = ""
    monday = Request.Form("monday")
    if monday <> "" Then
        not_avaliable_days = not_avaliable_days&"1-"
    End If
    tuesday = Request.Form("tuesday")
    if tuesday <> "" Then
        not_avaliable_days = not_avaliable_days&"2-"
    End If
    wednesday = Request.Form("wednesday")
    if tuesday <> "" Then
        not_avaliable_days = not_avaliable_days&"3-"
    End If
    thursday = Request.Form("thursday")
    if thursday <> "" Then
        not_avaliable_days = not_avaliable_days&"4-"
    End If
    friday = Request.Form("friday")
    if friday <> "" Then
        not_avaliable_days = not_avaliable_days&"5-"
    End If
    satursay = Request.Form("satursay")
    if satursay <> "" Then
        not_avaliable_days = not_avaliable_days&"6-"
    End If
    sunday = Request.Form("sunday")
    if sunday <> "" Then
        not_avaliable_days = not_avaliable_days&"0-"
    End If

    not_avaliable_days = Replace(not_avaliable_days,"-",",")
    if Len(not_avaliable_days) > 0 Then 
        not_avaliable_days = Mid(not_avaliable_days,1,Len(not_avaliable_days)-1)
    end if

    'response.Write(not_avaliable_days)

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "UPDATE Tutor SET AccountType ='"& valore &"', IsPrivate = "&search_availability&", pageUrl = '"&pageUrl&"', facebookpage='"&facebookpage&"', url = '"&url&"', Not_avaliable_days = '"&not_avaliable_days&"', description = '"&description&"', paymentmethod_cash = "&paymentmethod_cash&", paymentmethod_creditcard = "&paymentmethod_creditcard&", paymentmethod_bank = "&paymentmethod_bank&" WHERE TutorId = "& tutor_id
    recordset.Open query_di_interrogazione,connessione

    set recordset=nothing
	set connessione=nothing

    'DIM corpoMessaggio, numeroCampi, invioA, invioDa, nomeDominio, indirizzoIp, modulo, browserSistemaOperativo
    
    'invioA =  "info@teachme.network"
    'invioDa =  "info@teachme.network"

    'nomeDominio 				= Request.ServerVariables("HTTP_HOST")
    'indirizzoIp					= Request.ServerVariables("REMOTE_ADDR") 
    'modulo						= Request.ServerVariables("HTTP_REFERER")
    'browserSistemaOperativo		= Request.ServerVariables("HTTP_USER_AGENT")

    'DIM iMsg, Flds, iConf

    'Set iMsg = CreateObject("CDO.Message")
    'Set iConf = CreateObject("CDO.Configuration")
    'Set Flds = iConf.Fields

    'Flds(cdoSendUsingMethod) = cdoSendUsingPort
    'Flds(cdoSMTPServer) = "smtp.aruba.it" 
    'Flds(cdoSMTPServerPort) = 25
    'Flds(cdoSMTPAuthenticate) = cdoAnonymous ' 0
    'Flds.Update

    'With iMsg
       'Set .Configuration = iConf
       '.To = invioA
       '.From = invioDa
       '.Sender = invioDa
       '.Subject = "Cambio Url Pagina Privata"
       '.HTMLBody = "L'utente con ID '"&  tutor_id & "' ha cambiato l'url della sua pagina privata in: "&pageUrl
       '.Send
    'End With

    response.redirect("/Tutor_Index_edit.asp")



%>