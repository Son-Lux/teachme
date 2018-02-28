
<%
    Dim activation_code
    activation_code = Request.QueryString("c")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    query_di_interrogazione = "SELECT COUNT(*) As Count FROM Tutor WHERE IsActive=0 AND Activation = '"& activation_code &"'"
    recordset.Open query_di_interrogazione,connessione

    If recordset("Count") = 1 Then
        recordset.Close
        query_di_interrogazione = "UPDATE Tutor Set IsActive = 1 WHERE IsActive = 0 AND Activation = '"& activation_code &"'"
        recordset.Open query_di_interrogazione,connessione
    %>
        Complimenti, account attivato correttamente.
    <%

    Else
    %>
        Questo account è già stato attivato
    <%
    End If

    set recordset=nothing
	set connessione=nothing
%>
