<!--#include file="sitemaster_top.asp"-->
<%
  If Session("student_logged") Then
%>
<script type="text/javascript">
    $(function(){
        $(".class_name, .tutor_name, .schoolsubject_name").change(function() {
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
<div class="main">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li class="active">Agenda</li>
        </ul>
        <h1>Agenda</h1>
        <%
            dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	        nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	        Set connessione=Server.CreateObject("ADODB.Connection")
	        Set recordset=Server.CreateObject ("ADODB.Recordset")
	        connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

            'Ottengo StudentClass che è la classe che frequenta lo studente
    query_di_interrogazione="SELECT ClassID, Lat, Lon FROM Student WHERE StudentID = " & Session("student_id")
	recordset.Open query_di_interrogazione,connessione
    StudentClass = recordset("ClassID")
    StudentLat = recordset("Lat")
    StudentLon = recordset("Lon")
    recordset.Close
           
        %>
        <section style="padding: 48px 0px; overflow: auto;">
            <div class="col-md-4">
                <div>
                    <h3>CERCA LEZIONI PRIVATE</h3>
                    <%
                query_di_interrogazione="SELECT DISTINCT SchoolSubject.Category as Category, LessonsCategories.Name as Name FROM (SchoolSubject INNER JOIN LessonsCategories ON LessonsCategories.CategoryID = SchoolSubject.Category ) WHERE SchoolSubject.SchoolSubjectID IN (SELECT SchoolSubjectID FROM TutorSchoolSubject)" 
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
                query_di_interrogazione="SELECT DISTINCT SchoolSubject.Name, Category, Class.ClassId as ClassId, Class.Name as ClassName FROM (SchoolSubject INNER JOIN Class ON Class.ClassID = SchoolSubject.ClassID) WHERE SchoolSubject.SchoolSubjectID IN (SELECT SchoolSubjectID FROM TutorSchoolSubject)" 
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
                                <option id="<%=recordset("Category") %>" value="<%=recordset("Name") %>|<%=recordset("ClassId") %>"><%=recordset("Name") %> (<%=recordset("ClassName") %>)</option>
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
    query_di_interrogazione="SELECT Tutor.TutorID AS TutorID, Tutor.Username AS TutorUsername, Tutor.Address AS TutorAddress, Tutor.Name as TutorName, Tutor.Surname as TutorSurname FROM Tutor WHERE IsPrivate = false " 
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

        <%
  Else
        %>
        <div class="container">
            <h2 class="col-md-12" style="margin-bottom: 20px;">Timeout sessione, effettua il login</h2>
        </div>
        <%
  End If  
        %>

        <%
            recordset.Close
            query_di_interrogazione="SELECT Name, read, Class_LessonsStudentsID FROM (Class_LessonsStudents INNER JOIN Class_Lessons ON Class_Lessons.Class_LessonID = Class_LessonsStudents.Class_LessonsID) WHERE read = 0 AND StudentID = "&Session("student_id")
	        recordset.Open query_di_interrogazione,connessione
        %>
        

        <%
        If Not recordset.EOF Then
        %>
        <hr />
        <h2>Le mie lezioni</h2>
        <%
            Do While Not recordset.eof
        %>
        <div class="col-md-12 lesson-to-confirm">
            <div class="col-md-10">Parteciperai al corso di <%=recordset("Name") %></div>
            <div class="col-md-2"><a href="/Controllers/Class_Lesson/UpdateEventNotification.asp?c=<%=recordset("Class_LessonsStudentsID") %>" class="btn btn-primary">Ok</a></div>
        </div>
        <%
             recordset.movenext
            Loop
        End If
        %>


        <br />
        <hr />
        <h2>La mia agenda</h2>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#calendar").fullCalendar({
                    defaultView: "agendaWeek",
                    header: {
                        left: "prev,next today",
                        center: "title",
                        right: ""/*"month,agendaWeek,agendaDay"*/,
                    },
                    defaultDate: moment(),
                    selectable: true,
                    selectHelper: true,
                    editable: true,
                    slotDuration:"01:00:00",
                    eventLimit: true,
                    eventStartEditable: false,
                    eventClick: function(calEvent, jsEvent, view) {
                        $("#myModal .modal-body").text(calEvent.title);
                        $(".open_modal").click();
                    },
                    events: [
                        {
                            start: "1900-01-01T10:00:00",
                            end: moment(),
                            overlap: false,
                            rendering: "background",
                            color: "#ff9f89"
                        }
                        //Ora segno gli impegni provvisori dello studente
                        <%
                            recordset.close
                            query_di_interrogazione="SELECT LessonID, DateStart, DateEnd, Tutor.TutorID, Tutor.Name + ' '+ Tutor.Surname as TutorName, Tutor.Address as Address, Tutor.mobile as mobile, Tutor.email as email FROM (Lessons INNER JOIN Tutor ON Tutor.TutorID = Lessons.TutorID) WHERE Accepted = 0 AND Lessons.StudentID = "&Session("student_id")
                            recordset.Open query_di_interrogazione,connessione
                            If Not recordset.EOF Then
                                Do While Not recordset.eof
                        %>
                            ,{ title:"provvisorio:\n<%=recordset("TutorName") %>\n <%=recordset("mobile")%> - <%=recordset("email")%>,  <%=recordset("Address") %>", start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>" , color: "#d35f39" } 
                        <%
                                recordset.movenext
                                Loop
                            End If
                            recordset.close
                        %>
            //Ora segno gli impegni confermati dello studente
                        <%
                            query_di_interrogazione="SELECT LessonID, DateStart, DateEnd, Tutor.TutorID, Tutor.Name + ' '+ Tutor.Surname as TutorName, Tutor.Address as Address FROM (Lessons INNER JOIN Tutor ON Tutor.TutorID = Lessons.TutorID) WHERE Accepted = 1 AND Lessons.StudentID = "&Session("student_id")
            recordset.Open query_di_interrogazione,connessione
            If Not recordset.EOF Then
            Do While Not recordset.eof
        %>
        ,{ title:"confermato\n<%=recordset("TutorName") %>\n<%=recordset("Address") %>", start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>" , color: "green" }
       <%
            recordset.movenext
            Loop
            End If
            recordset.close
        %>
            ]
            });

            });

        </script>
        <div id='calendar'></div>
        <button type="button" class="open_modal btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" style="display: none;">
            apri modal
        </button>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Evento</h4>
                    </div>
                    <div class="modal-body" style="overflow: auto;">
                        <div class="col-md-12">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%	set recordset=nothing
	set connessione=nothing
%>
<!--#include virtual="\sitemaster_bottom_alt.html"-->
