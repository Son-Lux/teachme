<!--#include file="sitemaster_top.asp"-->
<!-- DATEPICKER -->
<link href="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/d004434a5ff76e7b97c8b07c01f34ca69e635d97/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/d004434a5ff76e7b97c8b07c01f34ca69e635d97/src/js/bootstrap-datetimepicker.js"></script>
<script src="http://tinymce.cachefly.net/4.2/tinymce.min.js"></script>
<!-- DATEPICKER END -->
<!-- =DateAdd("m";1;Date$()) -->
<%
    Dim private_id
    If Session("private_id") <> "" Then
        private_id = Session("private_id")
    End If

    If request.QueryString("t") <> "" Then
        private_id = request.QueryString("t")
    End If

  If private_id <> "" Then
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    'Ottengo StudentClass che è la classe che frequenta lo studente
    query_di_interrogazione="SELECT Name, IsPrivate, pageUrl, Address, p_iva, Email, mobile, facebookpage, url, Not_avaliable_days, description, paymentmethod_cash, paymentmethod_creditcard, paymentmethod_bank, AccountType, AccountExpiringDate FROM private WHERE privateID = " & private_id
	recordset.Open query_di_interrogazione,connessione
    privateName = recordset("Name")
    IsPrivate = recordset("IsPrivate")
    pageUrl = recordset("pageUrl")
    Address = recordset("Address")
    p_iva = recordset("p_iva")
    Email = recordset("Email")
    Mobile = recordset("mobile")
    facebookpage = recordset("facebookpage")
    url = recordset("url")
    not_avaliable_days = recordset("Not_avaliable_days")
    description = recordset("description")
    paymentmethod_cash = recordset("paymentmethod_cash")
    paymentmethod_creditcard = recordset("paymentmethod_creditcard")
    paymentmethod_bank = recordset("paymentmethod_bank")
    accounttype = recordset("AccountType")
    AccountExpiringDate = recordset("AccountExpiringDate")
    recordset.Close

%>
<script type="text/javascript">
    tinymce.init({
        selector: "#mytextarea"
    });
    $(function(){
        $(".close_not_logged").click(function(){
            $(".not_logged").fadeOut();
        });

        $(".ss_category").change(function() {
            var _val = $(this).val();
            $(".ss_name option").hide();
            $(".ss_name option.class_"+_val).show();
            $(".ss_name option:first-child").attr("selected", "selected").show();
        });
    });
</script>

<div class="main">
    <div class="container">
        <h1><%=privateName %></h1>
        <div style="margin-bottom: 10px;"><%=description %></div>
        <ul>
            <li>Indirizzo: <%=Address %></li>
            <li>Partita Iva: <%=p_iva %></li>
            <%If url<>"" Then %>
            <li>Sito internet: <a href="http://<%=url %>"><%=url %></a></li>
            <%End If %>
            <%If facebookpage<>"" Then %>
            <li>Pagina Facebook: <a href="http://<%=facebookpage %>"><%=facebookpage %></a></li>
            <%End If %>
            <li>Email: <%=Email %></li>
            <li>Cellulare: <%=Mobile %></li>
            <li>Metodo di Pagamento:
                <%if paymentmethod_cash then %>
                    Contanti
                <%end if %>
                <%if paymentmethod_creditcard then %>
                    Carta di Credito
                <%end if %>
                <%if paymentmethod_bank then %>
                    Bonifico
                <%end if %>
            </li>
        </ul>
        <br />
        <%
            If Session("private_logged") Then
        query_di_interrogazione="SELECT LessonID, DateStart, Student.Email as StudentEmail, Student.Name+' '+Student.Surname as StudentName, Student.StudentID as StudentID, SchoolSubject.Name as SchoolSubjectName, DateDiff ('n', DateStartFormatted, DateEndFormatted) as Duration FROM (Lessons INNER JOIN Student ON Lessons.StudentID = Student.StudentID) INNER JOIN SchoolSubject ON Lessons.SchoolSubjectID = SchoolSubject.SchoolSubjectID WHERE Accepted = 0 AND Ignore = 0 AND privateID = "&private_id
	    recordset.Open query_di_interrogazione,connessione    

        If Not recordset.EOF Then
        %>
        <h2>Lezioni da confermare:</h2>
        <br />
        <%
            Do While Not recordset.eof
                If DateDiff("y",FormatDateTime(replace(recordset("DateStart"),"T"," "),0),FormatDateTime(Now,0)) > 0 Then
        %>
        <div class="col-md-12 lesson-to-confirm">
            <div class="col-md-8">[Scaduta] Lezione di <%=recordset("Duration") %> min con <a href="/View/Student/Student_anag.asp?s=<%=recordset("StudentID") %>"><%=recordset("StudentName") %></a> di <%=recordset("SchoolSubjectName") %> il <%=FormatDateTime(replace(recordset("DateStart"),"T"," "),0) %></div>
            <div class="col-md-2"><a class="btn btn-primary" href="mailto:<%=recordset("StudentEmail") %>?subject=[TeachMe] Proposta spostamento Lezione">Proponi Modifica</a></div>
            <div class="col-md-2"><a class="btn btn-primary" href="SQL/Ignore.asp?l=<%=recordset("LessonID") %>">Ok</a></div>
        </div>
        <%
                Else
        %>
        <div class="col-md-12 lesson-to-confirm">
            <div class="col-md-8">Lezione di <%=recordset("Duration") %> min con <a href="/View/Student/Student_anag.asp?s=<%=recordset("StudentID") %>"><%=recordset("StudentName") %></a> di <%=recordset("SchoolSubjectName") %> il <%=FormatDateTime(replace(recordset("DateStart"),"T"," "),0) %></div>
            <div class="col-md-1"><a class="btn btn-primary" href="SQL/confirmEvent.asp?l=<%=recordset("LessonID")%>">Conferma</a></div>
            <div class="col-md-1"><a class="btn btn-primary" href="SQL/deleteLesson.asp?l=<%=recordset("LessonID") %>">Rifiuta</a></div>
            <div class="col-md-2"><a class="btn btn-primary" href="mailto:<%=recordset("StudentEmail") %>?subject=[TeachMe] Proposta spostamento Lezione">Proponi Modifica</a></div>
        </div>
        <%
                End If
        %>
        <%
             recordset.movenext
            Loop
        End If
        recordset.close
            End If
        %>
        <br />
        <%
            If Session("private_logged") Then
            query_di_interrogazione="SELECT Class_LessonsStudentsID, Name FROM Class_Lessons INNER JOIN Class_LessonsStudents ON Class_LessonsStudents.Class_LessonsID = Class_Lessons.Class_LessonID WHERE IsNew = true AND privateID = "&private_id
	        recordset.Open query_di_interrogazione,connessione
            
            If Not recordset.EOF Then
                Do While Not recordset.eof
        %>
        <div class="col-md-12 lesson-to-confirm">
            <div class="col-md-8">Nuovo iscritto al corso di <%=recordset("Name") %></div>
            <div class="col-md-1"><a class="btn btn-primary" href="Controllers/Class_Lesson/UpdateNewClassLessionStudent.asp?t=<%=recordset("Class_LessonsStudentsID") %>">OK</a></div>
        </div>
        <%
            recordset.movenext
                Loop
            End If
        recordset.close
            End If
        %>
        <br />
        <h2>Lezioni che insegno:</h2>
        <br />
        <div class="class_lesson_container">
            <%
                query_di_interrogazione = "SELECT DISTINCT SchoolSubject.SchoolSubjectID, SchoolSubject.Name as SchoolSubjectName , Class.Name as ClassName, SchoolSubject.Price as Price FROM (privateSchoolSubject INNER JOIN SchoolSubject ON SchoolSubject.SchoolSubjectID = privateSchoolSubject.SchoolSubjectID) INNER JOIN Class ON Class.ClassID = SchoolSubject.ClassID WHERE privateID = "&private_id
                recordset.Open query_di_interrogazione,connessione  
                
                If Not recordset.EOF Then
                    Do While Not recordset.eof
                        If Not Session("private_logged") Then
            %> <a href="privateAvailability.asp?t=<%=private_id %>&ss=<%=recordset("SchoolSubjectID") %>" class="col-md-3"><span><%= recordset("SchoolSubjectName")%> (<%= recordset("ClassName")%>) - <%= recordset("Price")%>&euro; all'ora.</span></a><%
                        ElseIf Session("private_logged") Then
            %>
            <a class="col-md-3" data-toggle="modal" data-target="#<%=recordset("SchoolSubjectID") %>"><span><%= recordset("SchoolSubjectName")%> (<%= recordset("ClassName")%>) - <%= recordset("Price")%>&euro; all'ora.</span></a>
            <div class="modal fade" id="<%=recordset("SchoolSubjectID") %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form class="form-horizontal change_admin_form" role="form" name="change_account_form" method="post" action="../../Controllers/SchoolSubjects/UpdateSchoolSubjects.asp">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Modifica Lezione</h4>
                            </div>
                            <div style="overflow: auto;" class="modal-body">
                                <input type="hidden" value="<%=recordset("SchoolSubjectID") %>" name="SchoolSubjectID">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        Nome Materia:
                                    <input type="text" name="ss_name" class="form-control" value="<%=recordset("SchoolSubjectName") %>">
                                    </div>
                                    <div class="form-group">
                                        Livello:
                                    <select name="ss_level">
                                        <option value="1">Medie</option>
                                        <option value="2">Superiori</option>
                                        <option value="3">Universit&agrave;</option>
                                        <option value="9">Altro</option>
                                    </select>
                                    </div>
                                    <div class="form-group">
                                        Prezzo:
                                    <input type="text" name="ss_price" class="form-control" value="<%=recordset("Price") %>">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <input type="submit" class="btn btn-primary" value="Modifica">
                                <a class="btn btn-default" href="../../Controllers/SchoolSubjects/DeleteSchoolSubjects.asp?ss=<%=recordset("SchoolSubjectID") %>">Elimina</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <%
                        End If 
                        recordset.movenext
                    Loop
                End If
                recordset.Close
            %>
        </div>
        <%If Session("private_logged") or Session("student_logged") Then %>
        <h2>I miei corsi:</h2>
        <br />
        <div class="class_lesson_container">
            <% If Not Session("student_logged") and Not Session("private_logged") Then %>
            <div class="not_logged">
                Per eseguire qualsiasi operazione col private devi essere registrato e loggato.
                <br />
                <br />
                <a href="#" class="btn btn-primary close_not_logged">OK</a>
            </div>
            <% End If %>

            <%

                If Session("student_logged") Then
                    query_di_interrogazione="SELECT Class_Lessons.Class_LessonID as Class_LessonID, Class_Lessons.Name, Class_Lessons.MenberNumber, Class_Lessons.DateStart, Class_Lessons.DateEnd, Class_Lessons.Price, Class_Lessons.Description, Class_Lessons.TakenSeats, Class_Lessons.privateID, (SELECT COUNT(*) FROM Class_LessonsStudents WHERE StudentID = "&Session("Student_id")&" AND Class_LessonsStudents.Class_LessonsID=Class_LessonID ) AS AlreadyHere, Place FROM Class_Lessons WHERE (((Class_Lessons.[privateID])="&private_id&"));"
                else
                    query_di_interrogazione="SELECT Class_LessonID, Name, MenberNumber, DateStart, DateEnd, Description, TakenSeats, privateID, Place, Price FROM Class_Lessons WHERE privateID = "&private_id
                end if

                recordset.Open query_di_interrogazione,connessione    

                if recordset.RecordCount > 0 then
                    Class_LessonsID = recordset("Class_LessonID")
                end if
                
            If Not recordset.EOF Then
            Do While Not recordset.eof
                If Session("student_logged") Then 
                If recordset("AlreadyHere") > 0 Then %>
            <a class="col-md-3">
                <span>
                    <%=recordset("Name") %> - <%=recordset("DateStart") %><br />
                    Prezzo per persona: <%=recordset("Price") %> &euro;<br />
                    Posti prenotati: <%=recordset("TakenSeats") %>/<%=recordset("MenberNumber") %><br />
                    [gi&agrave; iscritto]
                </span>
            </a>
            <%Else %>
            <a class="col-md-3" data-toggle="modal" data-target="#<%=recordset("Class_LessonID") %>">
                <span>
                    <%=recordset("Name") %> - <%=recordset("DateStart") %><br />
                    Prezzo per persona: <%=recordset("Price") %> &euro;<br />
                    Posti prenotati: <%=recordset("TakenSeats") %>/<%=recordset("MenberNumber") %><br />
                </span>
            </a>
            <%End If %>

            <div class="modal fade" id="<%=recordset("Class_LessonID") %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form class="form-horizontal change_admin_form" role="form" name="change_account_form" method="post" action="../../Controllers/Class_Lesson/JoinEvent.asp">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title"><%=recordset("Name") %> - <%=recordset("DateStart") %> </h4>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="privateID" value="<%=private_id %>" />
                                <input type="hidden" name="StudentID" value="<%=Session("student_Id") %>" />
                                <input type="hidden" name="Class_LessonsID" value="<%=recordset("Class_LessonID") %>" />
                                <%=recordset("Description") %><br />
                                Prezzo per persona: <%=recordset("Price") %>&euro;<br />
                                Posti: <%=recordset("TakenSeats") %>/<%=recordset("MenberNumber") %><br />
                                Luogo: <%=recordset("Place") %><br />
                                Data Fine Corso: <%=recordset("DateEnd") %><br />
                                <br />
                                Prenota un posto ora cliccando su Prenota.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <input type="submit" class="btn btn-primary" value="Prenota">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%ElseIf Session("private_logged") Then  %>
            <a class="col-md-3" href="modifica corso" data-toggle="modal" data-target="#<%=recordset("Class_LessonID") %>">
                <span>
                    <%=recordset("Name") %><br />
                    <%=recordset("Description") %><br />
                    Prezzo per persona: <%=recordset("Price") %> &euro;<br />
                    Posti prenotati: <%=recordset("TakenSeats") %>/<%=recordset("MenberNumber") %><br />
                </span>
            </a>
            <div class="modal fade" id="<%=recordset("Class_LessonID") %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form class="form-horizontal change_admin_form" role="form" name="change_account_form" method="post" action="../../Controllers/Class_Lesson/UpdateEvent.asp">
                            <input type="hidden" name="Class_LessonsID" value="<%=recordset("Class_LessonID") %>" />
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Modifica Corso</h4>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        Nome Corso:
                                <input type="text" name="class_name" class="form-control" value="<%=recordset("Name") %>" />
                                    </div>
                                    <div class="form-group">
                                        Numero Partecipanti:
                                <input type="text" name="class_menber_number" class="form-control" value="<%=recordset("MenberNumber") %>" />
                                    </div>
                                    <div class="form-group">
                                        Data Inizio Corso:
                                <input type="text" name="class_datestart" class="form-control" value="<%=recordset("DateStart") %>" />
                                    </div>
                                    <div class="form-group">
                                        Data Fine Corso:
                                <input type="text" name="class_dateend" class="form-control" value="<%=recordset("DateEnd") %>" />
                                    </div>
                                    <div class="form-group">
                                        Prezzo:
                                <input type="text" name="class_price" class="form-control" value="<%=recordset("Price") %>" />
                                    </div>
                                    <div class="form-group">
                                        Dove:
                                <input type="text" name="class_place" class="form-control" value="<%=recordset("Place") %>" />
                                    </div>
                                    <div class="form-group">
                                        Descrizione:
                                <textarea name="class_description" class="form-control"><%=recordset("Description") %></textarea>
                                    </div>
                                </div>


                                <%
                                    Set connessione2=Server.CreateObject("ADODB.Connection")
	                                Set rs=Server.CreateObject ("ADODB.Recordset")
	                                connessione2.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database
                                    sub_query_di_interrogazione ="SELECT Student.StudentID as StudentID, Student.Name+' '+Student.Surname as StudentName, Class_LessonsID, Class_LessonsStudentsID FROM Class_LessonsStudents INNER JOIN Student ON Student.StudentID = Class_LessonsStudents.StudentID WHERE Class_LessonsID = "& recordset("Class_LessonID")
                                    rs.Open sub_query_di_interrogazione,connessione2
                                    
                                    If Not rs.EOF Then
                                %><hr />
                                Partecipanti:<ul>
                                    <% Do While Not rs.eof %>
                                    <li><a href="../../Controllers/Class_Lesson/DeleteStudentFromClass.asp?cls=<%=rs("Class_LessonsStudentsID") %>&cl=<%=rs("Class_LessonsID") %>"><i class="fa fa-trash" style="display: inline!important;"></i></a>
                                        <a href="/View/Student/Student_anag.asp?s=<%=rs("StudentID") %>"><%=rs("StudentName") %></a>
                                    </li>
                                    <%
                                        rs.movenext
                                        Loop
                                    %>
                                </ul>
                                <%
                                    end if    
                                %>
                            </div>
                            <div class="modal-footer">
                                <a href="Controllers/Class_Lesson/DeleteClass.asp?c=<%=recordset("Class_LessonID") %>" style="margin-bottom: 0;" class="btn btn-default">Cancella</a>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
                                <input type="submit" class="btn btn-primary" value="Modifica">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%Else %>
            <a class="col-md-3" href="#">
                <span>
                    <%=recordset("Name") %><br />
                    <%=recordset("Description") %><br />
                    <%=recordset("Price") %> &euro;<br />
                    Posti: <%=recordset("TakenSeats") %>/<%=recordset("MenberNumber") %><br />
                </span>
            </a>
            <%End If %>

            <%
             recordset.movenext
            Loop
        End If
        recordset.close
            %>
        </div>
        <%end if%>
        <script type="text/javascript">
            $(document).ready(function() {
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
                    slotDuration:"01:00:00",
                    editable: true,
                    eventLimit: true,
                    eventClick: function(calEvent, jsEvent, view) {
                        $("#myModalEvent .modal-body").text(calEvent.title);
                        $(".open_modal").click();
                    },
                    events: [
                        {
                            start: "1900-01-01T10:00:00",
                            end: moment(),
                            overlap: false,
                            rendering: "background",
                            color: "#ff9f89"
                        },
                        <% If not_avaliable_days <> "" Then %>
                        {
                            title:"Non Disponibile",
                            start: '00:00', 
                            end: '24:00', 
                            dow: [ <%=not_avaliable_days %> ], // RepeaT
                            overlap: false,
                            rendering: "background",
                            color: "#ff9f89"
                        },
                        <% End If%>
                        <% If Session("private_logged") Then %>
                            //Ora segno gli impegni provvisori del private
                        <%
                            query_di_interrogazione="SELECT LessonID,DateStart,DateEnd, Student.Name +' '+ Student.Surname as StudentName, Mobile, Email FROM (Lessons INNER JOIN Student ON LEssons.StudentID = Student.StudentID) WHERE Accepted = 0 AND Lessons.privateID ="&private_id
                recordset.Open query_di_interrogazione,connessione
                If Not recordset.EOF Then
                Do While Not recordset.eof
            %>
            { title:"provvisorio:\n<%=recordset("StudentName") %>\n <%=recordset("mobile")%> - <%=recordset("email")%>", start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>" , color: "#d35f39" }
                        <%
                            if Not recordset.eof Then
                                response.write(",")
                            end if
                                recordset.movenext
                                Loop
                            End If
                            recordset.close
                        %>
                        //Ora segno gli impegni confermati del private
                        <%
                            query_di_interrogazione="SELECT LessonID,DateStart,DateEnd, Student.Name +' '+ Student.Surname as StudentName, Mobile, Email FROM (Lessons INNER JOIN Student ON LEssons.StudentID = Student.StudentID) WHERE Accepted = 1 AND Lessons.privateID ="&private_id
            recordset.Open query_di_interrogazione,connessione
            If Not recordset.EOF Then
            Do While Not recordset.eof
        %>
        { title:"confermato:\n<%=recordset("StudentName") %>\n <%=recordset("mobile")%> - <%=recordset("email")%>", start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>" , color: "green" }
                        <%
            if Not recordset.eof Then
            response.write(",")
            end if
                recordset.movenext
                Loop
            End If
            recordset.close
        %>
    <% End If %>
    //Ora segno i corsi del private
    <%
        query_di_interrogazione="SELECT Name, DateStart, DateEnd FROM Class_Lessons WHERE privateID = "&private_id
            recordset.Open query_di_interrogazione,connessione
            If Not recordset.EOF Then
            Do While Not recordset.eof
        %>
        { title:"Corso di <%=recordset("Name") %>", start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>" , color: "#57ABD9" }
                    <%
            if Not recordset.eof Then
            response.write(",")
            end if

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
        <button type="button" class="open_modal btn btn-primary btn-lg" data-toggle="modal" data-target="#myModalEvent" style="display: none;">
            apri modal
        </button>
        <div class="modal fade" id="myModalEvent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabelEvent">Evento</h4>
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
<!--#include virtual="\sitemaster_bottom_alt.html"-->
