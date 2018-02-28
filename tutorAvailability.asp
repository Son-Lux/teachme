<!--#include file="sitemaster_top.asp"-->
<%
    Function IIf(i,j,k)
	    If i Then IIf = j Else IIf = k
    End Function

  If Session("student_id") <> "" AND Session("student_id") <> 0 Then

%>
<div class="main">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/Student_Index.asp">Scelta Materia</a></li>
            <li class="active">Scelta Orario</li>
        </ul>
        <h1>Scelta Orario</h1>
        <%
    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database
    
    TutorID = request.querystring("t")
    StudentID = request.querystring("s")
    SchoolSubjectID = request.querystring("ss")

    If StudentID = "" Then
        StudentID = Session("student_id")
    End If

    query_di_interrogazione="SELECT Name, Surname FROM Student WHERE StudentID ="&StudentID
	recordset.Open query_di_interrogazione,connessione
    StudentName = recordset("Name")&" "&recordset("Surname")
    recordset.close

    query_di_interrogazione="SELECT Name FROM SchoolSubject WHERE SchoolSubjectID ="&SchoolSubjectID
	recordset.Open query_di_interrogazione,connessione
    SchoolSubjectName = recordset("Name")
    recordset.close

            
	
        %>
        <script>
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
            eventClick: function(calEvent, jsEvent, view) {
                        $("#myModal .modal-body").text(calEvent.title);
                        $(".open_modal").click();
                    },
            select: function(start, end, allDay) {
                var check = start;
                var today = moment();
                if(check < today)
                {
                    alert("Non è possibile inserire un evento nel passato.");
                }
                else
                {
                    var title = "Corso di recupero di <%=SchoolSubjectName %> con <%=StudentName %>";//prompt("Event Title:");
				    var eventData;
				    if (title) {
					    eventData = {
                            id: "<%=StudentID %><%=TutorID %><%=SchoolSubjectID %>"+moment(),
						    title: title,
						    start: start,
						    end: end,
                            editable:false
					    };
					    $("#calendar").fullCalendar("renderEvent", eventData, true); // stick? = true
				    }
				    $("#calendar").fullCalendar("unselect");
                    $(".poupup").show();
                    $(".no").click(function(){
                        $("#calendar").fullCalendar("removeEvents",eventData.id);
                        $(".poupup").hide();
                        location.reload();
                    });
                    $(".yes").click(function(){
                        var request = $.ajax({
                          url: "SQL/InsertEvent.asp",
                          type: "POST",
                          data: { 
                            LessonId : eventData.id,
                            DateStart: eventData.start.format(),
                            DateEnd: eventData.end.format(),
                            TutorID: "<%=TutorID %>",
                            StudentID: "<%=StudentID %>",
                            SchoolSubjectID: "<%=SchoolSubjectID %>"
                          },
                          dataType: "html"
                        });
                        request.done(function( msg ) {
                          window.location.href="orders.asp?s=<%=StudentID %>";
                        });
 
                        request.fail(function( jqXHR, textStatus ) {
                          alert( "Request failed: " + textStatus );
                        });
                        $(".poupup").hide();
                    });
                }
            },
			editable: true,
			eventLimit: true,
            selectOverlap: function(event) {
                return false;
            }
            ,events: [
                // red areas where no events can be dropped
                // il primo evento impedisce che la gente che la gente possa prendere impegni nel passato
				{
					start: "1900-01-01T10:00:00",
					end: moment(),
					overlap: false,
					rendering: "background",
					color: "#ff9f89"
				}
                //Ora segno gli giorni in cui il tutor non è disponibile
                <%
                    query_di_interrogazione="SELECT Not_avaliable_days FROM Tutor WHERE TutorID ="&TutorID
	                recordset.Open query_di_interrogazione,connessione
                    If Not recordset.EOF Then
                        Do While Not recordset.eof
                %>
                    ,{ start: "00:00", end: "24:00", dow: [ <%=recordset("Not_avaliable_days") %> ] , overlap: false, rendering: "background", color: "#ff9f89" }
                <%
                        recordset.movenext
                        Loop
                    End If
                    recordset.close
                %>
                //Ora segno gli impegni che il tutor ha già preso
                <%
                    query_di_interrogazione="SELECT LessonID,DateStart,DateEnd FROM Lessons WHERE Lessons.TutorID ="&TutorID& " AND Lessons.StudentId <> "&StudentID
	                recordset.Open query_di_interrogazione,connessione
                    If Not recordset.EOF Then
                        Do While Not recordset.eof
                %>
                    ,{ start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>", overlap: false, rendering: "background", color: "#ff9f89" }
                <%
                        recordset.movenext
                        Loop
                    End If
                    recordset.close
                %>

                <%
                    query_di_interrogazione="SELECT LessonID,DateStart,DateEnd, SchoolSubject.Name as SchoolSubjectName FROM Lessons INNER JOIN SchoolSubject On Lessons.SchoolSubjectID = SchoolSubject.SchoolSubjectID WHERE Lessons.StudentID ="&StudentID
	                recordset.Open query_di_interrogazione,connessione
                    If Not recordset.EOF Then
                        Do While Not recordset.eof
                %>
                    ,{ id: <%=recordset("LessonID") %>, title: "Corso di recupero di <%=recordset("SchoolSubjectName") %> con <%=StudentName %>", start: "<%=recordset("DateStart") %>", end: "<%=recordset("DateEnd") %>", editable:false }
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
        <div class="poupup">
            <p>Confermi l'inserimento dell'evento?</p>
            <a class="yes btn btn-primary">si</a>
            <a class="no btn btn-primary">no</a>
        </div>
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
        <%
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
    </div>
</div>
<!--#include virtual="\sitemaster_bottom_alt.html"-->
