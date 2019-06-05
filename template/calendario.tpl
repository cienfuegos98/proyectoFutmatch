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
                        dateFormat: 'yy/mm/dd',
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
                            var fecha = document.getElementById("datepicker").value;

                            var data = {'fecha': fecha};
                            $.ajax({
                                type: "post",
                                url: 'index3.php',
                                data: data,
                                success: function (response) {
                                    $('#fechamodal').html(fecha);
                                    $('#respuesta').html(response);
                                }
                            });
                            return false;
                        }
                    });
                });
            </script>
            <script>

                function getval(sel) {

                    var data = {
                        'hora': sel.value
                    };

                    $.ajax({
                        type: "post",
                        url: 'index3.php',
                        data: data,
                        success: function (response) {
                            $('#respuesta2').html(response);
                            $('#horamodal').html(sel.value);
                        }
                    });
                    return false;
                }
                function dis(valor) {
                    if (valor.value === '--Selecciona hora--') {
                        $('#a_modal').attr("disabled", true);
                    } else {
                        $('#a_modal').attr("disabled", false);

                    }
                }

            </script>

        {/literal}
        <style>
            #contenidoPrincipal{
                margin-left: 15%;
                margin-right: 15%;
            }
            #enlace_borrar{
                color: #4285f4;
                font-size: 15px;
            }

            #enlace_borrar:hover{
                color:  #4285b1;
                font-size: 17px;
            }
        </style>
    </head>
    <body>
        <div>
            <nav  class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark header">
                <div class="container enlacesNav">
                    <!-- Brand -->
                    <a class="navbar-brand" >
                        <img src="img/logoNegativo.png" class="logo">
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
        <br><br>
        <section class="portadaPabellones text-center w-100 row mx-0">
            <h1 class="col-12 text-center h1-responsive font-weight-bold text-center my-5 pat white-text">{$nombrePab}</h1>
            <p class="subtitulo white-text text-center mx-auto mb-5">Aqui os adjuntamos nuestros proyectos tanto web como corporativos, realizados desde la creación de la empresa
                hasta la actualidad y nuestras 4 mejores ventas ordenadas por el precio.</p>
        </section>

        <section class="separadorGrande"></section>
        <section class="row seccionMargenes">
            <div class="container">
                <div class="card">
                    <div class="container-fliud">
                        <div class="wrapper row">
                            <div class="col-md-12">

                                <div class=" imgPr">
                                    <div class="productImg" style="background-image: url({$imagen})"></div>
                                </div>
                            </div>
                            <div class="details col-md-12 col-xl-7 col-lg-6">
                                <h3 class="product-title">{$nombrePab}</h3>
                                <h5>{$categoria}</h5>

                                <p class="product-description">{$descripcion}</p>
                                <h4 class="price"><span>{$tarifa} </span></h4>
                                <strong>Más información:</strong>
                                <p>Dirección: {$direccionP}</br>
                                    Ciudad: {$ciudad}</br>
                                    Codigo postal: {$cod_postal}</br>
                                    Telefono: {$telefono}</br>
                                    Otros servicios:{$otros_servicios}</br>
                                    Accesibilidad: {$accesibilidad}</br>
                                </p>

                            </div>
                            <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12"> 
                                <div class="mx-auto text-center">
                                    <div class="input-group date my-5" data-provide="datepicker" id="datepicker"></div>
                                    <div id="respuesta"></div>
                                    <div id="respuesta2"></div>
                                    <button disabled href="calendario.php" data-toggle="modal" id="a_modal" class="btn btn-primary mx-auto" data-target="#exampleModal2" >PROCEDER A LA RESERVA</button>
                                    <!--<a id="a_modal" class="btn btn-primary">PROCEDER A LA RESERVA</a>-->
                                    <section class="separadorGrande"></section>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <section class="separadorGrande"></section>    
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
            <div class="modal fade show" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title " id="exampleModalLabel" style="margin-left:30%">TUS PREFERENCIAS</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="text-center" style="margin-top:5%">Estas seguro de que quieres reservar?</div>
                        <div class="modal-body text-center">
                            <div class="row justify-content-center w-20">
                                <div class=" float-left">
                                    Fecha de la reserva: <div id="fechamodal"></div>
                                    Hora de la reserva: <div id="horamodal"></div>
                                    En el pabellon: {$nombrePab}
                                </div>
                                <div class="modal-footer" style="justify-content: center">
                                    <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
                                        <input name="cmd" type="hidden" value="_cart" />
                                        <input name="upload" type="hidden" value="1" />
                                        <input name="business" type="hidden" value="pgmcastillo98-facilitator@gmail.com" />
                                        <input name="shopping_url" type="hidden" value="http://localhost/proyecto_fin/reservas.php" />
                                        <input name="currency_code" type="hidden" value="EUR" />
                                        <input name="return" type="hidden" value="http://localhost/proyecto_fin/reservas.php" />
                                        <input name="notify_url" type="hidden" value="http://localhost/proyecto_fin/reservas.php" />
                                        <input name="rm" type="hidden" value="2" />
                                        <input type="submit" class="btn btn-primary" name="paypal" alt="Realice pagos con PayPal: es rápido, gratis y seguro" value="REALIZAR PAGO">
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
                                {$contenidoModal}
                            </div>
                            <div class="modal-footer" style="justify-content: center">
                                <form method = 'POST' action = 'pabellones.php'>
                                    <a class='btn btn-primary' href = 'reservas.php' >Modificar</a>
                                    <input type = 'submit' type='submit' class='btn btn-primary' name = 'desconectar' value = 'desconectar'>
                                    <div class="text-center" >
                                        <a data-toggle="modal" data-target="#exampleModal2" id="enlace_borrar">Eliminar cuenta</a>
                                    </div>
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
                            <div class="text-center" style="margin-top:5%">Estas seguro de que quieres borrar tu cuenta?
                                Despues de ello no podrás acceder con tu usuario a nuestra web y tendrás que volver a registrarte.</div>
                            <div class="modal-body" style="padding-left:10%; padding-right:10%; ">
                                <div class="row justify-content-center">
                                    <form action="pabellones.php" method='post'>
                                        <button type="submit"  class="btn btn-primary" name="aceptar" >ACEPTAR </button>
                                    </form>
                                    <button type="submit"  class="btn btn-primary" name="cancelar" class="close" data-dismiss="modal" aria-label="Close">CANCELAR</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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