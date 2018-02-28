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
        <%If Session("private_logged") Then %>
        <h1>Bentornato <%=privateName %></h1>
        il tuo account scade il <%=AccountExpiringDate %>
        <br />
        <br />
        <div style="margin-bottom: 10px;"><%=description %></div>
        <ul>
            <li>Indirizzo: <%=Address %></li>
            <%If Session("private_logged") = false Then %>
            <li>Partita Iva: <%=p_iva %></li>
            <%Else %>
            Il tuo url personale: http://teachme.tips/private_Index.asp?t=<%=private_id %>
            <%End If %>
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
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
            Impostazioni Account
        </button>
        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal2">
            Crea Corso
        </button>
        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal3">
            Inserisci materia da insegnare
        </button>
        <br />
        <br />
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form class="form-horizontal change_admin_form" role="form" name="change_account_form" method="post" action="../../Controllers/Account/Change_account_private.asp">
                        <input type="hidden" name="private_id" value="<%=private_id %>" />
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Modifica Impostazioni Account</h4>
                        </div>
                        <div class="modal-body" style="overflow: auto;">
                            <div class="col-md-12">
                                <div class="form-group">
                                    Tipo account:
                            <select class="change_account form-control" name="change_account">
                                <%if accounttype = "Base" then %>
                                <option selected="selected">Base</option>
                                <%else %>
                                <option>Base</option>
                                <%end if %>

                                <%if accounttype = "Mensile" then %>
                                <option selected="selected">Mensile</option>
                                <%else %>
                                <option>Mensile</option>
                                <%end if %>

                                <%if accounttype = "Annuale" then %>
                                <option selected="selected">Annuale</option>
                                <%else %>
                                <option>Annuale</option>
                                <%end if %>
                            </select>
                                    <br />
                                    <br />
                                    Descrizione:
                                    <textarea id="mytextarea" class="form-control" name="description"><%=description %></textarea>
                                    <br />
                                    Metodo di pagamento:
                                    <div>
                                        <div class="col-md-4">
                                            <%if paymentmethod_cash then %>
                                            <input type="checkbox" name="paymentmethod_cash" checked="checked" />
                                            <%else %>
                                            <input type="checkbox" name="paymentmethod_cash" />
                                            <%end if %>
                                            Contanti
                                        </div>
                                        <div class="col-md-4">
                                            <%if paymentmethod_creditcard then %>
                                            <input type="checkbox" name="paymentmethod_creditcard" checked="checked" />
                                            <%else %>
                                            <input type="checkbox" name="paymentmethod_creditcard" />
                                            <%end if %>
                                            Carta di Credito
                                        </div>
                                        <div class="col-md-4">
                                            <%if paymentmethod_bank then %>
                                            <input type="checkbox" name="paymentmethod_bank" checked="checked" />
                                            <%else %>
                                            <input type="checkbox" name="paymentmethod_bank" />
                                            <%end if %>
                                            Bonifico
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                    <%If Session("private_logged") = false Then %>
                                    Modifica url pagina: http://teachme.tips/
                            <input type="text" name="pageUrl" value="<%=pageUrl %>" class="form-control" />
                                    <br />
                                    Nascondi dalla ricerca 
                                    <%If IsPrivate = False Then%>
                                    <input type="checkbox" name="search_availability" />
                                    <%Else %>
                                    <input type="checkbox" name="search_availability" checked="checked" />
                                    <%End If %>
                                    <br />
                                    <%End If %>
                                    <br />
                                    Pagina Facebook: (http://)
                            <input type="text" name="facebook_url" value="<%=facebookpage %>" class="form-control" />
                                    <br />
                                    Indirizzo internet: (http://)
                            <input type="text" name="url" value="<%=url %>" class="form-control" />
                                    <br />
                                    Non disponibile nei giorni:
                                    <br />
                                    <% If InStr(not_avaliable_days,"1") > 0 Then %>
                                    <input type="checkbox" name="monday" checked="checked" />
                                    Luned&igrave;
                                    <% Else %>
                                    <input type="checkbox" name="monday" />
                                    Luned&igrave;
                                    <% End If %>
                                    <% If InStr(not_avaliable_days,"2") > 0 Then %>
                                    <input type="checkbox" name="tuesday" checked="checked" />
                                    Marted&igrave;
                                    <% Else %>
                                    <input type="checkbox" name="tuesday" />
                                    Marted&igrave;
                                    <% End If %>
                                    <% If InStr(not_avaliable_days,"3") > 0 Then %>
                                    <input type="checkbox" name="wednesday" checked="checked" />
                                    Mercoled&igrave;
                                    <% Else %>
                                    <input type="checkbox" name="wednesday" />
                                    Mercoled&igrave;
                                    <% End If %>
                                    <% If InStr(not_avaliable_days,"4") > 0 Then %>
                                    <input type="checkbox" name="thursday" checked="checked" />
                                    Gioved&igrave;
                                    <% Else %>
                                    <input type="checkbox" name="thursday" />
                                    Gioved&igrave;
                                    <% End If %>
                                    <% If InStr(not_avaliable_days,"5") > 0 Then %>
                                    <input type="checkbox" name="friday" checked="checked" />
                                    Venerd&igrave;
                                    <% Else %>
                                    <input type="checkbox" name="friday" />
                                    Venerd&igrave;
                                    <% End If %>
                                    <% If InStr(not_avaliable_days,"6") > 0 Then %>
                                    <input type="checkbox" name="satursay" checked="checked" />
                                    Sabato
                                    <% Else %>
                                    <input type="checkbox" name="satursay" />
                                    Sabato
                                    <% End If %>
                                    <% If InStr(not_avaliable_days,"0") > 0 Then %>
                                    <input type="checkbox" name="sunday" checked="checked" />
                                    Domenica
                                    <% Else %>
                                    <input type="checkbox" name="sunday" />
                                    Domenica
                                    <% End If %>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Save changes">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form class="form-horizontal change_admin_form" role="form" name="change_account_form" method="post" action="../../Controllers/Class_Lesson/InsertEvent.asp">
                        <input type="hidden" name="private_id" value="<%=private_id %>" />
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel2">Crea Corso</h4>
                        </div>
                        <div class="modal-body" style="overflow: auto;">
                            <div class="col-md-12">
                                <div class="form-group">
                                    Categoria Corso:
                                    <select name="cls" class="form-control">
                                        <option></option>
                                        <option value="1">Business</option>
                                        <option value="2">Arti Creative</option>
                                        <option value="3">Arti Culinarie</option>
                                        <option value="4">Educazioni</option>
                                        <option value="5">Salute e Benessere</option>
                                        <option value="6">Tecnologia</option>
                                        <option value="9">Bambini</option>
                                        <option value="10">Stile di vita</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    Nome Corso:
                                <input type="text" class="form-control" name="class_name" />
                                </div>
                                <div class="form-group">
                                    Numero Partecipanti:
                                <input type="text" class="form-control" name="class_menber_number" />
                                </div>
                                <div class="form-group">
                                    <div class='input-group date' id='datetimepicker6'>
                                        Data Inizio Corso:
                                            <input type='text' class="form-control" />
                                        <input type='hidden' class="form-control" name="class_datestart" id="class_datestart" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class='input-group date' id='datetimepicker7'>
                                        Data Fine Corso:
                                            <input type='text' class="form-control" />
                                        <input type='hidden' class="form-control" name="class_dateend" id="class_dateend" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    $(function () {
                                        $('#datetimepicker6').datetimepicker({ format: 'DD/MM/YYYY HH:MM:ss' });
                                        $('#datetimepicker7').datetimepicker({ format: 'DD/MM/YYYY HH:MM:ss' });
                                        $("#datetimepicker6").on("dp.change", function (e) {
                                            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
                                            $(this).find("#class_datestart").val(e.date.format().substring(0,19));
                                        });
                                        $("#datetimepicker7").on("dp.change", function (e) {
                                            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
                                            $(this).find("#class_dateend").val(e.date.format().substring(0,19));
                                        });
                                    });
                                </script>
                                <div class="form-group">
                                    Prezzo per persona:
                                <input type="text" class="form-control" name="class_price" />
                                </div>
                                <div class="form-group">
                                    Dove:
                                <input type="text" class="form-control" name="class_place" />
                                </div>
                                <div class="form-group">
                                    Descrizione:
                                <textarea name="class_description" class="form-control"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Crea">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!--<form class="form-horizontal change_admin_form" role="form" name="select_schoolsubject_form" method="post" action="../../Controllers/SchoolSubjects/SelectSchoolSubjects.asp">
                        <input type="hidden" name="private_id" value="<%=private_id %>" />
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel3">Scegli tra le materie esistenti</h4>
                        </div>
                        <div class="modal-body" style="overflow: auto;">
                            <div class="col-md-12">
                                <div class="form-group">
                                    Materie:
                                    <select name="ss">
                                        <%
                                            query_di_interrogazione="SELECT SchoolSubjectID, SchoolSubject.Name+'(' +Class.Name+')' as Name FROM (SchoolSubject INNER JOIN Class ON Class.ClassId = SchoolSubject.ClassId)" 
	                                        recordset.Open query_di_interrogazione,connessione
                                            If Not recordset.EOF Then
                                                Do While Not recordset.eof
                                        %>
                                        <option value="<%=recordset("SchoolSubjectID") %>"><%=recordset("Name") %></option>
                                        <%
                                                    recordset.movenext
                                                Loop
                                            End If
                                            recordset.Close
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Aggiungi">
                        </div>
                    </form>-->
                    <form class="form-horizontal change_admin_form" role="form" name="insert_schoolsubject_form" method="post" action="../../Controllers/SchoolSubjects/InsertSchoolSubjects.asp">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel3">Inserisci una nuova materia</h4>
                        </div>
                        <div class="modal-body" style="overflow: auto;">
                            <input type="hidden" name="privateID" value="<%=private_id %>" />
                            <div class="col-md-12">
                                <div class="form-group">
                                    <select class="form-control ss_category" name="ss_category">
                                        <option></option>
                                        <option value="1">materie scolastiche</option>
                                        <option value="2">lingue straniere</option>
                                        <option value="3">area musicale</option>
                                        <option value="4">informatica</option>
                                        <option value="5">arti varie</option>
                                    </select>
                                    Nome Materia:
                                    <!--<input type="text" class="form-control" name="ss_name" />-->
                                    <select class="form-control ss_name" name="ss_name">
                                        <option></option>
                                        <option class='class_1' value='agronomia'>agronomia</option>
                                        <option class='class_1' value='aiuto compiti'>aiuto compiti</option>
                                        <option class='class_1' value='aiuto tesi'>aiuto tesi</option>
                                        <option class='class_1' value='algebra'>algebra</option>
                                        <option class='class_1' value='alimentazione'>alimentazione</option>
                                        <option class='class_1' value='analisi 1'>analisi 1</option>
                                        <option class='class_1' value='analisi 2'>analisi 2</option>
                                        <option class='class_1' value='analisi dei dati'>analisi dei dati</option>
                                        <option class='class_1' value='anatomia 1'>anatomia 1</option>
                                        <option class='class_1' value='anatomia 2'>anatomia 2</option>
                                        <option class='class_1' value='anatomia comparata'>anatomia comparata</option>
                                        <option class='class_1' value='astrologia'>astrologia</option>
                                        <option class='class_1' value='astronomia'>astronomia</option>
                                        <option class='class_1' value='automazione'>automazione</option>
                                        <option class='class_1' value='biochimica'>biochimica</option>
                                        <option class='class_1' value='biologia'>biologia</option>
                                        <option class='class_1' value='biotecnologia'>biotecnologia</option>
                                        <option class='class_1' value='botanica'>botanica</option>
                                        <option class='class_1' value='chimica'>chimica</option>
                                        <option class='class_1' value='complementi di matematica'>complementi di matematica</option>
                                        <option class='class_1' value='contabilità e bilancio'>contabilità e bilancio</option>
                                        <option class='class_1' value='controlli automatici'>controlli automatici</option>
                                        <option class='class_1' value='controllo di gestione'>controllo di gestione</option>
                                        <option class='class_1' value='costruzione del business plan'>costruzione del business plan</option>
                                        <option class='class_1' value='costruzioni'>costruzioni</option>
                                        <option class='class_1' value='diritto'>diritto</option>
                                        <option class='class_1' value='diritto assicurativo'>diritto assicurativo</option>
                                        <option class='class_1' value='diritto bancario'>diritto bancario</option>
                                        <option class='class_1' value='diritto civile'>diritto civile</option>
                                        <option class='class_1' value='diritto commerciale'>diritto commerciale</option>
                                        <option class='class_1' value='diritto costituzionale'>diritto costituzionale</option>
                                        <option class='class_1' value='diritto del lavoro'>diritto del lavoro</option>
                                        <option class='class_1' value='diritto di famiglia'>diritto di famiglia</option>
                                        <option class='class_1' value='diritto penale'>diritto penale</option>
                                        <option class='class_1' value='diritto privato'>diritto privato</option>
                                        <option class='class_1' value='diritto processuale'>diritto processuale</option>
                                        <option class='class_1' value='diritto pubblico'>diritto pubblico</option>
                                        <option class='class_1' value='diritto tributario'>diritto tributario</option>
                                        <option class='class_1' value='disegno artistico'>disegno artistico</option>
                                        <option class='class_1' value='disegno industriale'>disegno industriale</option>
                                        <option class='class_1' value='disegno tecnico'>disegno tecnico</option>
                                        <option class='class_1' value='ecologia'>ecologia</option>
                                        <option class='class_1' value='econometria'>econometria</option>
                                        <option class='class_1' value='economia aziendale'>economia aziendale</option>
                                        <option class='class_1' value='economia industriale'>economia industriale</option>
                                        <option class='class_1' value='economia internazionale'>economia internazionale</option>
                                        <option class='class_1' value='economia politica'>economia politica</option>
                                        <option class='class_1' value='economia pubblica'>economia pubblica</option>
                                        <option class='class_1' value='economia regionale'>economia regionale</option>
                                        <option class='class_1' value='elementi di laboratorio odontotecnico'>elementi di laboratorio odontotecnico</option>
                                        <option class='class_1' value='elettronica'>elettronica</option>
                                        <option class='class_1' value='elettrotecnica'>elettrotecnica</option>
                                        <option class='class_1' value='enologia'>enologia</option>
                                        <option class='class_1' value='estimo'>estimo</option>
                                        <option class='class_1' value='filologia'>filologia</option>
                                        <option class='class_1' value='filologia germanica'>filologia germanica</option>
                                        <option class='class_1' value='filosofia'>filosofia</option>
                                        <option class='class_1' value='finanza matematica'>finanza matematica</option>
                                        <option class='class_1' value='fisica'>fisica</option>
                                        <option class='class_1' value='fisica 1'>fisica 1</option>
                                        <option class='class_1' value='fisica 2'>fisica 2</option>
                                        <option class='class_1' value='fisica dei materiali'>fisica dei materiali</option>
                                        <option class='class_1' value='fisiologia'>fisiologia</option>
                                        <option class='class_1' value='fisiologia vegetale'>fisiologia vegetale</option>
                                        <option class='class_1' value='francese'>francese</option>
                                        <option class='class_1' value='genetica'>genetica</option>
                                        <option class='class_1' value='geografia'>geografia</option>
                                        <option class='class_1' value='geologia'>geologia</option>
                                        <option class='class_1' value='geometria'>geometria</option>
                                        <option class='class_1' value='geometria descrittiva'>geometria descrittiva</option>
                                        <option class='class_1' value='geometria proiettiva'>geometria proiettiva</option>
                                        <option class='class_1' value='gnatologia'>gnatologia</option>
                                        <option class='class_1' value='greco'>greco</option>
                                        <option class='class_1' value='idraulica'>idraulica</option>
                                        <option class='class_1' value='igiene'>igiene</option>
                                        <option class='class_1' value='impianti energetici'>impianti energetici</option>
                                        <option class='class_1' value='impianti industriali'>impianti industriali</option>
                                        <option class='class_1' value='informatica'>informatica</option>
                                        <option class='class_1' value='inglese'>inglese</option>
                                        <option class='class_1' value='italiano'>italiano</option>
                                        <option class='class_1' value='latino'>latino</option>
                                        <option class='class_1' value='logica binaria'>logica binaria</option>
                                        <option class='class_1' value='logistica '>logistica </option>
                                        <option class='class_1' value='macroeconomia'>macroeconomia</option>
                                        <option class='class_1' value='marketing'>marketing</option>
                                        <option class='class_1' value='matematica'>matematica</option>
                                        <option class='class_1' value='matematica applicata'>matematica applicata</option>
                                        <option class='class_1' value='matematica finanziaria'>matematica finanziaria</option>
                                        <option class='class_1' value='materie aeronautiche'>materie aeronautiche</option>
                                        <option class='class_1' value='meccanica'>meccanica</option>
                                        <option class='class_1' value='meccanica razionale'>meccanica razionale</option>
                                        <option class='class_1' value='microeconomia'>microeconomia</option>
                                        <option class='class_1' value='ottica'>ottica</option>
                                        <option class='class_1' value='patologia'>patologia</option>
                                        <option class='class_1' value='pedagogia'>pedagogia</option>
                                        <option class='class_1' value='politica economica'>politica economica</option>
                                        <option class='class_1' value='progettazione architettonica'>progettazione architettonica</option>
                                        <option class='class_1' value='progettazione multimediale'>progettazione multimediale</option>
                                        <option class='class_1' value='psicologia'>psicologia</option>
                                        <option class='class_1' value='psicometrica'>psicometrica</option>
                                        <option class='class_1' value='radiologia'>radiologia</option>
                                        <option class='class_1' value='ragioneria'>ragioneria</option>
                                        <option class='class_1' value='relazioni internazionali'>relazioni internazionali</option>
                                        <option class='class_1' value='religione'>religione</option>
                                        <option class='class_1' value='scienze'>scienze</option>
                                        <option class='class_1' value='scienze della navigazione'>scienze della navigazione</option>
                                        <option class='class_1' value='scienze della terra'>scienze della terra</option>
                                        <option class='class_1' value='scienze delle costruzioni'>scienze delle costruzioni</option>
                                        <option class='class_1' value='scienze delle finanze'>scienze delle finanze</option>
                                        <option class='class_1' value='scienze umane'>scienze umane</option>
                                        <option class='class_1' value='sistemi e automazione'>sistemi e automazione</option>
                                        <option class='class_1' value='sistemi informativi'>sistemi informativi</option>
                                        <option class='class_1' value='sociologia'>sociologia</option>
                                        <option class='class_1' value='software stata'>software stata</option>
                                        <option class='class_1' value='spagnolo'>spagnolo</option>
                                        <option class='class_1' value='statistica e probabilità'>statistica e probabilità</option>
                                        <option class='class_1' value='storia'>storia</option>
                                        <option class='class_1' value='storia dellarte'>storia dell'arte</option>
                                        <option class='class_1' value='storia economica'>storia economica</option>
                                        <option class='class_1' value='tecnica degli strumenti assicurativi'>tecnica degli strumenti assicurativi</option>
                                        <option class='class_1' value='tecnica degli strumenti finanziari'>tecnica degli strumenti finanziari</option>
                                        <option class='class_1' value='tecnica delle costruzioni'>tecnica delle costruzioni</option>
                                        <option class='class_1' value='tecnica turistica'>tecnica turistica</option>
                                        <option class='class_1' value='tecnologia farmaceutica'>tecnologia farmaceutica</option>
                                        <option class='class_1' value='tecnologie chimiche industriali'>tecnologie chimiche industriali</option>
                                        <option class='class_1' value='tecnologie dei processi di produzione'>tecnologie dei processi di produzione</option>
                                        <option class='class_1' value='tecnologie della comunicazione'>tecnologie della comunicazione</option>
                                        <option class='class_1' value='tedesco'>tedesco</option>
                                        <option class='class_1' value='telecomunicazioni'>telecomunicazioni</option>
                                        <option class='class_1' value='topografia'>topografia</option>
                                        <option class='class_1' value='zoologia'>zoologia</option>
                                        <option class='class_2' value='albanese'>albanese</option>
                                        <option class='class_2' value='arabo'>arabo</option>
                                        <option class='class_2' value='brasiliano'>brasiliano</option>
                                        <option class='class_2' value='bulgaro'>bulgaro</option>
                                        <option class='class_2' value='catalano'>catalano</option>
                                        <option class='class_2' value='cinese'>cinese</option>
                                        <option class='class_2' value='coreano'>coreano</option>
                                        <option class='class_2' value='croato'>croato</option>
                                        <option class='class_2' value='finlandese'>finlandese</option>
                                        <option class='class_2' value='francese A1'>francese A1</option>
                                        <option class='class_2' value='francese A2'>francese A2</option>
                                        <option class='class_2' value='francese B1'>francese B1</option>
                                        <option class='class_2' value='francese B2'>francese B2</option>
                                        <option class='class_2' value='francese C1'>francese C1</option>
                                        <option class='class_2' value='francese C2'>francese C2</option>
                                        <option class='class_2' value='giapponese'>giapponese</option>
                                        <option class='class_2' value='greco moderno'>greco moderno</option>
                                        <option class='class_2' value='greco moderno'>greco moderno</option>
                                        <option class='class_2' value='inglese A1'>inglese A1</option>
                                        <option class='class_2' value='inglese A2'>inglese A2</option>
                                        <option class='class_2' value='inglese B1'>inglese B1</option>
                                        <option class='class_2' value='inglese B2'>inglese B2</option>
                                        <option class='class_2' value='inglese C1'>inglese C1</option>
                                        <option class='class_2' value='inglese C2'>inglese C2</option>
                                        <option class='class_2' value='italiano per stranieri'>italiano per stranieri</option>
                                        <option class='class_2' value='norvegese'>norvegese</option>
                                        <option class='class_2' value='olandese'>olandese</option>
                                        <option class='class_2' value='polacco'>polacco</option>
                                        <option class='class_2' value='portoghese'>portoghese</option>
                                        <option class='class_2' value='rumeno'>rumeno</option>
                                        <option class='class_2' value='russo'>russo</option>
                                        <option class='class_2' value='serbo'>serbo</option>
                                        <option class='class_2' value='spagnolo A1'>spagnolo A1</option>
                                        <option class='class_2' value='spagnolo A2'>spagnolo A2</option>
                                        <option class='class_2' value='spagnolo B1'>spagnolo B1</option>
                                        <option class='class_2' value='spagnolo B2'>spagnolo B2</option>
                                        <option class='class_2' value='spagnolo C1'>spagnolo C1</option>
                                        <option class='class_2' value='spagnolo C2'>spagnolo C2</option>
                                        <option class='class_2' value='svedese'>svedese</option>
                                        <option class='class_2' value='tedesco A1'>tedesco A1</option>
                                        <option class='class_2' value='tedesco A2'>tedesco A2</option>
                                        <option class='class_2' value='tedesco B1'>tedesco B1</option>
                                        <option class='class_2' value='tedesco B2'>tedesco B2</option>
                                        <option class='class_2' value='tedesco C1'>tedesco C1</option>
                                        <option class='class_2' value='tedesco C2'>tedesco C2</option>
                                        <option class='class_2' value='turco'>turco</option>
                                        <option class='class_2' value='ucraino'>ucraino</option>
                                        <option class='class_2' value='ungherese'>ungherese</option>
                                        <option class='class_2' value='vietnamita'>vietnamita</option>
                                        <option class='class_3' value='armonia'>armonia</option>
                                        <option class='class_3' value='arrangiamento per chitarra'>arrangiamento per chitarra</option>
                                        <option class='class_3' value='basso'>basso</option>
                                        <option class='class_3' value='batteria'>batteria</option>
                                        <option class='class_3' value='canto lirico'>canto lirico</option>
                                        <option class='class_3' value='canto moderno'>canto moderno</option>
                                        <option class='class_3' value='chitarra acustica'>chitarra acustica</option>
                                        <option class='class_3' value='chitarra classica'>chitarra classica</option>
                                        <option class='class_3' value='chitarra elettrica'>chitarra elettrica</option>
                                        <option class='class_3' value='chitarra per insegnanti'>chitarra per insegnanti</option>
                                        <option class='class_3' value='clarinetto'>clarinetto</option>
                                        <option class='class_3' value='composizione'>composizione</option>
                                        <option class='class_3' value='contrappunto'>contrappunto</option>
                                        <option class='class_3' value='corno'>corno</option>
                                        <option class='class_3' value='flauto traverso'>flauto traverso</option>
                                        <option class='class_3' value='flicorno'>flicorno</option>
                                        <option class='class_3' value='improvvisazione'>improvvisazione</option>
                                        <option class='class_3' value='musica da camera'>musica da camera</option>
                                        <option class='class_3' value='musica elettronica'>musica elettronica</option>
                                        <option class='class_3' value='ottoni'>ottoni</option>
                                        <option class='class_3' value='pianoforte'>pianoforte</option>
                                        <option class='class_3' value='propedeutica musicale'>propedeutica musicale</option>
                                        <option class='class_3' value='sassofono'>sassofono</option>
                                        <option class='class_3' value='storia del jazz'>storia del jazz</option>
                                        <option class='class_3' value='storia della musica'>storia della musica</option>
                                        <option class='class_3' value='tastiera'>tastiera</option>
                                        <option class='class_3' value='teoria e solfeggio'>teoria e solfeggio</option>
                                        <option class='class_3' value='teoria musicale'>teoria musicale</option>
                                        <option class='class_3' value='tromba'>tromba</option>
                                        <option class='class_3' value='trombone'>trombone</option>
                                        <option class='class_3' value='tuba'>tuba</option>
                                        <option class='class_3' value='violino'>violino</option>
                                        <option class='class_3' value='violoncello'>violoncello</option>
                                        <option class='class_4' value='3D studio max'>3D studio max</option>
                                        <option class='class_4' value='access'>access</option>
                                        <option class='class_4' value='arduino'>arduino</option>
                                        <option class='class_4' value='autocad 2D'>autocad 2D</option>
                                        <option class='class_4' value='autocad 3D'>autocad 3D</option>
                                        <option class='class_5' value='cabaret'>cabaret</option>
                                        <option class='class_4' value='CAD schemi elettrici / PCB'>CAD schemi elettrici / PCB</option>
                                        <option class='class_4' value='cinema 4D'>cinema 4D</option>
                                        <option class='class_4' value='computer'>computer</option>
                                        <option class='class_4' value='dialux'>dialux</option>
                                        <option class='class_4' value='ECDL'>ECDL</option>
                                        <option class='class_4' value='excel'>excel</option>
                                        <option class='class_5' value='falegnameria'>falegnameria</option>
                                        <option class='class_4' value='GIMP elaborazione immagini'>GIMP elaborazione immagini</option>
                                        <option class='class_5' value='giornalismo'>giornalismo</option>
                                        <option class='class_4' value='grafica'>grafica</option>
                                        <option class='class_4' value='Hardware'>Hardware</option>
                                        <option class='class_4' value='illuminotecnica'>illuminotecnica</option>
                                        <option class='class_4' value='illustrator'>illustrator</option>
                                        <option class='class_4' value='indesign'>indesign</option>
                                        <option class='class_4' value='informatica'>informatica</option>
                                        <option class='class_4' value='infrastrutture di trasporto'>infrastrutture di trasporto</option>
                                        <option class='class_4' value='ingegneria del software'>ingegneria del software</option>
                                        <option class='class_4' value='internet'>internet</option>
                                        <option class='class_4' value='inventor'>inventor</option>
                                        <option class='class_4' value='joomla'>joomla</option>
                                        <option class='class_4' value='linux'>linux</option>
                                        <option class='class_1' value='metodo di studio'>metodo di studio</option>
                                        <option class='class_4' value='networking'>networking</option>
                                        <option class='class_4' value='office'>office</option>
                                        <option class='class_4' value='OpenOffice Base'>OpenOffice Base</option>
                                        <option class='class_4' value='photoshop'>photoshop</option>
                                        <option class='class_5' value='pittura'>pittura</option>
                                        <option class='class_4' value='power point'>power point</option>
                                        <option class='class_4' value='premiere pro'>premiere pro</option>
                                        <option class='class_4' value='programmazione C'>programmazione C</option>
                                        <option class='class_4' value='programmazione C++'>programmazione C++</option>
                                        <option class='class_4' value='programmazione html'>programmazione html</option>
                                        <option class='class_4' value='programmazione Java'>programmazione Java</option>
                                        <option class='class_4' value='programmazione mysql'>programmazione mysql</option>
                                        <option class='class_4' value='programmazione php'>programmazione php</option>
                                        <option class='class_4' value='programmazione PLC'>programmazione PLC</option>
                                        <option class='class_5' value='recitazione'>recitazione</option>
                                        <option class='class_4' value='rendering'>rendering</option>
                                        <option class='class_5' value='restauro'>restauro</option>
                                        <option class='class_4' value='revit architecture'>revit architecture</option>
                                        <option class='class_1' value='ricerca operativa'>ricerca operativa</option>
                                        <option class='class_5' value='scrittura'>scrittura</option>
                                        <option class='class_5' value='fotografia'>fotografia</option>
                                        <option class='class_4' value='sistemi informativi geografici'>sistemi informativi geografici</option>
                                        <option class='class_4' value='sketchup'>sketchup</option>
                                        <option class='class_1' value='sostegno DSA'>sostegno DSA</option>
                                        <option class='class_5' value='storia del cinema'>storia del cinema</option>
                                        <option class='class_5' value='storia del teatro'>storia del teatro</option>
                                        <option class='class_5' value='recitazione'>recitazione</option>
                                        <option class='class_4' value='word'>word</option>
                                        <option class='class_4' value='wordpress'>wordpress</option>
                                        <option class='class_2' value='inglese per bambini ( fino 6 anni )'>inglese per bambini ( fino 6 anni )</option>
                                        <option class='class_2' value='tedesco per bambini (fino 6 anni )'>tedesco per bambini (fino 6 anni )</option>
                                        <option class='class_2' value='francese per bambini (fino 6 anni )'>francese per bambini (fino 6 anni )</option>
                                        <option class='class_5' value='cucinare primi'>cucinare primi</option>
                                        <option class='class_5' value='cucinare secondi'>cucinare secondi</option>
                                    </select>
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
                                    <input type="text" class="form-control" name="ss_price" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Aggiungi">
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <%Else %>
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
        <%End If %>
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
