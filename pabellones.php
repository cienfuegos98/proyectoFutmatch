<?php

error_reporting(0);
session_start();
require_once "Smarty.class.php";

spl_autoload_register(function($clase) {
    include $clase . '.php';
});

$plantilla = new Smarty();
$plantilla->template_dir = "./template";
$plantilla->compile_dir = "./template_c";

$con = new BD();



if (empty($_SESSION['usuario'])) {
    $plantilla->assign('tipo', '');
    $loginNav = "<li class='nav-item '>
                    <a class='nav-link' href='index.php'>Login
                        <span class='sr-only'>(current)</span>
                    </a>
                 </li>";
    $foroNav = '';
    $perfil = "<a href='index.php'><img  src='./img/imgperfiles/user.png' height='40' width='40' class='rounded-circle hoverable img-responsive'></a>";
} else {


    if (isset($_SESSION['tipo'])) {
        $tipo = $_SESSION['tipo'];
        $plantilla->assign('tipo', $tipo);
    }
    $foroNav = "<li class='nav-item '>
                    <a class='nav-link' href='comentarios.php'>Foro
                        <span class='sr-only'>(current)</span>
                    </a>
                 </li>";

    $user = $_SESSION['usuario']['nombre'];
    $pass = $_SESSION['usuario']['pass'];

    if ($_SESSION['tipo'] == "pabellon") {

        $pabs = "SELECT * FROM `pabellones` as p JOIN `usuarios` as u ON p.pid = u.uid WHERE `user` = '$user'";
        $datospab = $con->selection($pabs);

        $nombreC = $datospab[0]['nombre'];
        $direccion = $datospab[0]['direccion'];
        $pid_pab = $datospab[0]['pid'];
        $nombrePab = $datospab[0]['nombre'];
        $foto = $datospab[0]['foto'];


        $contenidoModal = " User: $user <br> Nombre completo: $nombreC<br>Dirección: $direccion";

        $perfil = "<img src='" . $foto . "' class='imgperfil rounded-circle hoverable img-responsive'>";
        $foto_modal = "<img src='" . $foto . "' class='imgmodal rounded-circle hoverable img-responsive'>";

        $plantilla->assign('contenidoModal', $contenidoModal);
    } else if ($_SESSION['tipo'] == "user") {

        $c = "SELECT * FROM `jugadores` as j JOIN `usuarios` as u ON j.uid = u.uid WHERE `user` = '$user'";
        $datos = $con->selection($c);
        $uid = $datos[0]['uid'];
        $foto = $datos[0]['foto'];
        $email = $datos[0]['email'];
        $fecha_nac = $datos[0]['fecha_nacimiento'];
        $nombreC = $datos[0]['nombre_completo'];
        $direccion = $datos[0]['direccion'];

        $perfil = "<img src='" . $foto . "' class='imgperfil rounded-circle hoverable img-responsive'>";
        $foto_modal = "<img src='" . $foto . "' class='imgmodal rounded-circle hoverable img-responsive'>";

        $contenidoModal = " User: $user
                        <br>
                        Email: $email
                        <br>
                       
                        Nombre completo: $nombreC
                        <br>
                        Fecha de Nacimiento: $fecha_nac
                        <br>
                        Dirección: $direccion";

        if (isset($_POST['aceptarBorrar'])) {
            $con->eliminarCuenta($uid);
            session_destroy();
            header("Location:index.php");
        }
        $load = "";
        if (!isset($_SESSION['auxiliar'])) {
            $q = "SELECT * FROM `reservas` WHERE uid = '$uid' AND fecha_reserva = '" . date("Y-m-d") . "' AND hora > " . date("G") . " ORDER BY hora ASC";
            $datosRe = $con->selection($q);
            if (isset($datosRe[0])) {
                $fecha = $datosRe[0]['fecha_reserva'];

                $hora = $datosRe[0]['hora'];
            }
            $f = date("d-m-Y", strtotime($fecha));
            $load = "onload=alerta('$f',$hora)";

            $_SESSION['auxiliar'] = true;
        }
        $plantilla->assign('load', $load);
    }

    $plantilla->assign('contenidoModal', $contenidoModal);
    $plantilla->assign('foto_modal', $foto_modal);
    $loginNav = "";
}
$plantilla->assign('perfil', $perfil);
$plantilla->assign('foroNav', $foroNav);
$plantilla->assign('loginNav', $loginNav);

if (isset($_POST ['desconectar'])) {
    $loginNav = "<li class = 'nav-item '>
                    <a class = 'nav-link' href = 'index.php'>Login
                    <span class = 'sr-only'>(current)</span>
                    </a>
                    </li>";
    $perfil = "<a href = 'index.php'><img src = './img/user.png' height = '40' width = '40' class = 'rounded-circle hoverable img-responsive'></a>";
    $plantilla->assign('perfil', $perfil);
    $plantilla->assign('loginNav', $loginNav);
    $plantilla->assign('foroNav', '');
    session_destroy();
    header("Location:index.php");
}

$c = "SELECT * FROM `usuarios` as u JOIN `pabellones` as p ON p.pid = u.uid";
$datos = $con->selection($c);
$listadoPabellones = '';

foreach ($datos as $pabellones) {
    $pid = $pabellones['pid'];
    if (isset($_SESSION['tipo'])) {
        if ($_SESSION['tipo'] == 'user') {
            $action = "action = 'calendario.php'";
        } else if ($pid == $pid_pab) {
            $action = "action = 'reservas.php'";
        } else {
            $action = "";
        }
    } else {
        $action = "action = 'calendario.php'";
    }
    $listadoPabellones .= "
                    <div class = 'col-lg-4 col-md-6 mb-lg-0 mb-4 pabellon'>
                    <div class = 'card collection-card z-depth-1-half'>
                    <div class=' zoom-1 overflow-hidden'>
                    <div class = 'view zoom'>
                    <form $action method = 'post' id = 'form_" . $pid . "' >
                    <input type = 'hidden' name = 'pid' value = '" . $pid . "' >
                    <a class = 'enlace'>
                    <img style = 'width:100%' src = '" . $pabellones['imagen_web'] . "' class = 'img-fluid' alt = 'Imagen del" . $pabellones['nombre'] . "' >
                    </a>
                    </form>
                    </div>
                    <div class = 'stripe dark'>
                    <a>
                    <div class = 'expandable fototxt'>
                    <h3 class='text-left'>" . $pabellones['nombre'] . "</h3>
                        <hr>
                    <p class='text-left'>" . $pabellones['descripcion'] . "</p>
                    </div>
                    </a>
                    </div>
                    </div>
                    </div>
                    </div>";
}
$con->cerrar();

$plantilla->assign('listadoPabellones', $listadoPabellones);
$plantilla->display("pabellones.tpl");
?>