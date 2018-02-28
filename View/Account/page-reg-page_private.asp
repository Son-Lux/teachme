<!--#include virtual="\sitemaster_top.asp"-->
<div class="main">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li class="active">Registrazione</li>
        </ul>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!-- BEGIN SIDEBAR -->
            <!--<div class="sidebar col-md-3 col-sm-3">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>Login/Register</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>Restore Password</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>My account</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>Address book</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>Wish list</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>Returns</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i>Newsletter</a></li>
                </ul>
            </div>-->
            <!-- END SIDEBAR -->

            <!-- BEGIN CONTENT -->
            <div class="col-md-12 col-sm-12">
                <div class="content-form-page">
                    <div class="row">
                        <div class="col-md-7 col-sm-7">
                            <form class="form-horizontal form_private" role="form" name="private_registration_form" method="post" action="../../Controllers/Register/register_private.asp">
                                <h1>Registra private</h1>
                                <fieldset>
                                    <legend>I tuoi dati</legend>
                                    <div class="form-group">
                                        <label for="firstname" class="col-lg-4 control-label">Nome <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control" id="firstname" name="name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="lastname" class="col-lg-4 control-label">Cognome <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control" id="lastname" name="surname">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="age" class="col-lg-4 control-label">Et&agrave; <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <select name="age" id="age">
                                                <option value="13">13</option>
                                                <option value="14">14</option>
                                                <option value="15">15</option>
                                                <option value="16">16</option>
                                                <option value="17">17</option>
                                                <option value="18">18</option>
                                                <option value="19">19</option>
                                                <option value="20">20</option>
                                                <option value="21">21</option>
                                                <option value="22">22</option>
                                                <option value="23">23</option>
                                                <option value="24">24</option>
                                                <option value="25">25</option>
                                                <option value="26">26</option>
                                                <option value="27">27</option>
                                                <option value="28">28</option>
                                                <option value="29">29</option>
                                                <option value="30">30</option>
                                                <option value="31">31</option>
                                                <option value="32">32</option>
                                                <option value="33">33</option>
                                                <option value="34">34</option>
                                                <option value="35">35</option>
                                                <option value="36">36</option>
                                                <option value="37">37</option>
                                                <option value="38">38</option>
                                                <option value="39">39</option>
                                                <option value="40">40</option>
                                                <option value="41">41</option>
                                                <option value="42">42</option>
                                                <option value="43">43</option>
                                                <option value="44">44</option>
                                                <option value="45">45</option>
                                                <option value="46">46</option>
                                                <option value="47">47</option>
                                                <option value="48">48</option>
                                                <option value="49">49</option>
                                                <option value="50">50</option>
                                                <option value="51">51</option>
                                                <option value="52">52</option>
                                                <option value="53">53</option>
                                                <option value="54">54</option>
                                                <option value="55">55</option>
                                                <option value="56">56</option>
                                                <option value="57">57</option>
                                                <option value="58">58</option>
                                                <option value="59">59</option>
                                                <option value="60">60</option>
                                                <option value="61">61</option>
                                                <option value="62">62</option>
                                                <option value="63">63</option>
                                                <option value="64">64</option>
                                                <option value="65">65</option>
                                                <option value="66">66</option>
                                                <option value="67">67</option>
                                                <option value="68">68</option>
                                                <option value="69">69</option>
                                                <option value="70">70</option>
                                                <option value="71">71</option>
                                                <option value="72">72</option>
                                                <option value="73">73</option>
                                                <option value="74">74</option>
                                                <option value="75">75</option>
                                                <option value="76">76</option>
                                                <option value="77">77</option>
                                                <option value="78">78</option>
                                                <option value="79">79</option>
                                                <option value="80">80</option>
                                                <option value="81">81</option>
                                                <option value="82">82</option>
                                                <option value="83">83</option>
                                                <option value="84">84</option>
                                                <option value="85">85</option>
                                                <option value="86">86</option>
                                                <option value="87">87</option>
                                                <option value="88">88</option>
                                                <option value="89">89</option>
                                                <option value="90">90</option>
                                                <option value="91">91</option>
                                                <option value="92">92</option>
                                                <option value="93">93</option>
                                                <option value="94">94</option>
                                                <option value="95">95</option>
                                                <option value="96">96</option>
                                                <option value="97">97</option>
                                                <option value="98">98</option>
                                                <option value="99">99</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="firstname" class="col-lg-4 control-label">Codice Fiscale <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control" id="cf" name="cf">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="firstname" class="col-lg-4 control-label">Cellulare <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control" id="mobile" name="mobile">
                                        </div>
                                    </div>
                                </fieldset>
                                <fieldset>
                                    <legend>Credenziali</legend>
                                    <div class="form-group">
                                        <label for="email" class="col-lg-4 control-label">Email <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control" id="email" name="email">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="col-lg-4 control-label">Password <span class="require">*</span></label>
                                        <div class="col-lg-8">
                                            <input type="password" class="form-control" id="password" name="password">
                                        </div>
                                    </div>
                                </fieldset>
                                <fieldset>
                                    <legend>Dove abiti?</legend>
                                    <input type="text" name="coord" id="coord" style="display: none;">
                                    <div class="col-lg-8">
                                        <input type="text" class="form-control" id="pac-input" name="pac-input" placeholder="Indirizzo">
                                    </div>
                                    <div id="map-canvas" style="width: 100%; height: 248px;"></div>
                                </fieldset>
                                <div class="row">
                                    <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                                        <a href="#" class="register-submit-ctrl btn btn-primary"><span style="color: #FFF;">Registra</span></a>
                                        <input class="register-submit" type="submit" value="registra" style="display: none;">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </div>
</div>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script type="text/javascript">
    function initialize() {

        var markers = [];
        var map = new google.maps.Map(document.getElementById("map-canvas"), {
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        var defaultBounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(-33.8902, 151.1759),
            new google.maps.LatLng(-33.8474, 151.2631));
        map.fitBounds(defaultBounds);

        // Create the search box and link it to the UI element.
        var input = /** @type {HTMLInputElement} */(
            document.getElementById('pac-input'));
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        var searchBox = new google.maps.places.SearchBox(
          /** @type {HTMLInputElement} */(input));

        // [START region_getplaces]
        // Listen for the event fired when the user selects an item from the
        // pick list. Retrieve the matching places for that item.
        google.maps.event.addListener(searchBox, 'places_changed', function () {
            var places = searchBox.getPlaces();

            if (places.length == 0) {
                return;
            }
            for (var i = 0, marker; marker = markers[i]; i++) {
                marker.setMap(null);
            }

            // For each place, get the icon, place name, and location.
            markers = [];
            var bounds = new google.maps.LatLngBounds();
            for (var i = 0, place; place = places[i]; i++) {
                var image = {
                    url: place.icon,
                    size: new google.maps.Size(71, 71),
                    origin: new google.maps.Point(0, 0),
                    anchor: new google.maps.Point(17, 34),
                    scaledSize: new google.maps.Size(25, 25)
                };

                // Create a marker for each place.
                var marker = new google.maps.Marker({
                    map: map,
                    icon: image,
                    title: place.name,
                    position: place.geometry.location
                });
                $("#coord").val(marker.position.toString().replace("(", "").replace(")", ""));

                markers.push(marker);

                bounds.extend(place.geometry.location);
            }

            map.fitBounds(bounds);
        });
        // [END region_getplaces]

        // Bias the SearchBox results towards places that are within the bounds of the
        // current map's viewport.
        google.maps.event.addListener(map, 'bounds_changed', function () {
            var bounds = map.getBounds();
            searchBox.setBounds(bounds);
        });
    }

    google.maps.event.addDomListener(window, 'load', initialize);

</script>
<script>
    $(function(){
        //controlli pre invio
        $(".register-submit-ctrl").click(function(){
            if( $("#name").val()=="" ||
                $("#surname").val()=="" ||
                $("#age").val()=="" ||
                $("#email").val()=="" ||
                $("#password").val()=="" ||
                $("#coord").val()=="" ||
                $("#cf").val()=="" ||
                $("#mobile").val()=="" ||
                $("#pac-input").val()==""){
                alert("Compila tutti i campi della form di registrazione");
            }
            else {
                $(".register-submit").click();
            }
        });
    });
</script>
<!--#include virtual="\sitemaster_bottom.html"-->
