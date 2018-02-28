<!--#include file="sitemaster_top.asp"-->
<%
  If Session("tutor_id") <> "" Then
%>
<div class="main">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/Student_Index.asp">Scelta Materia</a></li>
            <li class="active">Lezioni Comprate</li>
        </ul>
        <h1>Storico Lezioni</h1>
        <%
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    'Ottengo le lezioni da pagare
    query_di_interrogazione = "SELECT LessonID, Accepted, DateStartFormatted, DateEndFormatted, SchoolSubject.Name as SchoolSubjectName, Price * DateDiff ('n', DateStartFormatted, DateEndFormatted)/60 as StudentCreditToScale, Tutor.Name as TutorName, Tutor.Surname as TutorSurname FROM (Lessons INNER JOIN SchoolSubject ON Lessons.SchoolSubjectID = SchoolSubject.SchoolSubjectID) INNER JOIN Tutor ON Tutor.TutorID = Lessons.TutorID WHERE Lessons.TutorID =" & Session("tutor_id") & " ORDER BY DateStartFormatted DESC"
	recordset.Open query_di_interrogazione,connessione

        %>
        <div class="table-responsive">
            <table id="cart">
                <tr>
                    <th></th>
                    <th>Materia</th>
                    <th>Data</th>
                    <th>Prezzo</th>
                    <th>Stato</th>
                </tr>
                <%
        Dim Totale
        If Not recordset.EOF Then
            Do While Not recordset.eof
            Totale = Totale + recordset("StudentCreditToScale")
            Accepted = recordset("Accepted")
                %>
                <tr>
                    <%If Accepted Then %>
                    <td></td>
                    <%Else %>
                    <td></td>
                    <%End If %>
                    <td><%=recordset("SchoolSubjectName") %> con <%=recordset("TutorName") %>&nbsp;<%=recordset("TutorSurname") %></td>
                    <td><%=recordset("DateStartFormatted") %></td>
                    <td><%=recordset("StudentCreditToScale") %>&euro;</td>
                    <%If Accepted Then %>
                    <td>Confermato</td>
                    <%Else %>
                    <td>In attesa di conferma</td>
                    <%End If %>
                </tr>
                <%
             recordset.movenext
            Loop
        End If
                %>
            </table>
        </div>



        <%
    recordset.close

	set recordset=nothing
	set connessione=nothing
        %>
        <%
  Else
        %>
        <div class="container">
            <h2 class="col-md-12" style="margin-bottom: 20px;">Timeout sessione, effettua il login</h2>
        </div>
        <%
  End If  
        %>
    </div>
</div>
<!--#include file="sitemaster_bottom.html"-->
