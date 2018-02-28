<!--#include virtual="\sitemaster_top.asp"-->
<%
  If Session("tutor_logged") Then

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database
    student_id = Request.QueryString("s")

    'Ottengo StudentClass che è la classe che frequenta lo studente
    query_di_interrogazione="SELECT * FROM Student WHERE StudentID = " & student_id
	recordset.Open query_di_interrogazione,connessione

%>
<div class="main">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li class="active">Anagrafica Studente</li>
        </ul>
        <h1><%=recordset("Name") %>&nbsp;<%=recordset("Surname") %></h1>
        Indirizzo:&nbsp;<%=recordset("Address") %><br />
        Cellulare:&nbsp;<%=recordset("Mobile") %><br />
        Email:&nbsp;<%=recordset("Email") %><br />
    </div>
</div>
<%
    recordset.Close

	set recordset=nothing
	set connessione=nothing

  Else
%>
<div class="container">
    <h2 class="col-md-12" style="margin-bottom: 20px;">Timeout sessione, effettua il login</h2>
</div>
<%
  End If  
%>
<!--#include virtual="\sitemaster_bottom_alt.html"-->
