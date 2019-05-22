<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>jQuery UI Datepicker - Display inline</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Design Bootstrap -->
        <link href="css/mdb.min.css" rel="stylesheet">
        <!-- Your custom styles (optional) -->
        <link href="css/style.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="./img/loading.gif" sizes="16x16">
        <link href="css/style.css" rel="stylesheet">
        <script type="text/javascript">
            {literal}
                $(function () {

                    //traducción del calendario
                    $.datepicker.regional['es'] = {
                        closeText: 'Cerrar',
                        prevText: '< Ant',
                        nextText: 'Sig >',
                        currentText: 'Hoy',
                        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                        monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
                        dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
                        dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
                        weekHeader: 'Sm',
                        dateFormat: 'dd/mm/yy',
                        firstDay: 1,
                        isRTL: false,
                        showMonthAfterYear: false,
                        yearSuffix: ''
                    };

                    $.datepicker.setDefaults($.datepicker.regional['es']);

                    var disabledDates = ['13/05/2019', '10/05/2019']; //Este array lo recogere desde PHP; es un array de las fechas que el usuario y ha reservado

                    //opciones del datepicker
                    $("#datepicker").datepicker({
                        minDate: '0', //quita los dias anteriores del dia actual	
                        showButtonPanel: true, //boton de HOY
                        beforeShowDay: function (date) {
                            var string = $.datepicker.formatDate('dd/mm/yy', date);
                            return [disabledDates.indexOf(string) == -1]
                        }, //elimino los dias del array que le paso
                        onSelect: function (date) {
                            alert(date); //recojo el valor del select
                            window.location.href = "?date=" + date; //valor que le paso al div y lor recojo en PHP
                        }
                    });


                });
                function obtengoHora() { //funcion con la que obtengo la hora del select
                    var hora = $('select').val(); //recojo el valor del select
                    alert(hora);
                    window.location.href = "?hora=" + hora; //valor que le paso al div y lor recojo en PHP
                }

            {/literal}
        </script>
        <style>
            #contenidoPrincipal{
                margin-left: 15%;
                margin-right: 15%;
            }
        </style>
    </head>
    <body>
        <div>
            <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark top-nav-collapse">
                <div class="container">
                    <a class="navbar-brand" href="" target="_blank">
                        <strong>FUTMATCH</strong>
                    </a>
                    <button id = "hamburguesa" class="navbar-toggler float-left" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <ul id='imgperfil'  class="nav navbar-nav navbar-right">
                        <a data-toggle="modal" data-target="#exampleModal">{$perfil}</a>
                    </ul>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="pabellones.php">Pabellones
                                    <span class="sr-only">(current)</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        <br><br><br><br>
        <div id="contenidoPrincipal">
            <h2 class="h1-responsive font-weight-bold text-center pat">Nuestra historia</h2>
            <!-- Section description -->
            <p class=" text-center mx-auto mb-5">
                Todo comenzó tras años trabajando, se nos ocurrio la idea de crear nuestra propia empresa 
                de desarollo y diseño con nuestr   a propia identidad, capaz de amoldrse 
                a nuestros clientes y hacer sus sueños realidad.
                Nuestros sueños son tus sueños.
            </p>

            <!--Aqui solo mostraré habilitados las horas que no esten cogidas de ese día-->
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"> 
                    <div class = 'view zoom'>
                        <div id="datepicker"></div>
                        <select name="ab" onchange="obtengoHora();">
                            <option value='' id='hora'>-- --</option>
                            {$select}
                        </select>
                        <a href="calendario.php" data-toggle="modal"  class="btn btn-primary" data-target="#exampleModal2" >PROCEDER A LA RESERVA</a>
                    </div>
                </div>

            </div>
        </div>
        <!---------------- Modal -------------------->
        <!---------------- Modal -------------------->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel" style="margin-left:40%">MI PERFIL</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="text-center" style="margin-top:5%">{$foto_modal}</div>
                    <div class="modal-body" style="padding-left:10%; padding-right:10%; ">
                        User: {$nombre}
                        <br>
                        Email: {$email}
                        <br>
                        Password {$pass}
                        <br>
                        Nombre completo: {$nombreC}
                        <br>
                        Fecha de Nacimiento: {$fecha}
                        <br>
                        Dirección: {$direccion}

                    </div>
                    <div class="modal-footer" style="justify-content: center">
                        <form method = 'POST' action = 'pabellones.php'>
                            <input type = 'submit' type='submit' class='btn btn-primary' name = 'desconectar' value = 'desconectar'>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL DE CONFIRMACION-->
        <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title " id="exampleModalLabel" style="margin-left:30%">TUS PREFERENCIAS</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="text-center" style="margin-top:5%">Estas seguro de que quieres reservar?</div>
                    <div class="modal-body" style="padding-left:10%; padding-right:10%; ">

                        <div class="modal-footer" style="justify-content: center">
                            <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
                                <input name="cmd" type="hidden" value="_cart" />
                                <input name="upload" type="hidden" value="1" />
                                <input name="business" type="hidden" value="pgmcastillo98-facilitator@gmail.com" />
                                <input name="shopping_url" type="hidden" value="http://localhost/proyecto_final/calendario.php" />
                                <input name="currency_code" type="hidden" value="EUR" />
                                <input name="return" type="hidden" value="http://localhost/proyecto_final/calendario.php" />
                                <input name="notify_url" type="hidden" value="http://localhost/proyecto_final/calendario.php" />
                                <input name="rm" type="hidden" value="2" />
                                <input type="image" src="http://www.paypal.com/es_ES/i/btn/x-click-but01.gif" border="0" name="submit" alt="Realice pagos con PayPal: es rápido, gratis y seguro">
                                {$hiddenPay}
                            </form>
                            <form action="calendario.php" method='post'>
                                <input type="submit"  class="btn btn-primary" name="cancelar" value="CANCELAR">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!---------------- Modal -------------------->
        <!---------------- Modal -------------------->
        <script type="text/javascript" src="js/popper.min.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="js/mdb.min.js"></script>
        <!-- Initializations -->
        <script type="text/javascript">
            // Animations initialization
            new WOW().init();
        </script>
    </body>
</html>