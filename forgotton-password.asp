<!--#include file="sitemaster_top.asp"-->
<div class="container">
    <div class="col-md-12 row">
        Inserisci l'email che utilizzi per effettuare l'accesso a Teach.me, ti inviere la tua password quanto prima.
    </div>
    <form class="form-horizontal form-without-legend" role="form" name="forgotton_password_form" method="post" action="../../Controllers/Account/forgotton-password_page.asp">
        <div class="form-group">
            <label for="email" class="col-lg-12">Email <span class="require">*</span></label>
            <div class="col-lg-12">
                <input type="text" class="form-control" id="email" name="email">
            </div>
        </div>
        <div>
            <div class="col-lg-8 padding-left-0 padding-top-20" style="padding-bottom:40px;">
                <button type="submit" class="btn btn-primary">Login</button>
            </div>
        </div>
    </form>
</div>
<!--#include file="sitemaster_bottom.html"-->
