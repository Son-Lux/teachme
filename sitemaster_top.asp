<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="it"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="it"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="it"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="it"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html lang="it">
<!--<![endif]-->
<head>
    <title>TeachMe</title>
    <meta charset="utf-8">
    <meta http-equiv="content-language" content="it-IT">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/Content/Images/favicon.png" type="image/ico" />

    <!-- Fonts START -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|PT+Sans+Narrow|Source+Sans+Pro:200,300,400,600,700,900&amp;subset=all" rel="stylesheet" type="text/css">
    <!-- Fonts END -->
    <!--<link href="/Content/style.css" rel="stylesheet" />-->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- CALENDARIO -->
    <link href='/Content/fullcalendar.css' rel='stylesheet' />
    <link href='/Content/fullcalendar.print.css' rel='stylesheet' media='print' />
    <link href='/Content/stile.css' rel='stylesheet' />
    <script src='/Script/lib/moment.min.js'></script>
    <script src='/Script/lib/jquery.min.js'></script>
    <script src='/Script/fullcalendar.min.js'></script>
    <script src='/Script/lang/it.js'></script>
    <!-- CALENDARIO -->
    <!-- Global styles START -->
    <link href="/Content/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <!-- Global styles END -->
    <!-- Page level plugin styles START -->
    <link href="/Content/jquery.fancybox.css" rel="stylesheet">
    <link href="/Content/owl.carousel.css" rel="stylesheet">
    <link href="/Content/settings.css" rel="stylesheet">
    <!-- Page level plugin styles END -->
    <!-- Theme styles START -->
    <link href="/Content/components.css" rel="stylesheet">
    <link href="/Content/style.css" rel="stylesheet">
    <!--<link href="/Content/style-revolution-slider.css" rel="stylesheet">-->
    <!-- metronic revo slider styles -->
    <link href="/Content/style-responsive.css" rel="stylesheet">
    <link href="/Content/themes/red.css" rel="stylesheet" id="style-color">
    <link href="/Content/custom.css" rel="stylesheet">
    <!-- Theme styles END -->

    <style>
        html, body, #map-canvas { height: 100%; margin: 0px; padding: 0px; }
        .controls { margin-top: 16px; border: 1px solid transparent; border-radius: 2px 0 0 2px; box-sizing: border-box; -moz-box-sizing: border-box; height: 32px; outline: none; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3); }
        #pac-input { background-color: #fff; font-family: Roboto; font-size: 15px; font-weight: 300; margin-left: 12px; padding: 0 11px 0 13px; text-overflow: ellipsis; width: 400px; margin-top: 10px; }
            #pac-input:focus { border-color: #4d90fe; }
        .pac-container { font-family: Roboto; }
        #type-selector { color: #fff; background-color: #4d90fe; padding: 5px 11px 0px 11px; }
            #type-selector label { font-family: Roboto; font-size: 13px; font-weight: 300; }
        #target { width: 345px; }
    </style>

    <script type="text/javascript">
        $(function () {
            $(window).scroll(function () {
                if ($(this).scrollTop() > 0)
                    $(".header").addClass("fixed");
                else
                    $(".header").removeClass("fixed");
            });
        });
    </script>

</head>
<body class="corporate">
    <%If Session("tutor_logged") Then
        If Session("TrialMode") Then
            if Session("LessonsNumber") > 7 Then
	            nome_database=server.mappath("/")&"\mdb-database\TeachMe_DB_2015.mdb"
	            Set connessione=Server.CreateObject("ADODB.Connection")
	            Set recordset=Server.CreateObject ("ADODB.Recordset")
	            connessione.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&nome_database

                query_di_interrogazione="UPDATE Tutor SET TrialMode = false, AccountExpiringDate = '1/1/1900' WHERE TutorID = "&Session("Tutor_id")
                recordset.Open query_di_interrogazione,connessione
                recordset.Close 

                set recordset=nothing
	            set connessione=nothing
            end if
        Else
            If Session("ExpiredAccount") > 0 Then    
    %>
    <style>
        body { overflow: hidden; }
    </style>
    <div class="block">
        <div>
            Il tuo abbonamento è scaduto! Clicca sul bottone qui sotto per rinnovare!<br />
            <% if Session("AccountType") = "Mensile" then %>
            <!--[Mensile]-->
            <br />
            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                <input type="hidden" name="cmd" value="_s-xclick">
                <input type="hidden" name="hosted_button_id" value="8KDKC9AHQHEAC">
                <input type="image" src="https://www.paypalobjects.com/it_IT/IT/i/btn/btn_buynow_SM.gif" border="0" name="submit" alt="PayPal è il metodo rapido e sicuro per pagare e farsi pagare online.">
                <img alt="" border="0" src="https://www.paypalobjects.com/en_GB/i/scr/pixel.gif" width="1" height="1">
            </form>

            <% end if %>
            <% if Session("AccountType") = "Annuale" then %>
            <!--[Annuale]-->
            <br />
            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                <input type="hidden" name="cmd" value="_s-xclick">
                <input type="hidden" name="hosted_button_id" value="KFZPX7GJTU58N">
                <input type="image" src="https://www.paypalobjects.com/it_IT/IT/i/btn/btn_buynow_SM.gif" border="0" name="submit" alt="PayPal è il metodo rapido e sicuro per pagare e farsi pagare online.">
                <img alt="" border="0" src="https://www.paypalobjects.com/en_GB/i/scr/pixel.gif" width="1" height="1">
            </form>

            <% end if %>
            <% if Session("AccountType") = "Prova" then %>
            <!--[Prova]-->
            <br />
            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                <input type="hidden" name="cmd" value="_s-xclick">
                <input type="hidden" name="hosted_button_id" value="KDZZZDE3FUNLS">
                <input type="image" src="https://www.paypalobjects.com/it_IT/IT/i/btn/btn_buynow_SM.gif" border="0" name="submit" alt="PayPal è il metodo rapido e sicuro per pagare e farsi pagare online.">
                <img alt="" border="0" src="https://www.paypalobjects.com/it_IT/i/scr/pixel.gif" width="1" height="1">
            </form>
            <a href="/Controllers/account/unlockTutor_month.asp">rinnova gratis</a>
            <% end if %>
            <br />
            oppure
                    <br />
            <a href="/Controllers/Login/logout.asp">Logout</a>
        </div>
    </div>
    <%  End If
        End If
        
    End If
    %>
    <!-- BEGIN HEADER -->
    <div class="header">
        <div class="container">
            <a class="site-logo" href="/">
                <img src="/Content/img/logos/logo.png" alt="TeachMe" style="width: 138px;"></a>
            <a href="javascript:void(0);" class="mobi-toggler"><i class="fa fa-bars"></i></a>
            <!-- BEGIN NAVIGATION -->
            <div class="header-navigation pull-right font-transform-inherit">

                <ul>
                    <%If Session("tutor_logged") Or Session("student_logged") Or Session("private_logged") Then%>
                    <%If Session("tutor_logged") Then %>
                    <% if Session("AccountType") <> "Base" then %>
                    <li><a href="/ordersTutor.asp">Storico Lezioni</a></li>
                    <%End If%>
                    <li><a href="/Tutor_Index_edit.asp">Agenda</a></li>
                    <%End If%>
                     <%If Session("private_logged") Then %>
                    <% if Session("AccountType") <> "Base" then %>
                    <li><a href="/ordersPrivate.asp">Storico Lezioni</a></li>
                    <%End If%>
                    <li><a href="/Private_Index_edit.asp">Agenda</a></li>
                    <%End If%>
                    <%If Session("student_logged") Then %>

                    <li><a href="/orders.asp">Storico Ordini</a></li>
                    <li><a href="/Student_Index_edit.asp">Agenda</a></li>
                    <%End If%>
                    <li><a href="/Controllers/Login/logout.asp">Logout</a></li>
                    <%Else%>
                    <li><a href="/View/Account/page-login-student.asp">Utente</a></li>
                    <li><a href="/View/Account/page-login-tutor.asp">Tutor</a></li>
                    <li><a href="/View/Account/page-login-private.asp">Privato</a></li>
                    <%End If%>
                </ul>
            </div>
            <!-- END NAVIGATION -->
        </div>
    </div>
    <!-- Header END -->

    <% If Session("Cookie") = False Then %>
    <div id="cookie-law-info-bar" style="z-index: 10000;display: block; color: rgb(255, 255, 255); font-family: inherit; position: fixed; bottom: 0px; background-color: rgb(0, 0, 0);"><span>Utilizzando il sito si accetta l’uso di cookies per analisi e risultati personalizzati. <a href="/SetCookie.asp" id="cookie_action_close_header" class="medium cli-plugin-button cli-plugin-main-button" style="color: rgb(255, 255, 255); background-color: rgb(0, 0, 0);">Ok</a> <a href="http://www.negativopositivo.it/privacy-policy" id="CONSTANT_OPEN_URL" target="_new" class="cli-plugin-main-link" style="color: rgb(68, 68, 68);">Dettagli</a></span></div>
    <% End If %>