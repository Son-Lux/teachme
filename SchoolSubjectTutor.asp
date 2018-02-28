<!--#include file="sitemaster_top.asp"-->
<%
    wordarray=split(request.querystring("materia"),"|")
    ss = wordarray(0)
    ssc = wordarray(1)
    ord = request.querystring("ord")

    dim nome_database,connessione,recordset,query_di_interrogazione,wordarray
	nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	Set connessione=Server.CreateObject("ADODB.Connection")
	Set recordset=Server.CreateObject ("ADODB.Recordset")
	connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

    if ord = "price" then
        query_di_interrogazione = "SELECT DISTINCT SchoolSubjectID, ClassId, Tutor.TutorID as TutorID, Tutor.Name + ' ' + Tutor.Surname as TutorName, Tutor.Lat as Lat, Tutor.Lon as Lon, Price, SchoolSubject.SchoolSubjectID as SchoolSubjectID FROM ((SchoolSubject INNER JOIN TutorSchoolSubject ON TutorSchoolSubject.SchoolSubjectID = SchoolSubject.SchoolSubjectID) LEFT JOIN Tutor ON Tutor.TutorID = TutorSchoolSubject.TutorID) WHERE ClassID = "&ssc&" AND Tutor.IsPrivate = 0 AND SchoolSubject.Name = '"&ss&"' ORDER BY Price"
    else
        query_di_interrogazione = "SELECT DISTINCT SchoolSubjectID, ClassId, Tutor.TutorID, Tutor.Name + ' ' + Tutor.Surname as TutorName, Tutor.Lat as Lat, Tutor.Lon as Lon, Price, SchoolSubject.SchoolSubjectID as SchoolSubjectID FROM ((SchoolSubject INNER JOIN TutorSchoolSubject ON TutorSchoolSubject.SchoolSubjectID = SchoolSubject.SchoolSubjectID) LEFT JOIN Tutor ON Tutor.TutorID = TutorSchoolSubject.TutorID) WHERE ClassID = "&ssc&" AND Tutor.IsPrivate = 0 AND SchoolSubject.Name = '"&ss&"'"
    end if
    'response.Write(query_di_interrogazione)
	recordset.Open query_di_interrogazione,connessione

    If Not recordset.EOF Then
%>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script type="text/javascript">
    function initialize() {

        // Multiple Markers
        var markers = [
            <%
                Do While Not recordset.eof
            %>
                    ['<%=recordset("TutorName")%>', <%=recordset("Lat")%>, <%=recordset("Lon")%>]
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
    <div class="col-md-12" style="margin: 40px 0;">
        Ordina in base a:
        <select class="select_order">
            <option></option>
            <option value="SchoolSubjectTutor.asp?materia=<%=ss %>">Distanza</option>
            <option value="SchoolSubjectTutor.asp?ord=price&materia=<%=ss %>">Prezzo</option>
        </select>

    </div>
    <ul style="margin-top: 10px;">
        <%
            recordset.MoveFirst
        Do While Not recordset.eof
        %>
        <li>
            <div class="col-md-12 lesson-to-confirm">
                <div class="col-md-10"><a href="Tutor_Index.asp?t=<%=recordset("TutorID") %>"><%=recordset("TutorName") %></a>, <%=recordset("Price") %>&euro;</div>
                <% If Session("student_logged") Then %>
                <div class="col-md-2"><a class="btn btn-primary" href="tutorAvailability.asp?ss=<%=recordset("SchoolSubjectID") %>&t=<%=recordset("TutorID") %>">prenota</a></div>
                <% Else %>
                <div class="col-md-2"><a class="btn btn-primary" href="/Tutor_Index.asp?t=<%=recordset("TutorID") %>">Vedi agenda</a></div>
                <% End If %>
            </div>
        </li>
        <%
            recordset.movenext
        Loop
        %>
    </ul>
</div>
<%
    Else
    %>
        <div class="container">
            Non ci sono Tutor disponibili per questa lezione<br /><br />
        </div>
    <%
    End If

    set recordset=nothing
	set connessione=nothing
%>


<!--#include file="sitemaster_bottom.html"-->
