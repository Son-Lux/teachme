<!--#include file="sitemaster_top.asp"-->
<%
    cls = request.querystring("cls")
    ord = request.querystring("ord")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    if ord = "price" then
        if Session("student_id") <> "" then
            query_di_interrogazione = "SELECT DISTINCT Class_LessonID, TakenSeats, MenberNumber, Place, DateStart, DateEnd, Class_Lessons.Description as Description, Class_Lessons.Name as Name, Class_Lessons.TutorID, Price, Tutor.Lat as Lat, Tutor.Lon as Lon, Tutor.Name + ' ' + Tutor.Surname as TutorName, Tutor.TutorID, Class_LessonsStudents.StudentID FROM ((Class_Lessons INNER JOIN Tutor ON Tutor.TutorID = Class_Lessons.TutorID) LEFT JOIN Class_LessonsStudents ON Class_LessonsStudents.Class_LessonsID = Class_Lessons.Class_LessonID) WHERE Tutor.IsPrivate = 0 AND CategoryID = "&cls&" ORDER BY Price"
        else
            query_di_interrogazione = "SELECT DISTINCT Class_LessonID, TakenSeats, MenberNumber, Place, DateStart, DateEnd, Class_Lessons.Description as Description, Class_Lessons.Name as Name, Class_Lessons.TutorID, Price, Tutor.Lat as Lat, Tutor.Lon as Lon, Tutor.Name + ' ' + Tutor.Surname as TutorName, Tutor.TutorID, Class_LessonsStudents.StudentID FROM ((Class_Lessons INNER JOIN Tutor ON Tutor.TutorID = Class_Lessons.TutorID) LEFT JOIN Class_LessonsStudents ON Class_LessonsStudents.Class_LessonsID = Class_Lessons.Class_LessonID) WHERE Tutor.IsPrivate = 0 AND CategoryID = "&cls&" ORDER BY Price"
        end if
    else
        if Session("student_id") <> "" then
            query_di_interrogazione = "SELECT DISTINCT Class_LessonID, TakenSeats, MenberNumber, Place, DateStart, DateEnd, Class_Lessons.Description as Description, Class_Lessons.Name as Name, Class_Lessons.TutorID, Price, Tutor.Lat as Lat, Tutor.Lon as Lon, Tutor.Name + ' ' + Tutor.Surname as TutorName, Tutor.TutorID, Class_LessonsStudents.StudentID FROM ((Class_Lessons INNER JOIN Tutor ON Tutor.TutorID = Class_Lessons.TutorID) LEFT JOIN Class_LessonsStudents ON Class_LessonsStudents.Class_LessonsID = Class_Lessons.Class_LessonID) WHERE Tutor.IsPrivate = 0 AND CategoryID = "&cls
        else
            query_di_interrogazione = "SELECT DISTINCT Class_LessonID, TakenSeats, MenberNumber, Place, DateStart, DateEnd, Class_Lessons.Description as Description, Class_Lessons.Name as Name, Class_Lessons.TutorID, Price, Tutor.Lat as Lat, Tutor.Lon as Lon, Tutor.Name + ' ' + Tutor.Surname as TutorName, Tutor.TutorID, Class_LessonsStudents.StudentID FROM ((Class_Lessons INNER JOIN Tutor ON Tutor.TutorID = Class_Lessons.TutorID) LEFT JOIN Class_LessonsStudents ON Class_LessonsStudents.Class_LessonsID = Class_Lessons.Class_LessonID) WHERE Tutor.IsPrivate = 0 AND CategoryID = "&cls
        end if
    end if
    'response.Write(query_di_interrogazione)
	recordset.Open query_di_interrogazione,connessione
    
    If Not recordset.EOF Then
%>
<style>
    ul { list-style: none; }
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script type="text/javascript">
    function initialize() {

        // Multiple Markers
        var markers = [
            <%
                Do While Not recordset.eof
            %>
                    ['<%=recordset("Name")%>', <%=recordset("Lat")%>, <%=recordset("Lon")%>]
            <%
                    
                    recordset.movenext
        If Not recordset.EOF Then
        Response.Write(",")
        End If
        Loop
    %>
        ];        var bounds = new google.maps.LatLngBounds();
        var map = new google.maps.Map(document.getElementById("map-canvas"), {
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        // Loop through our array of markers & place each one on the map  
        for (i = 0; i < markers.length; i++) {
            var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
            bounds.extend(position);
            marker = new google.maps.Marker({
                position: position,
                map: map,
                title: markers[i][0]
            });

            // Allow each marker to have an info window    
            google.maps.event.addListener(marker, 'click', (function (marker, i) {
                return function () {
                    infoWindow.open(map, marker);
                }
            })(marker, i));

            // Automatically center the map fitting all markers on the screen
            map.fitBounds(bounds);
        }        // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
        var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function (event) {
            this.setZoom(10);
            google.maps.event.removeListener(boundsListener);
        });
    }

    google.maps.event.addDomListener(window, 'load', initialize);

    $(function(){
        $(".select_order").change(function(){
            location.href=$(this).val();
        });
    });

</script>
<div id="map-canvas" style="width: 100%; height: 248px;"></div>
<div class="container">
    <br />
    <br />
    Ordina in base a:
        <select class="select_order">
            <option></option>
            <option value="Class_Lessons_search.asp?cls=<%=cls %>">Distanza</option>
            <option value="Class_Lessons_search.asp?ord=price&cls=<%=cls %>">Prezzo</option>
        </select>
    <ul style="margin-top: 10px;">
        <%
        recordset.MoveFirst
            Do While Not recordset.eof
        %>
        <li>
            <div class="col-md-12 lesson-to-confirm">
                <div class="col-md-10"><a href="Tutor_Index.asp?t=<%= recordset("TutorID") %>"><%= recordset("TutorName") %></a> <%=recordset("Name") %>, <%=recordset("Price") %>&euro;</div>
                <div class="col-md-2"><a class="btn btn-primary" data-target="#<%= recordset("Class_LessonID") %>" data-toggle="modal">vedi pagina Tutor</a></div>
            </div>
            <div class="modal fade" id="<%=recordset("Class_LessonID") %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form class="form-horizontal change_admin_form" role="form" name="change_account_form" method="post" action="../../Controllers/Class_Lesson/JoinEvent.asp">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title"><%=recordset("Name") %> - <%=recordset("DateStart") %> </h4>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="TutorID" value="<%= recordset("TutorID") %>">
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
                                <%If Session("student_logged") Then %>
                                <input type="submit" class="btn btn-primary" value="Prenota">
                                <%End If %>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </li>
        <%
            recordset.movenext
        Loop
        %>
    </ul>
</div>

<%
    else
        Response.Write("Attualmente non sono presenti corsi per questa categoria")
    End If

    set recordset=nothing
	set connessione=nothing
%>


<!--#include file="sitemaster_bottom.html"-->
