<%
    If Session("tutor_logged") Then
        Session("tutor_logged") = False
        Session("tutor_id") = 0
    End If
    If Session("private_logged") Then
        Session("private_logged") = False
        Session("private_id") = 0
    End If
    If Session("student_logged") Then
        Session("student_logged") = False
        Session("student_id") = 0
    End If
    Session("ExpiredAccount") = 0
    response.redirect("/")
%>