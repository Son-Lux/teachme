<!--#include file="sitemaster_top.asp"-->
<style>
    .header { margin-bottom: 0; }
</style>
<%
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database
%>
<script type="text/javascript">
    $(function () {
        $(".class_name, .tutor_name, .schoolsubject_name").change(function () {
            $(this).parent("form").find("button").removeAttr("disabled");
        });

        $("#categories").change(function () {
            var id = $(this).find("option:selected").attr("id");
            $("#materia option").each(function (index) {
                if ($(this).attr("id") == id)
                    $(this).show();
                else
                    $(this).hide();
                $("#materia option:first-child").show();
                $("#materia option:first-child").attr("selected", "selected");
            });
        });
    });
</script>

<section class="how-it-works">
    <div class="container">
        <h2 style="text-shadow: 1px 1px 7px #000000;">Cos’è</h2>
        <p>TeachMe è una piattaforma di incontro e di gestione delle prenotazioni tra coloro che sono alla ricerca di servizi o corsi di qualsiasi varietà (Utenti) e coloro che li offrono professionalmente (Tutor).</p>
    </div>
</section>

<section style="padding: 106px 0; overflow: auto;">
    <div class="col-md-4">
        <div>
            <h3>CERCA LEZIONI PRIVATE</h3>
            <%
                query_di_interrogazione="SELECT DISTINCT SchoolSubject.Category as Category, Categories.Name as Name FROM (SchoolSubject INNER JOIN Categories ON Categories.CategoryID = SchoolSubject.Category ) WHERE SchoolSubject.SchoolSubjectID IN (SELECT SchoolSubjectID FROM TutorSchoolSubject)" 
	            recordset.Open query_di_interrogazione,connessione
            %>
            <select class="form-control" name="categories" id="categories">
                <option>Seleziona una categoria...</option>
                <%
                        If Not recordset.EOF Then
                            Do While Not recordset.eof
                %>
                <option id="<%=recordset("Category") %>" value="<%=recordset("Name") %>"><%=recordset("Name") %></option>
                <%
                             recordset.movenext
                            Loop
                        End If
                %>
            </select>
            <%
                recordset.Close
                query_di_interrogazione="SELECT DISTINCT Name, Category FROM SchoolSubject WHERE SchoolSubject.SchoolSubjectID IN (SELECT SchoolSubjectID FROM TutorSchoolSubject)" 
	            recordset.Open query_di_interrogazione,connessione
            %>
            <form action="SchoolSubjectTutor.asp" method="get" id="s_tutor">
                <div class="form-group schoolsubject_name">
                    <select class="form-control" name="materia" id="materia">
                        <option></option>
                        <%
                        If Not recordset.EOF Then
                            Do While Not recordset.eof
                        %>
                        <option id="<%=recordset("Category") %>" value="<%=recordset("Name") %>"><%=recordset("Name") %></option>
                        <%
                             recordset.movenext
                            Loop
                        End If
                        %>
                    </select>
                </div>

                <button type="submit" disabled="disabled" class="btn btn-outline btn-lg btn-block" id="btn-search"><i class="fa fa-search"></i>Cerca tutor</button>
            </form>
        </div>
    </div>

    <div class="col-md-4">
        <%
                recordset.Close
                wordarray=split(Date(),"/")
                query_di_interrogazione="SELECT CategoryID, Name FROM Categories" 
	            recordset.Open query_di_interrogazione,connessione
        %>
        <h3>Ricerca Corsi</h3>
        <form action="Class_Lessons_search.asp" method="get">
            <div class="form-group class_name">
                <select class="form-control" name="cls">
                    <option></option>
                    <%
                        If Not recordset.EOF Then
                            Do While Not recordset.eof
                    %>
                    <option value="<%=recordset("CategoryID") %>"><%=recordset("Name") %></option>
                    <%
                             recordset.movenext
                            Loop
                        End If
                    %>
                </select>
            </div>
            <button type="submit" disabled="disabled" class="btn btn-outline btn-lg btn-block" id="btn-search"><i class="fa fa-search"></i>Cerca Corsi</button>
        </form>

    </div>

    <div class="col-md-4">
        <h2>I Nostri Tutor</h2>
        <%
            recordset.Close
    query_di_interrogazione="SELECT Tutor.TutorID AS TutorID, Tutor.Username AS TutorUsername, Tutor.Address AS TutorAddress, Tutor.Name as TutorName, Tutor.Surname as TutorSurname FROM Tutor WHERE IsPrivate = 0 " 
	recordset.Open query_di_interrogazione,connessione

        %>
        <form action="Tutor_Index.asp" method="get">
            <div class="form-group tutor_name">
                <select class="form-control" name="t">
                    <option></option>
                    <%
        If Not recordset.EOF Then
            old_id = ""
            Do While Not recordset.eof
                If old_id <> recordset("TutorID") Then
                    %>
                    <option value="<%=recordset("TutorID") %>"><%=recordset("TutorName") %>&nbsp;<%=recordset("TutorSurname") %></option>
                    <%
                End If
                old_id = recordset("TutorID")
             recordset.movenext
            Loop
        End If
                    %>
                </select>
            </div>

            <button type="submit" disabled="disabled" class="btn btn-outline btn-lg btn-block" id="btn-search"><i class="fa fa-search"></i>Visita la pagina del Tutor</button>
        </form>

    </div>
</section>



<section class="user">
    <div class="container">
        <h2 style="text-shadow: 1px 1px 7px #000000;">Utente</h2>
        <p style="color:#FFF; text-shadow: 1px 1px 7px #000000;">
            stai cercando una lezione o un corso a cui vorresti partecipare? Con TeachMe vedrai quanto è facile trovare e prenotare ciò che cerchi.<br />
        </p>
        <br />
        <a href="/View/Account/page-login-student.asp" class="btn btn-primary">Accedi</a>
    </div>
</section>

<section class="tutor">
    <div class="container">
        <h2 style="text-shadow: 1px 1px 7px #000000;">Tutor</h2>
        <p style="color:#FFF; text-shadow: 1px 1px 7px #000000;">
            Sei un professionista ed offri lezioni / organizzi corsi ? Con TeachMe risparmierai molto tempo per prenotazioni, cresceranno i tuoi partecipanti ed aumenterà quindi il tuo guadagno.
            <br />
        </p>
        <a href="/View/Account/page-login-tutor.asp" class="btn btn-primary">Accedi</a>
    </div>
</section>

<section class="private">
    <div class="container">
        <h2 style="text-shadow: 1px 1px 7px #000000;">Privato</h2>
        <p>
            Hai programmato un viaggio e cerchi amici con cui ammortizzare i costi ? Con TeachMe potrai proporre a chi conosci qualsiasi avventura che hai in mente e trovare chi è della tua stessa idea.<br />
            <br />
        </p>
        <a href="/View/Account/page-login-private.asp" class="btn btn-primary">Accedi</a>
    </div>
</section>





<!--#include file="sitemaster_bottom.html"-->
